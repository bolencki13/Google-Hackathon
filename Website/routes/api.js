var express = require('express');
var router = express.Router();
var mongoose = require('mongoose');

var patients = require('./../functions/patientManagement');
var achievements = require('./../functions/achievementManagement')
var doctors = require('./../functions/doctorManagement');
var drags = require('./../functions/dragManagement');


// MIDDLEWARE
router.use(function(req, res, next) {
    next();
});


// OVERVIEW
router.get('/', function(req, res) {
    var json = {};
    json["result"] = "success";

    var endPoints = {};
    for (var x = 0; x < router.stack.length; x++) {
        if (router.stack[x].route && router.stack[x].route.path && router.stack[x].route.path != "/") {
            var jsonURL = {
                method: router.stack[x].route.stack[0].method,
                url: router.stack[x].route.path,
            };
            var aryTemp = endPoints[router.stack[x].route.path.split("/")[1]];
            if (aryTemp == null) {
                aryTemp = new Array();
            }
            aryTemp.push(jsonURL);
            endPoints[router.stack[x].route.path.split("/")[1]] = aryTemp;
        }
    }
    json["endpoints"] = endPoints;
    res.render('api/docs',json);
});


// TESTING
router.get('/db/test', function(req, res) {
    doctors.register("Doctor 1", function(err, json) {
        achievements.register({
            name: "Achievement 1",
            description: "This is achievement 1"
        }, function(err1, json1) {
            patients.register({
                name: "Patient 1",
                doctor: json["doctors"][0]["id"],
                achievements: [
                    json1["achievements"][0]["id"]
                ]
            }, function(err2, json2) {
                for (var x = 0; x < 5; x++) {
                    drags.register({
                        patient: json2["patients"][0]["id"],
                        duration: (x + 1) * 10
                    }, function(err3, json3) {
                        if (err3) console.log(err3);
                    });
                }
                res.send(json2);
            });
        });
    });
});
router.get('/db/reset', function(req, res) {
    mongoose.connect('mongodb://localhost/tobaccno', function() {
        mongoose.connection.db.dropDatabase();
        res.send({
            result: "success"
        });
    });
});


// DOCTORS
router.post('/doctors/register', function(req, res) {
    patients.register(req.body.name, function(error, json) {
        if (error) console.log("/doctors/register => " + error);
        res.send(json);
    });
});
router.get('/doctors/info/:doctorID', function(req, res) {
    doctors.info(req.params.doctorID, function(error, json) {
        if (error) console.log("/doctors/info/" + req.params.doctorID + " => " + error);
        res.send(json);
    });
});


// PATIENTS
router.post('/patients/register', function(req, res) {
    var info = {
        name: req.body.name,
        doctor: req.body.doctor
    };
    patients.register(info, function(error, json) {
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
    achievements.register({
        name: req.body.name,
        type: req.body.type,
        goal: req.body.goal,
        description: req.body.description
    }, function(error, json) {
        if (error) console.log("/achievements/register/ => " + error);
        res.send(json);
    });
});
router.get('/achievements', function(req, res) {
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


// DRAGS
router.post('/drags/register', function(req, res) {
    drags.register(info, function(error, json) {
        if (error) console.log("/drags/register/ => " + error);
        res.send(json);
    });
});
router.get('/drags/user/:userID', function(req, res) {
    drags.listUser(req.params.userID, function(error, json) {
        if (error) console.log("/drags/user/" + req.params.userID + " => " + error);
        res.send(json);
    });
});
router.get('/drags/info/:dragID', function(req, res) {
    drags.info(req.params.dragID, function(error, json) {
        if (error) console.log("/drags/info/" + req.params.dragID + " => " + error);
        res.send(json);
    });
});


module.exports = router;
