const UserM = require('../models/user');
const comFun= require('../commonFunctions');

module.exports.get_user_docs = function(req,res,next){
    let userId = res.locals.userId;
    UserM.findById(userId,{_id:0,docs:1},function(err,cb){
        if(err){
            res.json({success:0});
            return next();
        } else if(comFun.ArrVal(cb.docs)){
            res.json({success:1,docs:cb.docs});
        }else {
            res.json({success:-10,message:"NO DATA"})
        }

    })
}