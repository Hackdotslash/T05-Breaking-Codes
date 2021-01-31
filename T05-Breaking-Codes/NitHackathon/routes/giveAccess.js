const UserM = require('../models/user');
const DoctorM = require('../models/doctor');
const comFun= require('../commonFunctions');
const async = require('async')

module.exports.get_user_docs = function(req,res,next){
    if(!comFun.StrVal(req.body.doctor)){
        res.json({success: 0,message:"No doctor"});
        return next();
    }else {
        let userId = res.locals.userId;
        let docId  = req.body.doctor;
        async.parallel({
            updDoc:function (callback){
                DoctorM.findOneAndUpdate({_id:docId},{$push:{users:userId}},
                    function (err){
                        if(err){
                            return callback(err);
                        }else {
                            return callback()
                        }
                    })
            },
            updUser:function (callback){
                UserM.findOneAndUpdate({_id:userId},{$push:{doctors:userId}},
                    function (err){
                        if(err){
                            return callback(err);
                        }else {
                            return callback()
                        }
                    })
            }
        },function (err){
            if(err){
                res.json({success:0,message:err});
                return next();
            }else {
                res.json({success:1,message:"Success"});
            }
        })
    }
}