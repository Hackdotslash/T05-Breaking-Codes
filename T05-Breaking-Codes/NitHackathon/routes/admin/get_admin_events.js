const Events = require('../../models/events')

module.exports.getEvents = (req,res,next)=>{
    Events.find({},{_id:1,title:1,location:1,date:1,time:1,description:1,by:1,status:1}
        ,function (err,data){
            if(err){
                res.json({success:0,message:"Mongo Error"});
                return next();
            }else {
                res.json({success:1,message:"Success",events:data});
                return next();
            }
        })
}