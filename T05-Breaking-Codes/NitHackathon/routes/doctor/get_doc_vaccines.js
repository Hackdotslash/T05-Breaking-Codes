const vaccineM = require('../../models/vaccine');
const comFun = require('../../commonFunctions')

module.exports.get_doc_vaccine = (req,res,next)=>{
    let docId = res.locals.userId;
    vaccineM.find({doctor:docId},function (err,data) {
        if(err){
            console.log(err);
            res.json({success:0,message:"Mongo Error"})
            return next();
        }else if(data.length===0){
            res.json({success:-10,message:"No vaccine found"})
            return next();
        }else {
            res.json({success:1,message:"Success",vaccines:data})
            return next();
        }

    })
}