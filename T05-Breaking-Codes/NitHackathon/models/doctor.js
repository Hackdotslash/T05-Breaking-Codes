//jshint esversion:6

const mongoose = require('mongoose');
const bcrypt = require('bcrypt-node');
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
    users:[mongoose.Schema.Types.ObjectId]
});
doctorSchema.methods.generateHash = function(password) {
    return bcrypt.hashSync(password, bcrypt.genSaltSync(8), null);
};

doctorSchema.methods.validPassword = function(password) {
    return bcrypt.compareSync(password, this.local.password);
};
doctorSchema.index({'local.email':1});

const Doctor = mongoose.model('doctor', doctorSchema,'doctors');

module.exports = Doctor;
