var express = require('express');
var path = require('path');
var router = express.Router();

var patients = require('./../functions/patientManagement');
var doctors = require('./../functions/doctorManagement');

var Doctor = require('./../models/doctor');

// WEBSITE
router.get('/', function(req, res) {
    Doctor.find({},function(err,docs) {
        var json = {};
        if (err == null && docs.length > 0) {
            json["doctor"] = docs[0].id;
        }
        console.log(json);
        res.render('website/index', json);
    });
});

router.get('/dashboard/:doctorID', function(req, res) {
    var doctor = req.params.doctorID;
    doctor.substring(0, doctor.indexOf('?'));
    doctors.info(doctor, function(error, json) {
        if (error) console.log("/doctors/info/" + req.params.doctorID + " => " + error);
        res.render('website/dashboard', json);
    });
});
router.get('/profile/:patientID', function(req, res) {
    patients.info(req.params.patientID, function(error, json) {
        if (error) console.log("/patients/info/" + req.params.patientID + " => " + error);
        res.render('website/profile', json);
    });
});


module.exports = router;
