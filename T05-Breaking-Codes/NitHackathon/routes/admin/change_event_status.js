const comFun = require('../../commonFunctions');
const EventsM = require('../../models/events');

module.exports.change_event_status = function(req,res,next){
    if(!comFun.StrVal(req.body.eventId)){
        res.json({success:0,message:"No eventId"})
        return next();
    }else if(!comFun.numVal(req.body.status)){
        res.json({success:0,message:"No status"})
        return next();
    }else {
        let eventId = req.body.eventId;
        let status = req.body.status;
        EventsM.findOneAndUpdate({_id:eventId,status:2},{$set:{status:status}},function (err){
            if(err){
                console.log("MONGO ERR",err);
                res.json({success:0,message:"Mongo Error"})
                return next();
            }else {
                res.json({success:1,message:"Event Updated"});
                return next();
            }
        });
    }
}