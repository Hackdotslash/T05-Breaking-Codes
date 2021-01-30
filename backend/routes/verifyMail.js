//jshint esversion:6
const express = require('express');
const jwt = require('jwt-simple');
const com_fun = require('../commonFunctions');
const User = require('../models/user');
const mailer = require('../utils/mailer');

module.exports.VerifyMail = function (req, res, next) {
	var secret = process.env.verify_mail_secret;
	console.log(req.body);
	if (req.body.email !== '' && com_fun.NotNullUndef(req.body.email)) {
		User.findOne(
			{
				'local.email': String.prototype.toLowerCase.apply(req.body.email),
			},
			function (err, result) {
				if (err) {
					console.log(err);
					res.json({ success: 0, message: 'Sorry there is some error' });
					return next();
				}
				if (result == null) {
					res.json({ success: 0, message: 'Email Not Found' });
					return next();
				} else {
					const emailAddress = String.prototype.toLowerCase.apply(req.body.email);
					var date = Date.now();
					date += 24 * 60 * 60 * 1000;
					const payload = {
						id: result._id,
						email: emailAddress,
						endDate: date,
					};
					var token = jwt.encode(payload, secret);
					let url = 'http://35.208.131.201:3000/verify/' + token;
					let content = `<p>Hey User,</p>
                        <p><br></p>
                        <p>You are just one step away from the Untangle.</p>
                        <p><br></p>
                        <p><span style="color: rgb(44, 130, 201);"><a href="${url}">Click here</a></span> to Verify your mail and unleash happiness.</p>
                        <p><br></p>
                        <p>If the above link doesn&#39;t work manually paste this link in your browser</p>
                        <p><span style="font-size: 12px;">${url}</span></p>
                        <p><br></p>
                        <p>-Team Untangle</p>`;
					console.log(content);
					mailer(emailAddress, 'Verify your E-Mail Address', content);
					res.json({ success: 1, message: 'Email Sent Successfully' });
					return next();
				}
			}
		);
	} else {
		res.json({ success: 0, message: 'Email Not Found' });
		return next();
	}
};

//handling the link clicked on receiving the confirmation mail
module.exports.verifyMailToken = function (req, res, next) {
	let secret = process.env.verify_mail_secret;
	if (!com_fun.NotNullUndef(req.params.token)) {
		res.json({success: 0, message: 'NO TOKEN'});
	} else {
		try {
			let payload = jwt.decode(req.params.token, secret);
			if (payload.endDate < Date.now()) {
				res.json({success: 0, message: 'Link Expired'});
				return next();
			} else {
				User.findById(payload.id, function (err, result) {
					if (err) {
						console.log(err);
						res.json({success: 0, message: 'Sorry there is some error'});
						return next();
					}
					if (result == null) {
						res.json({success: 0, message: 'Incorrect Link'});
						return next();
					} else {
						result.local.isVerified = true;
						result.save();
						res.render('verified.ejs');
						return next();
					}
				});
			}
		} catch (e) {
			console.log("ERROR")
			res.json({success: 0})
			return
		}


	}
}
