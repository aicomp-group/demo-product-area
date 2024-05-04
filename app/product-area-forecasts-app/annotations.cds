using ProductService as service from '../../srv/product-service';

annotate service.ProductAreaForecasts with @(
    UI.HeaderInfo: {
        TypeName      : '{i18n>ProductAreaForecast}',
        TypeNamePlural: '{i18n>ProductAreaForecasts}',
        Title         : {
            $Type: 'UI.DataField',
            Value: forecastNumber
        }
    },
    UI.LineItem  : [
        {
            $Type: 'UI.DataField',
            Value: forecastNumber,
        },
        {
            $Type: 'UI.DataField',
            Value: length,
        },
        {
            $Type: 'UI.DataField',
            Value: width,
        },
        {
            $Type: 'UI.DataField',
            Value: height,
        },
        {
            $Type: 'UI.DataField',
            Value: productStyle_code,
        },
        {
            $Type: 'UI.DataField',
            Value: flute_code,
        },
        {
            $Type: 'UI.DataField',
            Value: area,
        },
    ]
);

annotate service.ProductAreaForecasts with @(
    UI.FieldGroup #GeneratedGroup1: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: forecastNumber,
            },
            {
                $Type: 'UI.DataField',
                Value: length,
            },
            {
                $Type: 'UI.DataField',
                Value: width,
            },
            {
                $Type: 'UI.DataField',
                Value: height,
            },
            {
                $Type: 'UI.DataField',
                Value: productStyle_code,
            },
            {
                $Type: 'UI.DataField',
                Value: flute_code,
            },
            {
                $Type: 'UI.DataField',
                Value: area,
            },
        ],
    },
    UI.Facets                     : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'GeneratedFacet1',
        Label : 'General Information',
        Target: '@UI.FieldGroup#GeneratedGroup1',
    }, ],
    UI.Identification             : [{
        $Type            : 'UI.DataFieldForAction',
        Label            : '{i18n>ForecastArea}',
        Action           : 'ProductService.forecastArea',
        ![@UI.Importance]: #High,
        ![@UI.Hidden]    : {$edmJson: {$Eq: [
            {$Path: 'IsActiveEntity'},
            false
        ]}}
    }]
);
