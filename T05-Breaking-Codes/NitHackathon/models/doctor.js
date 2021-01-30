//jshint esversion:6

const mongoose = require('mongoose');

const doctorSchema = new mongoose.Schema({
    local: {
        email: String,
        password: String,
    },
    specialization:String,
    address:String,
    pincode:String,
    name:String,
    contact:Number,
});

const Doctor = mongoose.model('doctor', doctorSchema,'doctors');

module.exports = Doctor;
