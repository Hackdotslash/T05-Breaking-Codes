const comFun = require('../commonFunctions');
const storage = require('../config/cloudStorage');
const UserM = require('../models/user');

module.exports.doc = (req,res,next)=>{
    if(!comFun.NotNullUndef(req.file)){
        console.log(req.file);
        console.log(req.body);
        console.log("NO FILE FOUND")
        res.json({success: 0,message:"No files Found"});
        return next();
    }else if(!comFun.StrVal(req.body.name)){
        console.log("NO name")
        res.json({success: 0,message:"No name"});
        return next();
    } else {
        let userId = res.locals.userId;
        const bucket = storage.bucket('nit_hack');
        const {
            originalname,
            buffer
        } = req.file;
        let re = /(?:\.([^.]+))?$/;
        let ext = re.exec(originalname)[1]
        const fileName = Date.now() + '.' + ext;
        console.log(fileName)
        const blob = bucket.file('docs/' + fileName.replace(/ /g, "_"));
        const blobStream = blob.createWriteStream({
            resumable: false
        });
        blobStream.on('finish', () => {
            let docLink = `https://storage.googleapis.com/${bucket.name}/${blob.name}`
            UserM.findOneAndUpdate({_id:userId},{$push:{docs:{link:docLink,name:req.body.name}}},
                function (err) {
                if(err){
                    res.json({success:0,message:err})
                    return next();
                }else {
                    console.log("DOC UPLOADED",docLink)
                    res.json({success:1,message:"Success"})
                    return next();
                }
            })
        })
            .on('error', (err) => {
                console.log(err);
                res.json({success:0,message:err})
                return next();
            }).end(buffer);
    }
}