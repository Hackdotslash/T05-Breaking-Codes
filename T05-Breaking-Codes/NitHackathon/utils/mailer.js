const nodemailer = require('nodemailer');
const { EventEmitter } = require('events');
const transporter = nodemailer.createTransport({
    service: "Gmail",
    auth:{
        user:process.env.email_address,
        pass:process.env.email_password
    }
});
module.exports = function(email,subject,content) {
   const ee = new EventEmitter()
    let mail = {
        from: process.env.email_address,
        to: email,
        subject:subject,
        html: content
    };
    transporter.sendMail(mail, function(err, data) {
        if (err) {
            ee.emit('error',err);
        } else {
            console.log(data);
            console.log('Mail sent successfully');
            ee.emit('done',1);
        }
    });
    return ee;
};
