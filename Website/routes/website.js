var express = require('express');
var path = require('path');
var router = express.Router();

var patients = require('./../functions/patientManagement');
var doctors = require('./../functions/doctorManagement');


// WEBSITE
router.get('/', function(req, res) {
    res.render('website/index');
});

router.get('/dashboard/:doctorID', function(req, res) {
    doctors.info(req.params.doctorID, function(error, json) {
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
