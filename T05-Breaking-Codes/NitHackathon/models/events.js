//jshint esversion:6

const mongoose = require('mongoose');
const eventSchema = new mongoose.Schema({
    title:String,
    location:String,
    date:String,
    time:String,
    description:String,
    //0 for reject 1 for success 2 for new event
    by:mongoose.Schema.Types.ObjectId,
    status:Number,
});

eventSchema.index({'status':1});

const Events = mongoose.model('events', eventSchema,'events');

module.exports = Events;
