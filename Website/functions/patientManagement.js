var express = require('express');

var Patient = require('./../models/patient.js');

module.exports = {
    register: function(info, complete) {
        var json = {};
        var patient = new Patient({
            name: info["name"],
            doctor: info["doctor"],
            achievements: info["achievements"]
        });
        patient.save(function(err, patient) {
            if (err == null) {
                patient.json(function(err1, json1) {
                    json["result"] = "success";
                    json["patients"] = [
                        json1
                    ];
                    return complete(err1, json);
                });
            } else {
                json["result"] = "failed";
                json["message"] = err;
                return complete(err, json);
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
    },
    updateInfo: function(userID, updates, complete) {
        var json = {};
        Patient.findOneAndUpdate({
            _id: userID
        }, search, {
            upsert: true
        }, function(err, patient) {
            if (err == null) {
                patients.json(function(err1, json1) {
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
                json["result"] = "failed";
                json["message"] = err;
                return complete(err, json);
            }
        });
    }
};
