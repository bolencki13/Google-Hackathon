var express = require('express');
var router = express.Router();

var patients = require('./../functions/patientManagement');
var achievements = require('./../functions/achievementManagement')

// MIDDLEWARE
router.use(function(req, res, next) {
    next();
});


// OVERVIEW
router.get('/', function(req, res) {
    var json = {};
    json["result"] = "success";

    var aryURLs = new Array();
    for (var x = 0; x < router.stack.length; x++) {
        if (router.stack[x].route && router.stack[x].route.path && router.stack[x].route.path != "/") {
            var jsonURL = {
                method: router.stack[x].route.stack[0].method,
                endpoint:router.stack[x].route.path,
            };
            aryURLs.push(jsonURL);
        }
    }
    json["endpoints"] = aryURLs;
    res.send(json);
});

// PATIENTS
router.post('/patients/register', function(req, res) {
    patients.register(req, function(error, json) {
        if (error) console.log("/patients/register/ => " + error);
        res.send(json);
    });
});
router.put('/patients/info', function(req, res) {
    patients.updateInfo(req.body.patientID, req.body.updates, function(error, json) {
        if (error) console.log("/patients/info/ => " + error);
        res.send(json);
    });
});
router.get('/patients/info/:patientID', function(req, res) {
    patients.info(req.params.patientID, function(error, json) {
        if (error) console.log("/patients/info/" + req.params.patientID + " => " + error);
        res.send(json);
    });
});

// ACHIEVEMENTS
router.post('/achievements/register', function(req, res) {
    achievements.register(req, function(error, json) {
        if (error) console.log("/achievements/register/ => " + error);
        res.send(json);
    });
});
router.get('/achievements/', function(req, res) {
    achievements.info(null, function(error, json) {
        if (error) console.log("/achievements/ => " + error);
        res.send(json);
    });
});
router.get('/achievements/info/:achievementID', function(req, res) {
    achievements.info(req.params.achievementID, function(error, json) {
        if (error) console.log("/achievements/info/" + req.params.achievementID + " => " + error);
        res.send(json);
    });
});

// get achievement (user_id => achievements to user || all)

// post user (login)
// post doctor (login)
// post drags (drag_id,duration,date) (create)
// achievements calculated server side


module.exports = router;
