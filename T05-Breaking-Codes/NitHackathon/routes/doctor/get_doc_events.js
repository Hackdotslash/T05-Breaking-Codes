const EventM = require('../../models/events');
const comFun = require('../../commonFunctions')

module.exports.get_doc_events = (req,res,next)=>{
    let docId = res.locals.userId;
    EventM.find({by:docId},{_id:0,title:1,location:1,date:1,time:1,description:1},function (err,data) {
        if(err){
            console.log(err);
            res.json({success:0,message:"Mongo Error"})
            return next();
        }else if(!comFun.NotNullUndef(data)){
            res.json({success:-10,message:"No events found"})
            return next();
        }else {
            res.json({success:1,message:"Success",events:data})
            return next();
        }

    })
}