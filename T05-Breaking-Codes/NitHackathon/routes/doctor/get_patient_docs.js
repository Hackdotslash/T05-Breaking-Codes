const DoctorM = require('../../models/doctor');
const mongoose = require('mongoose');
module.exports.get_user_docs = function(req,res,next){
    let userId = res.locals.userId;
    DoctorM.aggregate([
        {
            "$match" : {
                "_id" : mongoose.Types.ObjectId(userId)
            }
        },
        {
            "$lookup" : {
                "from" : "users",
                "localField" : "users",
                "foreignField" : "_id",
                "as" : "user_data"
            }
        }
    ],function (err,data){
        if(err){
            res.json({success:0});
            return next();
        } else if(data.length===0){
            console.log(data)
            res.json({success:-10});
            return next();
        }else {
            res.json({success:1,patients:data});
        }
    })
}