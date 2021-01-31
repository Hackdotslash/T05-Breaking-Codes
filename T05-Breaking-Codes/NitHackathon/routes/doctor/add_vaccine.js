const comFun = require('../../commonFunctions')
const VaccineM = require('../../models/vaccine')


module.exports.add_event = (req,res,next)=>{
    if(!comFun.StrVal(req.body.name)){
        res.json({success:0,message:"No name"})
        return next();
    }else if(!comFun.StrVal(req.body.patient)){
        res.json({success:0,message:"No patient"})
        return next();
    }else if(!comFun.StrVal(req.body.date)){
        res.json({success:0,message:"No date"})
        return next();
    } else {
        let docId = res.locals.userId;
        let reminders = req.body.reminders;
        let shots = [];
        if(comFun.NotNullUndef(reminders)){
            if(comFun.ArrVal(reminders)){
                reminders.forEach(rem=>{
                    let obj = {
                        date:rem,
                        status:0
                    }
                    shots.push(obj)
                })
            }
        }
        let e = new VaccineM({
            name:req.body.name,
            date:req.body.date,
            patient:req.body.patient,
            comments:req.body.comments,
            doctor:docId,
            reminders: reminders,
            shots:shots
        })
        e.save(function(err){
            if(err){
                res.json({success:0,message:"Mongo Error in saving"});
                return next();
            }else {
                res.json({success:1,message:"Vaccine Added"});
                return next();
            }
        })
    }

}