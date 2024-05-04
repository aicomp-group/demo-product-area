using {sap.common.CodeList, cuid, managed} from '@sap/cds/common';

// === Types ===
type ForecastNumber: Integer;
annotate ForecastNumber with @(title : '{i18n>ForecastNumber}');
type Length: Decimal;
annotate Length with @(title : '{i18n>Length}');
type Width: Decimal;
annotate Width with @(title : '{i18n>Width}');
type Height: Decimal;
annotate Height with @(title : '{i18n>Height}');
type Area: Decimal;
annotate Area with @(title : '{i18n>Area}');
type ProductStyleCode: String(4);
annotate ProductStyleCode with @(title : '{i18n>ProductStyle}');
type FluteCode: String(3);
annotate FluteCode with @(title : '{i18n>Flute}');

// === Code List Types ===

// Product Styles
entity ProductStyles : CodeList {
  key code : ProductStyleCode @(title : '{i18n>ProductStyle}');
}
annotate ProductStyles with {
  code @Common.Text : name;
}

type ProductStyle : Association to ProductStyles;
annotate ProductStyle with @(title : '{i18n>ProductStyle}');

// Flutes
entity Flutes : CodeList {
  key code : FluteCode @(title : '{i18n>Flute}');
}
annotate Flutes with {
  code @Common.Text : name;
}

type Flute : Association to Flutes;
annotate Flute with @(title : '{i18n>Flute}');

// === Entities ===

@assert.unique: {
  forecastNumber: [ forecastNumber ]
}
entity ProductAreaForecasts : cuid, managed {
  forecastNumber: ForecastNumber @readonly;
  length: Length @mandatory;
  width: Width @mandatory;
  height: Height @mandatory;
  productStyle: ProductStyle @mandatory;
  flute: Flute @mandatory;
  area: Area @readonly;
}