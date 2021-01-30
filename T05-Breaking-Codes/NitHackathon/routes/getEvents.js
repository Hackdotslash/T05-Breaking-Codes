const Events = require('../models/events')
const comFun = require('../commonFunctions')
module.exports.getEvents = (req,res,next)=>{
    Events.aggregate([{
        $match:{status:1}
    },
        {
            $lookup:
                {
                    from: 'doctors',
                    localField:'by',
                    foreignField: '_id',
                    as: 'doc_details'
                }
        },
        {
            $project:{_id:0,title:1,location:1,date:1,time:1,description:1,'doc_details.name':1}
        }
    ],(err,data)=>{
        if(err){
            res.json({success:0,message:"Mongo Error"});
            return next();
        }else if(data.length ===0) {
            res.json({success:-10,message:"No events"});
            return next();
        }else {
            res.json({success:1,message:"Success",events:data});
            return next();
        }

    })
}