const jwt = require('jsonwebtoken');
const moment = require('moment');

module.exports.adminLogin = (req,res,next) => {
    const username = req.body.username;
    const password = req.body.password;
    if(username==='admin'){
        if(password==='admin') {
            let obj = {
                secret:'ss',
                expiry_date:moment().add(1,"week").format("YYYY-MM-DDTHH:mm:ss.SSS")
            }
            let token = jwt.sign(obj,"Secret");
            res.json({success: 1,message: 'Authentication successful',token:token})
            return next();
        } else {
            res.json({success: 0,message: 'Login failed'})
            return next();
        }
    }else {
        res.json({success: 0,message: 'Login failed'})
        return next();
    }
}