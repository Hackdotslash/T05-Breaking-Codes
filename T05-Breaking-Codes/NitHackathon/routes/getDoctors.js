const Doctors = require('../models/doctor')

module.exports.getDoctors = (req,res,next)=>{
    Doctors.find({},{_id:0,specialization:1,address:1,pincode:1,name:1,contact:1}
    ,function (err,data){
        if(err){

            res.json({success:0,message:"Mongo Error"});

        }
    })
}