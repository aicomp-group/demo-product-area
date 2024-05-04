using {ProductAreaForecasts as schemaProductAreaForecasts, } from '../db/schema';

@path: 'service/product'
service ProductService {
  entity ProductAreaForecasts as projection on schemaProductAreaForecasts actions {
    @(
      cds.odata.bindingparameter.name: '_it',
      Common.SideEffects             : {TargetProperties: ['_it/area']}
    )
    action forecastArea();
  };
  annotate ProductAreaForecasts with @odata.draft.enabled;

}
