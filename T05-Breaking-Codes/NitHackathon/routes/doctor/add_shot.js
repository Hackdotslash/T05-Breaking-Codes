const comFun = require('../../commonFunctions')
const VaccineM = require('../../models/vaccine')
const async = require('async')

module.exports.add_event = (req,res,next)=>{
    if(!comFun.StrVal(req.body.vaccine)){
        res.json({success:0,message:"No name"})
        return next();
    }else if(!comFun.StrVal(req.body.date)){
        res.json({success:0,message:"No date"})
        return next();
    }else if(!comFun.numVal(req.body.status)){
        res.json({success:0,message:"No status"})
        return next();
    }
    else {
        let vaccine = req.body.vaccine;
        let status = req.body.status;
        let date = req.body.date;
        VaccineM.findOneAndUpdate({_id:vaccine},{$pull:{shots:{date:date}}},
            {new:true},function (err,data1){
                if(err){
                    console.log(err);
                    res.json({success:0,message:"Mongo Error"})
                    return next()
                }else {


                    console.log("AFTER PULL",data1);
                    let pushObj = {date:date,status:status};
                    VaccineM.findOneAndUpdate({_id:vaccine},{$push:{shots:pushObj}},
                        {new:true},
                        function (err,data){
                            if(err){
                                res.json({success:0,message:"Mongo Error"})
                                return next()
                            }else {
                                console.log("AFTER PUSH",data);
                                res.json({success:1,message:"Success"})
                                return next()
                            }
                        })
                }
            })
    }

}