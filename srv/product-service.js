const cds = require("@sap/cds")

module.exports = cds.service.impl(async (srv) => {
  const { ProductAreaForecasts } = srv.entities
  
  srv.before("CREATE", ProductAreaForecasts, async (context) => {
    const resultActive = await SELECT.one(ProductAreaForecasts).orderBy(`forecastNumber desc`)
    const forecastNumber = resultActive ? resultActive.forecastNumber + 1 : 1

    context.data.forecastNumber = context.data.forecastNumber || forecastNumber
  })

  srv.on("forecastArea", async (req) => {
    const mlRuntimeService = await cds.connect.to("MLRuntimeService")

    const forecastID = req.params[0].ID

    const forecastRecord = await SELECT.one.from(ProductAreaForecasts, { ID: forecastID })

    const date = new Date()
    
    const queryDate = date.toISOString().split('T')[0]

    const parameters = {
      system: "DEV",
      queryDate: queryDate,
      queries: [
        {
          modelType: "demo-product-area",
          context: { contextType: "iqc-ml-model", keys: [{ keyName: "model-name", keyValue: "demo-product-area" }] },
          routes: [
            {
              routeID: "route01",
              features: [
                { featureName: "length", featureValue: forecastRecord.length },
                { featureName: "width", featureValue: forecastRecord.width },
                { featureName: "height", featureValue: forecastRecord.height },
                { featureName: "productStyle", featureValue: forecastRecord.productStyle_code },
                { featureName: "flute", featureValue: forecastRecord.flute_code },
              ],
            },
          ],
        },
      ],
    }

    let areaForecast = null

    //only call queryModel endpoint when in cloud ("production")
    if (cds.env.profiles.includes("production")) {
      const result = await mlRuntimeService.queryModel(parameters)
      console.log(result[0].routes[0])
      areaForecast = result[0].routes[0].features[0].featureValue
    } else {
      areaForecast = "0.7321"
      console.log(`ALERT: queryModel endpoint not called in local environment, result has been simulated with return value ${areaForecast}`)
    }

    await UPDATE.entity(ProductAreaForecasts, { ID: forecastID }).with({
      area: areaForecast,
    })
  })
})
