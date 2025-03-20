namespace cap2;

using { commons } from './commons';
using { temporal,managed,cuid } from '@sap/cds/common';


context master
{
    entity student : commons.address
    {
        key id : commons.guid;
        firstname : String(64);
        lastname : String(64);
        age : Int16;
        class : Association to one standard;
    }

    entity standard
    {
        key id : commons.guid;
        semister : Integer;
        specialization : String(64);
        hod : String(32);
    }
    entity books {
        key id: commons.guid;
        bookName: localized String(128);
        author: String(64);
    }
}
context transaction {
    entity subs : cuid ,temporal ,managed {
        book: Association to one master.books;
        student: Association to one master.student;
    }
}