sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'productareaforecastsapp/test/integration/FirstJourney',
		'productareaforecastsapp/test/integration/pages/ProductAreaForecastsList',
		'productareaforecastsapp/test/integration/pages/ProductAreaForecastsObjectPage'
    ],
    function(JourneyRunner, opaJourney, ProductAreaForecastsList, ProductAreaForecastsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('productareaforecastsapp') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheProductAreaForecastsList: ProductAreaForecastsList,
					onTheProductAreaForecastsObjectPage: ProductAreaForecastsObjectPage
                }
            },
            opaJourney.run
        );
    }
);