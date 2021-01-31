//jshint esversion:6
const UserModel = require('../models/user');
const DoctorModel = require('../models/doctor')
const comFun = require('../commonFunctions');
const jwt = require('jsonwebtoken');
const crypto = require('crypto');
const moment = require('moment');
module.exports = function (app, passport) {
	app.post(
		'/login',
		passport.authenticate('local-login', {
			failureRedirect: '/loginFail', // redirect back to the signup page if there is an error
			failureFlash: true, // allow flash messages
		}),
		(req, res) => {
			console.log("REQ.BODY",req.body);
			console.log(req.user);
			if (comFun.NotNullUndef(req.user)) {
				if(req.user.local.isVerified){
					let cipher = crypto.createCipher('aes256',"Secret");
					let encrypted = cipher.update(String(req.user._id), 'utf8', 'hex') + cipher.final('hex');
					res.json({ success: 1, message: 'Login Success',token:encrypted});
				} else {
					res.json({ success: -10, message: 'Verify user email',email:req.user.local.email});
				}
			} else {
				res.json({ success: 0, message: 'User Not Found' });
			}
		}
	);
	app.post('/doctor/login',passport.authenticate('doctor-login', {
			failureRedirect: '/loginFail', // redirect back to the signup page if there is an error
			failureFlash: true, // allow flash messages
		}),
		(req, res) => {
			console.log("REQ.BODY",req.body);
			console.log(req.user);
			if (comFun.NotNullUndef(req.user)) {
				let cipher = crypto.createCipher('aes256',"Secret");
				let encrypted = cipher.update(String(req.user._id), 'utf8', 'hex') + cipher.final('hex');
				res.json({ success: 1, message: 'Login Success',token:encrypted});
			} else {
		res.json({ success: 0, message: 'User Not Found' });
	}
})

app.get('/loginFail', (req, res) => {
	res.json({ success: 0, message: 'Login Fail' });
});
app.post(
	'/signup',
	passport.authenticate('local-signup', {
		failureRedirect: '/signupFail', // redirect back to the signup page if there is an error
		failureFlash: true, // allow flash messages
	}),(req,res)=>{
		let cipher = crypto.createCipher('aes256',"Secret");
		let encrypted = cipher.update(String(req.user._id), 'utf8', 'hex') + cipher.final('hex');
		res.json({ success: 1, message: 'Signup Success', token: encrypted });
	}
);
app.post('/doctor/signup',passport.authenticate('doctor-signup', {
	failureRedirect: '/signupFail', // redirect back to the signup page if there is an error
	failureFlash: true, // allow flash messages
}),(req,res)=>{
	let cipher = crypto.createCipher('aes256',"Secret");
	let encrypted = cipher.update(String(req.user._id), 'utf8', 'hex') + cipher.final('hex');
	res.json({ success: 1, message: 'Signup Success', token: encrypted });
})

app.get('/signupFail', (req, res) => {
	if (req.flash.signupMessage !== undefined) {
		res.json({ success: 0, message: req.flash().signupMessage[0] });
	} else {
		res.json({ success: 0, message: 'Signup Failed' });
	}
});

app.get('/logout', function (req, res) {
	req.logout();
	res.redirect('/');
});

app.post('/doctor/genTokenAndUserData',(req,res)=>{
	console.log(req.body);
	let bodyToken = req.body.token
	let decipher = crypto.createDecipher('aes256',"Secret");
	let decrypted = decipher.update(bodyToken, 'hex', 'utf8') + decipher.final('utf8');
	let obj = {
		userId:decrypted,
		expiry_date:moment().add(1,"week").format("YYYY-MM-DDTHH:mm:ss.SSS")
	}
	let token = jwt.sign(obj,"Secret");
	DoctorModel.findOne({_id:decrypted},function(err,data){
		if(err){
			console.log('Error',err);
			res.json({success:0,message:"Error"})
		}else if(!comFun.NotNullUndef(data)){
			console.log('Error',err);
			res.json({success:0,message:"Error"})
		}else {
			res.json({success:1,message:"Success",user:data,token:token});
		}
	})
})


app.post('/genTokenAndUserData',(req,res)=>{
	let bodyToken = req.body.token
	let decipher = crypto.createDecipher('aes256',"Secret");
	let decrypted = decipher.update(bodyToken, 'hex', 'utf8') + decipher.final('utf8');
	let obj = {
		userId:decrypted,
		expiry_date:moment().add(1,"week").format("YYYY-MM-DDTHH:mm:ss.SSS")
	}
	let token = jwt.sign(obj,"Secret");
	UserModel.findOne({_id:decrypted},function(err,data){
		if(err){
			console.log('Error',err);
			res.json({success:0,message:"Error"})
		}else if(!comFun.NotNullUndef(data)){
			console.log('DATA',data)
			res.json({success:0,message:"Error"})
		}else {
			res.json({success:1,message:"Success",user:data,token:token});
		}
	})
})
};
