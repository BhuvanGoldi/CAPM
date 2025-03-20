module.exports = (srv) => {
    srv.on ('hello',(req)=>{
        let myName = req.data.name;
        return "hello " + myName;
    });
    
    const employeeSrv= cds.entities;
    srv.on("READ",employeeSrv,(req)=>{
        return{
            "ID" : "zumba"
        };
    });
};
