const accountSid = process.env.TWILIO_ACCOUNT_SID;
const authToken = process.env.TWILIO_AUTH_TOKEN;
const client = require('twilio')(accountSid, authToken);

module.exports.sendSms = (req,res,next)=>{
    const numberSend = req.body.number;
    const name = req.body.name;
    const date = req.body.date;
    let message = `Vaccine Reminder:\n\n Your next shot is due on ${date} for ${name}.\nPlease get it done!`
    client.messages
        .create({
            messagingServiceSid: 'MGff7b939f19c43e60279c824a11a38cae',
            body: message,
            to: numberSend
        })
        .then(message => {
            console.log(message)
            res.json({success: 1,})
        })
        .catch(err=>{
            console.error(err)
            res.json({success: 0,})
        })
}