const dotenv        = require('dotenv');

/*ENV CONFIG */
dotenv.config();
/*ENV CONFIG */


const express       = require('express');
const moment        = require('moment');
const cookieParser  = require('cookie-parser');
const mongoose      = require('mongoose');
const configDB      = require('./config/database')(process.env.dbuser,process.env.dbpass);
const passport      = require('passport');
const logger        = require('morgan');
const flash         = require('connect-flash');
const bodyParser    = require('body-parser');
const cors          = require('cors');
const cookieSession = require('cookie-session');
const compression   = require('compression');
const fs            = require('fs');
const https         = require('https');
const path          = require('path');
const app           = express();

/*HTTPS SERVER CONFIG*/
// let cert    = fs.readFileSync('./certificate.crt');
// let key     = fs.readFileSync('./private.key');
// let ca      = fs.readFileSync('./ca_bundle.crt')
// let options = {
// 	key:key,
// 	cert:cert,
// 	ca:ca
// }
/*HTTPS SERVER CONFIG*/

/*DATABASE CONFIG*/
mongoose.connect(
    configDB.url,
    {
        useNewUrlParser: true,
        useUnifiedTopology: true,
        useFindAndModify: false,
    },
    function (err) {
        if (err) {
            console.log(err);
        } else {
            console.log('MongoDB Connected');
        }
    }
);
mongoose.set('debug', true);
mongoose.set('useCreateIndex', true);
/*DATABASE CONFIG*/


// app.use(express.static(path.join(__dirname, 'uploads')));
app.use(express.static(path.join(__dirname, 'public')));
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

/*LOGGER CONFIG*/
app.use(logger(function (tokens, req, res) {
    return [
        moment().format('LLL'),
        tokens.method(req, res),
        tokens.url(req, res),
        tokens.status(req, res),
        tokens.res(req, res, 'content-length'), '-',
        tokens['response-time'](req, res), 'ms'
    ].join(' ')
}));
/*LOGGER CONFIG*/


/*EXPRESS APP JSON CONFIG*/
app.use(flash());
app.use(compression());
app.use(express.json());
app.use(bodyParser.json());
app.use(
    express.urlencoded({
        extended: false,
    })
);
/*EXPRESS APP JSON CONFIG*/


/*COOKIES CONFIG*/
app.use(cookieParser());
app.use(
    cookieSession({
        name: 'session',
        keys: ['key1'],
        maxAge: 24 * 60 * 60 * 1000,
    })
);
/*COOKIES CONFIG*/

/*CORS CONFIG */
app.use(
    cors({
        origin: '*',
    })
);
/*CORS CONFIG */

/*PASSPORT CONFIG */
require('./config/passport')(passport);
app.use(passport.initialize());
app.use(passport.session());
/*PASSPORT CONFIG */


/*ROUTES*/
require('./routes/RegisterAndLogin')(app, passport);
require('./routes/index')(app);
/*ROUTES*/



app.listen(3000,function (){
    console.log("Server listening on port 3000")
})
// https.createServer(options,app).listen(5000)