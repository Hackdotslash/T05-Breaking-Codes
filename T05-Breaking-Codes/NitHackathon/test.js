var fs = require('fs');
var request = require('request');

function analyzeWav(apiKey, wavFilename) {
    var url = 'https://api.webempath.net/v2/analyzeWav';
    var formData = {
        apikey: apiKey,
        wav: fs.createReadStream(wavFilename)
    };

    request.post({ url: url, formData: formData }, function(err, response) {
        if (err) {
            console.trace(err);
            return;
        } else if (!response.body) {
            console.trace("no response body");
            return;
        }

        var result = JSON.parse(response.body);
        console.log("result: " + JSON.stringify(result));
    });
}

analyzeWav('MhRl2M3O_zCOTItv6eQEAV3RVd6D42JCWQH5cCjzKhg','record1.wav')