var express = require('express');
var router = express.Router();
var mongoose = require('mongoose');

var patients = require('./../functions/patientManagement');
var achievements = require('./../functions/achievementManagement')
var doctors = require('./../functions/doctorManagement');
var drags = require('./../functions/dragManagement');
var dataTest = require('./../functions/dataTestManagement');

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
    res.render('api/docs', json);
});


// TESTING
// router.get('/db/new/x/:number', function(req, res) {
//     dataTest.newXPatients(req.params.number, function(error, json) {
//         res.send(json);
//     });
// });
router.get('/db/new/:name', function(req, res) {
    dataTest.newPatient(req.params.name, function(error, json) {
        res.send(json);
    });
});
// router.get('/db/reset', function(req, res) {
//     mongoose.connect('mongodb://localhost/tobaccno', function() {
//         mongoose.connection.db.dropDatabase();
//         res.send({
//             result: "success"
//         });
//     });
// });
//

// DOCTORS
router.post('/doctors/register', function(req, res) {
    var info = {
        id: req.body.id,
        name: req.body.name,
    };
    patients.register(info, function(error, json) {
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
        id: req.body.id,
        name: req.body.name,
        doctor: req.body.doctor
    };
    patients.register(info, function(error, json) {
        if (error) console.log("/patients/register/ => " + error);
        res.send(json);
    });
});
router.put('/patients/info/:patientID', function(req, res) {
    patients.updateInfo(req.params.patientID, req.body.updates, function(error, json) {
        if (error) console.log("/patients/info/" + req.params.patientID + " => " + error);
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
        id: req.body.id,
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
    for (var x = 0; x < req.body.drags.length; x++) {
        var info = {
            id: req.body.drags[x].id,
            patient: req.body.drags[x].patient,
            duration: req.body.drags[x].duration
        };
        drags.register(info, function(error, json) {
            if (error) console.log("/drags/register/ => " + error);
            if (x >= req.body.drags.length-1) {
                res.send(json);
            }
        });
    }
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


function mongoID() {
    var timestamp = (new Date().getTime() / 1000 | 0).toString(16);
    return timestamp + 'xxxxxxxxxxxxxxxx'.replace(/[x]/g, function() {
        return (Math.random() * 16 | 0).toString(16);
    }).toLowerCase();
};
