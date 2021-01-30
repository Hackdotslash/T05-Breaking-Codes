const comFun = require('../commonFunctions')
const jwt    = require('jwt-simple');
const moment = require('moment');
const multer = require('multer');

module.exports = (app)=>{

    const verifyMail            = require('./verifyMail');
    const forgotPassword        = require('./forgotPassword');
    const diseasePredict        = require('./diseasePredict');

    /* VERIFY MAIL */
    app.post('/verify',verifyMail.VerifyMail);
    app.get('/verify/:token',verifyMail.verifyMailToken);
    /* VERIFY MAIL */


    /*PASSWORD CHANGE ROUTES */
    app.post('/forgot_pass',forgotPassword.password_reset);
    app.get('/resetpassword/:id',forgotPassword.reset_password_get);
    app.post('/resetpassword',forgotPassword.reset_pass_post);
    /*PASSWORD CHANGE ROUTES */

    app.post('/update_password',comFun.jwtAuth,forgotPassword.updPassword);


    /*MAIN APP ROUTES */
    app.post('/disease',diseasePredict.disease_predict);

    /*MAIN APP ROUTES */



    /*ADMIN ROUTES */

    /*ADMIN ROUTES */


    //Only for testing so that I dont have to generate a token to hit a route
    app.post('/generatePermanentToken',(req,res,next)=>{
        let a  = {
            userId:"DEMO",
            expiry_date:moment().add(10,"years").format("YYYY-MM-DDTHH:mm:ss.SSS")
        }
        let token = jwt.encode(a,"Secret")
        res.json({success:1,token:token})
        return next()
    })
}
