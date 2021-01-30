const comFun = require('../../commonFunctions');
const vaccineM = require('../../models/vaccine');

module.exports.get_patient_vaccine = (req,res,next)=>{
    if(!comFun.StrVal(req.body.patient)){
        res.json({success:0,message:"No patient"})
        return next();
    }else {
        vaccineM.find({patient:req.body.patient},function (err,data){
            if(err){
                res.json({success:0,message:"Mongo Error"})
                return next();
            }else if(data.length===0){
                res.json({success:-10,message:"No input found"})
                return next();
            }else {
                res.json({success:1,message:"Success",vaccines:data})
            }
        })
    }
}