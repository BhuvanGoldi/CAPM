//const { data } = require("@sap/cds/lib/dbs/cds-deploy");

module.exports = cds.service.impl(async function () {
    const {EmployeeSet,POs} = this.entities;
    this.before('UPDATE',EmployeeSet,(req)=>{
        if(req.data.salaryAmount>=100000){
            req.error(500,'too much salary, validation failed');
        }
    });

    this.on('boost', async (req,res) => {
        try {       
            console.log("request is  "+req +"  ")   
            const ID = req.params[0];
            console.log(res);
            console.log("Hey Amigo, Your purchase order with id " + req.params[0].NODE_KEY + " will be boosted");
            const tx = cds.tx(req)
            await tx.update(POs).with({
                GROSS_AMOUNT: { '+=' : 20000 }
            }).where(ID);
            var recq = tx.read(POs).where(ID);
            return recq;
        } catch (error) {
            return "Error " + error.toString();
        }
    });
    const getPriority=(data)=>{
        if(data){
        data.map((record) =>{
            if(record.TAX_AMOUNT>500){
                record.PRIORITY = "HIGH";
            }
            else{
                record.PRIORITY = "LOW";
            }
        }
        );
    }
    };
    this.after('READ',POs,(data)=>{
        getPriority(data);
    });
    this.on('largestOrder', async (req,res) => {
        try {
            const req = req.params[0];
            const tx = cds.tx(req);
            
            //SELECT * UPTO 1 ROW FROM dbtab ORDER BY GROSS_AMOUNT desc
            const reply = await tx.read(POs).orderBy({
                GROSS_AMOUNT: 'desc'
            }).limit(1);

            return reply;
        } catch (error) {
            return "Error " + error.toString();
        }
    });
});