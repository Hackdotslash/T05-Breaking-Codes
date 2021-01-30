//jshint esversion:6

const mongoose = require('mongoose');

const doctorSchema = new mongoose.Schema({
    local: {
        email: String,
        password: String,
        isVerified: Boolean,
    },
    specialization:String,
    pincode:[String],
    name:String,
    contact:Number,
    image:String,
});

const Doctor = mongoose.model('doctor', doctorSchema,'doctors');

module.exports = Doctor;
