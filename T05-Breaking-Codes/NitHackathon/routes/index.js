const comFun = require('../commonFunctions')
const jwt    = require('jwt-simple');
const moment = require('moment');
const multer = require('multer');

module.exports = (app)=>{

    const verifyMail            = require('./verifyMail');
    const forgotPassword        = require('./forgotPassword');
    const diseasePredict        = require('./diseasePredict');
    const getDoctors            = require('./getDoctors');
    const add_event             = require('./doctor/add_event');
    const get_events            = require('./getEvents');
    const get_doc_events        = require('./doctor/get_doc_events');
    const upd_doc               = require('./doctor/upd_doctor');
    const admin_login           = require('./admin/login');
    const get_admin_events      = require('./admin/get_admin_events');
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
    app.post('/getDoctors',comFun.jwtAuth,getDoctors.getDoctors);
    app.post('/get_events',comFun.jwtAuth,get_events.getEvents);
    /*MAIN APP ROUTES */

    /*DOCTOR APP ROUTE */
    app.post('/doctor/add_event',comFun.jwtAuth,add_event.add_event);
    app.post('/doctor/upd_doc',comFun.jwtAuth,upd_doc.upd_doc);
    app.post('/doctor/get_events',comFun.jwtAuth,get_doc_events.get_doc_events)
    /*DOCTOR APP ROUTE */

    /*ADMIN ROUTES */
    app.post('/admin/login',admin_login.adminLogin)
    app.post('/admin/get_events',comFun.adminAuth,get_admin_events.getEvents);
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
