const localStrategy = require('passport-local').Strategy;
const User = require('../models/user');
const Doctor = require('../models/doctor');
module.exports = function (passport) {
	passport.serializeUser(function (user, done) {
		done(null, user.id);
	});
	passport.deserializeUser(function (id, done) {
		User.findById(id, function (err, user) {
			done(err, user);
		});
	});
	passport.use(
		'doctor-signup',
		new localStrategy(
			{
				usernameField: 'email',
				passwordField: 'password',
				passReqToCallback: true,
			},
			function (req, email, password, done) {
				process.nextTick(function () {
					console.log(req.body);
					let email1 = String.prototype.toLowerCase.apply(email)
					Doctor.findOne(
						{
							$or:[
								{'local.email':email1},
							]
						},
						function (err, user) {
							if (err) return done(err);
							if (user) {
								return done(null, false, req.flash('signupMessage', 'That email is already taken.'));
							} else {
								var newUser = new Doctor();
								newUser.local.email = email1;
								newUser.name = req.body.name;
								newUser.contact = req.body.contact;
								newUser.specialization = req.body.specialization;
								newUser.address = req.body.address;
								newUser.pincode = req.body.pincode;
								newUser.local.password = newUser.generateHash(password);
								newUser.save(function (err) {
									if (err) throw err;
									return done(null, newUser);
								});
							}
						}
					);
				});
			}
		)
	);
	passport.use(
		'doctor-login',
		new localStrategy(
			{
				usernameField: 'email',
				passwordField: 'password',
				passReqToCallback: true,
			},
			function (req, email, password, done) {
				Doctor.findOne(
					{
						'local.email': String.prototype.toLowerCase.apply(email),
					},
					function (err, user) {
						if (err) return done(err);
						if (!user) return done(null, false, req.flash('loginMessage', 'No user found.')); // req.flash is the way to set flashdata using connect-flash
						if (!user.validPassword(password))
							return done(null, false, req.flash('loginMessage', 'Oops! Wrong password.')); // create the loginMessage and save it to session as flashdata
						return done(null, user);
					}
				);
			}
		)
	);

	passport.use(
		'local-signup',
		new localStrategy(
			{
				usernameField: 'email',
				passwordField: 'password',
				passReqToCallback: true,
			},
			function (req, email, password, done) {
				process.nextTick(function () {
					console.log(req.body);
					let email1 = String.prototype.toLowerCase.apply(email)
					User.findOne(
						{
							$or:[
								{'local.email':email1},
							]
						},
						function (err, user) {
							if (err) return done(err);
							if (user) {
								return done(null, false, req.flash('signupMessage', 'That email is already taken.'));
							} else {
								var newUser = new User();
								newUser.local.email = email1;
								newUser.local.isVerified = false;
								newUser.age = req.body.age;
								newUser.name = req.body.name;
								newUser.contact = req.body.contact;
								newUser.emergencyContact = req.body.emergencyContact;
								newUser.address          = req.body.address;
								newUser.userId = req.body.name + Math.floor(Math.random() * 90000) + 10000;
								newUser.local.password = newUser.generateHash(password);
								newUser.save(function (err) {
									if (err) throw err;
									return done(null, newUser);
								});
							}
						}
					);
				});
			}
		)
	);
	passport.use(
		'local-login',
		new localStrategy(
			{
				usernameField: 'email',
				passwordField: 'password',
				passReqToCallback: true,
			},
			function (req, email, password, done) {
				console.log(req.body);
				User.findOne(
					{
						'local.email': String.prototype.toLowerCase.apply(email),
					},
					function (err, user) {
						if (err) return done(err);
						if (!user) return done(null, false, req.flash('loginMessage', 'No user found.')); // req.flash is the way to set flashdata using connect-flash
						if (!user.validPassword(password))
							return done(null, false, req.flash('loginMessage', 'Oops! Wrong password.')); // create the loginMessage and save it to session as flashdata
						return done(null, user);
					}
				);
			}
		)
	);
};
