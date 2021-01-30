const Events = require('../models/events')
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
            let arr = [];
            data.forEach(function(dat){
                let obj = {
                    title:dat.title,
                    location:dat.location,
                    date:dat.date,
                    time:dat.time,
                    description:dat.description,
                    doc_details:dat.doc_details[0].name,
                }
                arr.push(obj);
            })
            res.json({success:1,message:"Success",events:arr});
            return next();
        }

    })
}