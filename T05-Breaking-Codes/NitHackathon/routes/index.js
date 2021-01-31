const comFun = require('../commonFunctions')
const jwt    = require('jwt-simple');
const moment = require('moment');
const multer = require('multer');

module.exports = (app)=>{
    const multerMid = multer({
        storage:multer.memoryStorage(),
    })
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
    const change_event_status   = require('./admin/change_event_status');
    const get_patient_vaccines  = require('./doctor/get_patient_vaccines');
    const add_shot              = require('./doctor/add_shot')
    const add_vaccine           = require('./doctor/add_vaccine');
    const get_doc_vaccines      = require('./doctor/get_doc_vaccines');
    const get_vaccines          = require('./get_patient_vaccine');
    const add_docs              = require('./add_docs')
    const get_user_docs         = require('./get_user_docs');
    const give_access           = require('./giveAccess');
    const get_patient_docs      = require('./doctor/get_patient_docs')
    const send_sms              = require('./sendSms');
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
    app.post('/get_vaccines',comFun.jwtAuth,get_vaccines.get_doc_vaccine);
    app.post('/add_docs',comFun.jwtAuth,multerMid.single('file'),add_docs.doc);
    app.post('/get_docs',comFun.jwtAuth,get_user_docs.get_user_docs);
    app.post('/give_access',comFun.jwtAuth,give_access.get_user_docs);
    /*MAIN APP ROUTES */

    /*DOCTOR APP ROUTE */
    app.post('/doctor/add_event',comFun.jwtAuth,add_event.add_event);
    app.post('/doctor/upd_doc',comFun.jwtAuth,upd_doc.upd_doc);
    app.post('/doctor/get_events',comFun.jwtAuth,get_doc_events.get_doc_events)
    app.post('/doctor/get_patient_vaccines',comFun.jwtAuth,get_patient_vaccines.get_patient_vaccine)
    app.post('/doctor/add_shot',comFun.jwtAuth,add_shot.add_event);
    app.post('/doctor/add_vaccine',comFun.jwtAuth,add_vaccine.add_event);
    app.post('/doctor/get_doc_vaccines',comFun.jwtAuth,get_doc_vaccines.get_doc_vaccine);
    app.post('/doctor/get_patient_docs',comFun.jwtAuth,get_patient_docs.get_user_docs);
    /*DOCTOR APP ROUTE */

    /*ADMIN ROUTES */
    app.post('/admin/login',admin_login.adminLogin)
    app.post('/admin/get_events',comFun.adminAuth,get_admin_events.getEvents);
    app.post('/admin/change_event_status',comFun.adminAuth,change_event_status.change_event_status)
    /*ADMIN ROUTES */



    app.post('/sendSms',send_sms.sendSms)
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
