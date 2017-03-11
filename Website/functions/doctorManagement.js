var express = require('express');

var Doctor = require('./../models/doctor.js');

module.exports = {
    register: function(name, complete) {
        var json = {};
        var doctor = new Doctor({
            name: name,
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
                    json["result"] = "success";
                    json["doctors"] = [
                        doctors[0].json()
                    ];
                    return complete(err, json);
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
