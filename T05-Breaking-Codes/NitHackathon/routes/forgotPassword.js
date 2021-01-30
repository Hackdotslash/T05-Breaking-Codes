//jshint esversion:6

const jwt = require('jsonwebtoken');
const User = require('../models/user');
const mail = require('../utils/mailer');
const sanitize = require("mongo-sanitize");
const comFun = require('../commonFunctions')
const bcrypt = require('bcrypt-node');

module.exports.password_reset = (req,res,next)=>{
    const secret = process.env.forgot_password_secret;
    if (!comFun.StrVal(req.body.email)) {
        res.json({success:0,message:"Email address not found"});
        return next();
    }else {
        User.findOne({
            'local.email': sanitize(req.body.email.toLowerCase())
        },{_id:1},function(err, result) {
            if (err) {
                res.json({success:0,message:"Sorry there is some error"})
                return next();
            }
            if (result == null) {
                res.json({success:0,message:"User not found"})
                return next();
            } else {
                const emailAddress = req.body.email;
                let date = Date.now();
                date += (30 * 60 * 1000);
                const payload = {
                    id: result._id,
                    endDate: date
                };
                let token = jwt.sign(payload, secret);
                console.log(token)
                let link = 'http://35.208.131.201:3000/resetpassword/' + token;
                let content = `<!DOCTYPE html>
                          <html>
                          <body class="fr-no-selection">
                              <p>Dear User,</p>
                              <p>Someone has asked to <span class="il">reset</span> the <span class="il">password</span> for your account.<br>If you did not request a <span class="il">password</span> <span class="il">reset</span>, you can disregard this email.<br>No changes have been made to your account.</p>
                              <p>To <span class="il">reset</span> your <span class="il">password</span>, follow this link (or paste into your browser) within the next 30 minutes:&nbsp;</p>
                              <p><a href="${link}">Click here to reset your password</a></p>
                              <p><br></p>
                              <p>-Team Untangle</p>
                          </body>
                          </html>`
                mail(emailAddress,'Password Reset',content)
                    .on('error',function (s){
                        res.json({success:0,message:"Mail not sent"})
                        return next();
                    })
                    .on('done',function (s) {
                        res.json({success:1,message:"Password Reset Mail Sent Successfully"});
                        return next()
                    });
            }
        });
    }
}


module.exports.reset_password_get = function(req, res) {
    const secret = process.env.forgot_password_secret;
    console.log(req.params.id);
    let id = req.params.id;
    let payload = jwt.decode(id,secret)
    console.log("PAYLOAD",payload);
    if (payload.endDate < Date.now()) {
        return res.send("Invalid Link");
    } else {
        res.render('forgot.ejs', {
            payload: payload,
            token: id
        });
    }
}

module.exports.reset_pass_post =  function(req, res) {
    var secret = process.env.forgot_password_secret;
    const token = req.body.token
    const payload = jwt.decode(token,secret)
    if(payload.id===req.body.id){
        let pass = bcrypt.hashSync(req.body.password, bcrypt.genSaltSync(8), null);
        User.findOneAndUpdate({_id:sanitize(req.body.id)},
            {$set:{'local.password':pass}},
            {new:true,projection:{'local.email':1,_id:0}},
            function(err, result) {
                if (err) {
                    return returnErr(res, "Error", "Our server ran into an error please try again")
                }
                if (result == null) {
                    return returnErr(res, "Invalid Link", "Please check the link you're trying to reach")
                } else {
                    let content = '<!DOCTYPE html>\n' +
                        '<html>\n' +
                        '\n' +
                        '<body class="fr-no-selection">\n' +
                        '    <p>Dear User,</p>\n' +
                        '    <p>Your password has been successfully reset.</p>\n' +
                        '    <p><br></p>\n' +
                        '    <p>If this change wasn&#39;t made by you contact support or mail us at</p>\n' +
                        '    <p>admin@bechdaal.tech</p>\n' +
                        '    <p><br></p>\n' +
                        '    <p>-Team Bech Daal</p>\n' +
                        '</body>\n' +
                        '\n' +
                        '</html>'
                    mail(result.local.email,'Password Changed',content)
                        .on('error',function (s){
                            res.json({success:0,message:"Mail not sent"})
                            return next();
                        })
                        .on('done',function (s) {
                            res.json({success:1,message:"Password Reset Mail Sent Successfully"});
                            return next()
                        });
                }
            });
    }
}

module.exports.updPassword = (req, res,next)=> {
    if(!comFun.StrVal(req.body.id)){
        console.error("No user id")
        res.json({success:0,message:"Error"})
        return next()
    }
    else if(!comFun.StrVal(req.body.password)){
        console.error("No password")
        res.json({success:0,message:"Error"})
        return next()
    }else{
        User.findOneAndUpdate({_id:sanitize(req.body.id)},
            {$set:{'local.password':generateHash(req.body.password)}},
            function(err, result) {
                if (err) {
                    res.json({success:0,message:"Sorry there is some error"})
                    return next();
                }
                if (result == null) {
                    res.json({success:0,message:"User not found"})
                    return next();
                } else {
                    let content = '<!DOCTYPE html>\n' +
                        '<html>\n' +
                        '\n' +
                        '<body class="fr-no-selection">\n' +
                        '    <p>Dear User,</p>\n' +
                        '    <p>Your password has been successfully reset.</p>\n' +
                        '    <p><br></p>\n' +
                        '    <p>If this change wasn&#39;t made by you contact support or mail us at</p>\n' +
                        '    <p>admin@bechdaal.tech</p>\n' +
                        '    <p><br></p>\n' +
                        '    <p>-Team Bech Daal</p>\n' +
                        '</body>\n' +
                        '\n' +
                        '</html>'
                    //Here we are not checking for email error as it might increase user wait time
                    mail(result.local.email,'Password Changed',content)
                    res.send({success:1,message:"Password changed successfully"});
                    return next();
                }
            });
    }
}
function generateHash(password) {
    return bcrypt.hashSync(password, bcrypt.genSaltSync(8), null);
}
