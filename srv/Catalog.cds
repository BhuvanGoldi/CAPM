using { datamodel.db } from '../db/datamodel';
using { datamodel } from '../db/CDSView';

extend db.transaction.purchaseorder with {
   virtual  PRIORITY: String(20);
};


service Catalog @(path:'Catalog') {

    @Capabilities : { Insertable, Deletable: false }
    entity BusinessPartnerSet as projection on db.master.businesspartner;
    entity AddressSet as projection on db.master.address;
    @readonly
    entity EmployeeSet as projection on db.master.employees;
    //entity ProductSet as projection on db.master.product;
    entity PurchaseOrderItems as projection on db.transaction.poitems;
    entity POs @(odata.draft.enabled: true) as projection on db.transaction.purchaseorder{
        *,
        case OVERALL_STATUS
        when 'P'  then 'Paid'
        when 'A' then 'Accepted'
        when 'R' then 'Rejected'
        when 'N' then 'New'
        end as overallstatus: String(20),

        case OVERALL_STATUS
        when 'P' then 3
        when 'A' then 3        
        when 'R' then 1
        when 'N' then 2
        end as criticallity: Integer,
      //round(GROSS_AMOUNT) as GROSS_AMOUNT: Decimal(10,2),
        Items: redirected to PurchaseOrderItems
    }actions{
        action boost() returns POs;
    };
    function largestOrder() returns array of POs;
    entity CProductValuesView as projection on datamodel.CDSViews.CProductValuesView;
    //entity ProductView as projection on datamodel.CDSViews.ProductView;
    entity ItemView as projection on datamodel.CDSViews.ItemView;

}