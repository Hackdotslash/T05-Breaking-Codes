const child_process = require('child_process');

module.exports.disease_predict = (req,res,next)=>{
    let spawn = child_process.spawn;
    let process = spawn('python',['./diseasePredict/main.py','1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0\n' +
    ',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,\n' +
    '0,0,0,0,0'])
    process.stdout.on('data', function(data) {
        res.send(data.toString());
    } )
}