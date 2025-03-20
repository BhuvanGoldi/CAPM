using { datamodel.db.master, datamodel.db.transaction } from '../db/datamodel';

service CatalogService @(path:'CatalogService') {

    entity employees as projection on master.employees ;
    entity purchaseorder as projection on transaction.purchaseorder;
}