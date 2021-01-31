const moment = require('moment');
const jwt = require('jsonwebtoken');

const { Readable } = require('stream');
const async = require('async');
let self = module.exports = {
    StrVal: function (v) {
        let type = typeof v;
        if(type === 'undefined') {
            return false;
        }
        if(v === null) {
            return false;
        }
        if(v === undefined) {
            return false;
        }
        if(type === 'string') {
            return v.length >= 1;
        }
        return false;
    },
    StrMobVal: function (v) {
        let type = typeof v;
        if(type === 'undefined') {
            return false;
        }
        /*if(type=== 'boolean') {
         return false;
         }*/
        if(v === null) {
            return false;
        }
        if(v === undefined) {
            return false;
        }
        if(type === 'string') {
            return v.length === 10;
        }
        return false;
    },
    NotNullUndef: function (v) {
        let type = typeof v;
        if(type === 'undefined') {
            return false;
        }
        if(v === null) {
            return false;
        }
        if(v === undefined) {
            return false;
        }
        return true;
    },
    getCurrTime: function(){
        return moment().utcOffset(330).format("YYYY-MM-DDTHH:mm:ss.SSS");
    },
    numVal: function (v) {
        let type = typeof v;
        if(type === 'undefined') {
            return false;
        }
        if(v === null) {
            return false;
        }
        if(v === undefined) {
            return false;
        }
        if(type === /*'number'*/ 'string' || type === 'number') {
            if(!isNaN(v)) {
                return true;
            }
        }
        return false;
    },
    jwtAuth:function (req,res,next){
        if(self.NotNullUndef(req.headers['x-auth-token'])){
            let token = req.headers['x-auth-token']
            let a = jwt.verify(token,"Secret")
            console.log(a);
            console.log(Date.now());
            if(a.expiry_date>self.getCurrTime()){
                res.locals.userId = a.userId;
                return next();
            } else {
                res.json({success:0,message:"Incorrect Hit"})
                return;
            }
        }else {
            res.json({success:0,message:"Incorrect Hit"})
            return ;
        }
    },
    adminAuth:function (req,res,next){
        if(self.NotNullUndef(req.headers['x-auth-token'])){
            let token = req.headers['x-auth-token']
            let a = jwt.decode(token,"Secret11")
            console.log(a);
            console.log(Date.now())
            if(a.expiry_date>self.getCurrTime() && a.secret === "ss"){
                return next();
            }else {
                res.json({success:0,message:"Incorrect Hit"})
            }
        }else {
            res.json({success:0,message:"Incorrect Hit"})
        }
    },
    ArrVal: function (v) {
        let type = typeof v;
        if(type === 'undefined') {
            return false;
        }
        if(v === null) {
            return false;
        }
        if(v === undefined) {
            return false;
        }
        if(v instanceof Array) {
            if(v.length < 1) {
                return false;
            } else {
                return true;
            }
        }
        return false;
    },

}
