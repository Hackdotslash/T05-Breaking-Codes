//jshint esversion:6

const mongoose = require('mongoose');
const bcrypt = require('bcrypt-node');

const userSchema = new mongoose.Schema({
    local: {
        email: String,
        password: String,
        isVerified: Boolean,
    },
    age:Number,
    name:String,
    userId:String,
    contact:Number,
    emergencyContact:Number,
    address:String,
    docs:[{
        link:String,
        name:String,
    }],
    doctors:[mongoose.Schema.Types.ObjectId]
});

userSchema.methods.generateHash = function(password) {
    return bcrypt.hashSync(password, bcrypt.genSaltSync(8), null);
};

userSchema.methods.validPassword = function(password) {
    return bcrypt.compareSync(password, this.local.password);
};
userSchema.index({'local.email':1});
const User = mongoose.model('users', userSchema,'users');

module.exports = User;
