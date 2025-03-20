using Catalog as service from '../../srv/Catalog';


annotate service.POs with @(
    UI.SelectionFields: [
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        CURRENCY_code,
        GROSS_AMOUNT,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY
    ],

    UI.LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: PO_ID
        // Label:'PurchaseOrder Item'
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.COMPANY_NAME
        },
        {
            $Type: 'UI.DataField',
            Value: CURRENCY_code
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.ADDRESS_GUID.COUNTRY
        },
        {
            $Type      : 'UI.DataField',
            Value      : overallstatus,
            Criticality: criticallity
        },
        {
            $Type : 'UI.DataFieldForAction',
            Inline: false,
            Label : 'Boost',
            Action: 'Catalog.boost',
        }
    ],
    UI.HeaderInfo     : {
        TypeName      : 'Purchase order',
        TypeNamePlural: 'Purchase Orders',
        Title         : {Value: PO_ID},
        Description   : {Value: PARTNER_GUID.COMPANY_NAME},
        ImageUrl      : 'https://www.gesi.org/wp-content/uploads/2024/08/purepng.com-ibm-logologobrand-logoiconslogos-251519939176ka7y8.png'
    },
    UI.Facets         : [
        {
        $Type : 'UI.CollectionFacet',
        ID    : 'idparent',
        Label : 'More Information',
        Facets: [{
            $Type : 'UI.ReferenceFacet',
            Label    : 'More_Info',
            Target: '@UI.Identification'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Pricing',
            Target: '@UI.FieldGroup#Facet1'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Status',
            Target: '@UI.FieldGroup#Facet2'
        }

        ]
    },
    {
        $Type : 'UI.ReferenceFacet',
        Label:'Products',
        Target : 'Items/@UI.LineItem',
    }
    ],
    UI.Identification : [
        {
            $Type: 'UI.DataField',
            Value: PO_ID,
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID_NODE_KEY,
            Label: 'Node_key'
        },
        {
            $Type      : 'UI.DataField',
            Value      : overallstatus,
            Criticality: criticallity,
            Label      : 'Status'
        },
    ],
    UI.FieldGroup#Facet1: {
        Label: 'Pricing',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: GROSS_AMOUNT
            },
            {
                $Type: 'UI.DataField',
                Value: NET_AMOUNT
            },
            {
                $Type: 'UI.DataField',
                Value: TAX_AMOUNT
            },
        ]
    },
    UI.FieldGroup#Facet2: {
        Label: 'Status',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: LIFECYCLE_STATUS
            },
            {
                $Type: 'UI.DataField',
                Value: CURRENCY_code
            },
            {
                $Type: 'UI.DataField',
                Value: PARTNER_GUID.ADDRESS_GUID.COUNTRY
            },
        ]
    }

);

annotate service.PurchaseOrderItems with @(
    UI.LineItem:[
        {
            $Type:'UI.DataField',
            Value:PO_ITEM_POS
        },
        {
            $Type:'UI.DataField',
            Value:PRODUCT_GUID_NODE_KEY
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID.Price,
        },
        {
            $Type:'UI.DataField',
            Value:PRODUCT_GUID.Description
        },
        {
            $Type:'UI.DataField',
            Value:GROSS_AMOUNT
        },
        {
            $Type:'UI.DataField',
            Value:CURRENCY_code
        },
    ],
    UI.HeaderInfo:{
        TypeName : 'Product',
        TypeNamePlural : 'Productss',
        Title : {Value: PO_ITEM_POS},
        Description:{Value:PRODUCT_GUID.Description},
        ImageUrl : 'https://www.gesi.org/wp-content/uploads/2024/08/purepng.com-ibm-logologobrand-logoiconslogos-251519939176ka7y8.png'
    },
    UI.Facets:[
        {
           $Type : 'UI.CollectionFacet',
           ID : 'idchild',
           Label : 'More infor', 
           Facets : [
               {
                   $Type : 'UI.ReferenceFacet',
                   Target : '@UI.FieldGroup#Facet3',
               },
           ],
        },
        
    ],
    UI.FieldGroup#Facet3: {
        Label: 'Pricing',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: GROSS_AMOUNT
            },
            {
                $Type: 'UI.DataField',
                Value: NET_AMOUNT
            },
            {
                $Type: 'UI.DataField',
                Value: TAX_AMOUNT
            },
        ]
    }
);

//Value Help
annotate Catalog.POs with {
    PARTNER_GUID@(
        Common:{
            Text : PARTNER_GUID.COMPANY_NAME,
        },
        ValueList.entity: catalog.BusinessPartnerSet
    )
};


annotate Catalog.PurchaseOrderItems with {
    PRODUCT_GUID@(
        Common:{
            Text : PRODUCT_GUID.Description,
        },
        ValueList.entity: catalog.CProductValuesView
    )
};


@cds.odata.valuelist
annotate Catalog.BusinessPartnerSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : COMPANY_NAME,
    }]
);

@cds.odata.valuelist
annotate Catalog.CProductValuesView with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : Description,
    }]
);
