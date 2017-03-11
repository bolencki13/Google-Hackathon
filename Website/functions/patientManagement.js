var express = require('express');

var Patient = require('./../models/patient.js');

module.exports = {
    register: function(req, complete) {
        var json = {};
        var patient = new Patient({
            name: req.body.name,
            doctor: req.body.doctor
        });
        patient.save(function(err, patient) {
            if (err == null) {
                patient.json(function(err1,json1) {
                    json["result"] = "success";
                    json["users"] = [
                        json1
                    ];
                    return complete(err1,json);
                });
            } else {
                json["result"] = "failed";
                json["message"] = err;
                return complete(err,json);
            }
        });
    },
    info: function(patientID, complete) {
        var json = {};
        Patient.find({
            _id: patientID
        }, function(err, patients) {
            if (err == null) {
                if (patients.length > 0) {
                    patients[0].json(function(err1, json1) {
                        if (err1 == null) {
                            json["result"] = "success";
                            json["patients"] = [
                                json1
                            ];
                            return complete(err1, json);
                        } else {
                            json["result"] = "failed";
                            json["message"] = "Internal server error";
                            return complete(err, json);
                        }
                    });
                } else {
                    json["result"] = "success";
                    json["patients"] = [];
                    return complete(err, json);
                }
            } else {
                json["result"] = "failed";
                json["message"] = "Invalid patient id";
                return complete(err, json);
            }
        });
    }
};
