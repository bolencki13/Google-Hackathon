var express = require('express');
var app = express();
var path = require('path');
var bodyParser = require('body-parser')
var server = require('http').createServer(app);
// var mongoose = require('mongoose');

// mongoose.Promise = global.Promise;
// mongoose.connect('mongodb://localhost/tobaccno');

app.set('views', __dirname + '/views');
app.set('view engine', 'pug')

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
    extended: true
}));

app.use("/public", express.static('public'));
app.use("/", require('./routes/website'));
app.use("/api", require('./routes/api'));

server.listen(9000);
