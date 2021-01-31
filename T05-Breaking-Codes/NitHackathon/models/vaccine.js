//jshint esversion:6

const mongoose = require('mongoose');
const vaccineSchema = new mongoose.Schema({
    name:String,
    date:String,
    patient:String,
    comments:String,
    doctor:mongoose.Schema.Types.ObjectId,
    reminders:[String],
    shots:[{
        date:String,
        status:Number
    }]
});

vaccineSchema.index({'doctor':1});
vaccineSchema.index({'patient':1});

const Vaccine = mongoose.model('vaccine', vaccineSchema,'vaccine');

module.exports = Vaccine;
