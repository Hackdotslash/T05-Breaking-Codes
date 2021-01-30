const comFun = require('../../commonFunctions')
const EventM = require('../../models/events')


module.exports.add_event = (req,res,next)=>{
    if(!comFun.StrVal(req.body.title)){
        res.json({success:0,message:"No title"})
        return next();
    }else if(!comFun.StrVal(req.body.location)){
        res.json({success:0,message:"No location"})
        return next();
    }else if(!comFun.StrVal(req.body.date)){
        res.json({success:0,message:"No date"})
        return next();
    }else if(!comFun.StrVal(req.body.time)){
        res.json({success:0,message:"No time"})
        return next();
    }else if(!comFun.StrVal(req.body.description)){
        res.json({success:0,message:"No description"})
        return next();
    }else {
        let docId = res.locals.userId;
        let e = new EventM({
            title:req.body.title,
            location:req.body.location,
            date:req.body.date,
            time:req.body.time,
            description:req.body.description,
            by:docId,
            status:2
        })
        e.save(function(err){
            if(err){
                res.json({success:0,message:"Mongo Error in saving"});
                return next();
            }else {
                res.json({success:1,message:"Event Created"});
                return next();
            }
        })
    }

}