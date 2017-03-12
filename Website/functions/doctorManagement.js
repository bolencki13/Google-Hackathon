var express = require('express');

var Doctor = require('./../models/doctor.js');
var Patient = require('./../models/patient.js');

module.exports = {
    register: function(info, complete) {
        var json = {};
        var doctor = new Doctor({
            _id: info["id"],
            name: info["name"],
        });
        doctor.save(function(err, doctor) {
            if (err == null) {
                json["result"] = "success";
                json["doctors"] = [
                    doctor.json()
                ];
                return complete(err, json);
            } else {
                json["result"] = "failed";
                json["message"] = err;
                return complete(err, json);
            }
        });
    },
    info: function(doctorID, complete) {
        var json = {};
        Doctor.find({
            _id: doctorID
        }, function(err, doctors) {
            if (err == null) {
                if (doctors.length > 0) {
                    Patient.find({
                        doctor: doctors[0].id
                    }, function(err1, patients) {
                        if (err1 == null) {
                            if (patients.length > 0) {
                                var doctorJSON = doctors[0].json();
                                var aryPatients = new Array();
                                patients.forEach(function(item, index) {
                                    item.json(function(err2,json2) {
                                        aryPatients.push(json2);
                                        if (index >= patients.length-1) {
                                            doctorJSON["patients"] = aryPatients;

                                            json["result"] = "success";
                                            json["doctors"] = [
                                                doctorJSON
                                            ];
                                            return complete(err, json);
                                        }
                                    });
                                });
                            } else {
                                json["result"] = "success";
                                json["doctors"] = [
                                    doctors[0].json()
                                ];
                                return complete(err, json);
                            }
                        } else {
                            json["result"] = "failed";
                            json["message"] = err1;
                            return complete(err1, json);
                        }
                    });
                } else {
                    json["result"] = "success";
                    json["doctors"] = [];
                    return complete(err, json);
                }
            } else {
                json["result"] = "failed";
                json["message"] = "Invalid doctor id";
                return complete(err, json);
            }
        });

    }
};
