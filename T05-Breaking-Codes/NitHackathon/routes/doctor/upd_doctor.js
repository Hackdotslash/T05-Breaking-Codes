const comFun = require('../../commonFunctions');
const Doctor = require('../../models/doctor');

module.exports.upd_doc = (req,res,next)=>{
    if(!comFun.NotNullUndef(req.body)){
        res.json({success:0,message:"Empty Body"})
        return next();
    }else {
        let updObj = {};
        let isUpd = false;
        let docId = res.locals.userId;
        if(comFun.StrVal(req.body.specialization)){
            updObj.specialization = req.body.specialization;
            isUpd=true;
        }
        if(comFun.StrVal(req.body.address)){
            updObj.address = req.body.address;
            isUpd=true;
        }
        if(comFun.StrVal(req.body.pincode)){
            updObj.pincode = req.body.pincode;
            isUpd=true;
        }
        if(comFun.StrVal(req.body.name)){
            updObj.name = req.body.name;
            isUpd=true;
        }
        if(comFun.StrMobVal(req.body.contact)){
            updObj.contact = req.body.contact;
            isUpd=true;
        }
        if(isUpd){
            Doctor.findOneAndUpdate({_id:docId},{$set:updObj},function(err,data){
                if(err){
                    console.log(err);
                    res.json({success:0,message:"MONGO ERROR"})
                    return next();
                }else {
                    res.json({success:1,message:"Updated",doctor:data})
                    return next();
                }
            })
        }else {
            res.json({success:0,message:"NO FIELDS TO UPDATE"});
            return next();
        }
    }
}