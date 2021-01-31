
const {Storage} = require('@google-cloud/storage');
const storage = new Storage({
    keyFilename: 'cloudStorage.json',
    projectId: 'stoked-courier-276420',
})
module.exports = storage