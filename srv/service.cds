using { datamodel.db } from '../db/datamodel';


//service definition
service myService @(path:'MyService'){

    function hello(name: String) returns String;

    entity employeeSrv as projection on db.master.employees;
}

