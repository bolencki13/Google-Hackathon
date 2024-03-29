var express = require('express');
var path = require('path');
var router = express.Router();

var patients = require('./../functions/patientManagement');
var doctors = require('./../functions/doctorManagement');
var drags = require('./../functions/dragManagement');

var Doctor = require('./../models/doctor');

// WEBSITE
router.get('/', function(req, res) {
    Doctor.find({},function(err,docs) {
        var json = {};
        if (err == null && docs.length > 0) {
            json["doctor"] = docs[0].id;
        }
        res.render('website/index', json);
    });
});

router.get('/dashboard/:doctorID', function(req, res) {
    var doctor = req.params.doctorID;
    doctor.substring(0, doctor.indexOf('?'));
    console.log(doctor);
    doctors.info(doctor, function(error, json) {
        if (error) console.log("/doctors/info/" + req.params.doctorID + " => " + error);
        console.log(json);
        res.render('website/dashboard', json);
    });
});
router.get('/profile/:patientID', function(req, res) {
    patients.info(req.params.patientID, function(error, json) {
        if (error) console.log("/patients/info/" + req.params.patientID + " => " + error);
        drags.listUser(req.params.patientID, function(error1, json1) {
            if (error1) console.log("/drags/user/" + req.params.patientID + " => " + error1);
            var jsonComplete = {
                drags: json1,
                user: json
            };
            res.render('website/profile', jsonComplete);
        });
    });
});


module.exports = router;
