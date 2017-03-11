var express = require('express');

var Achievement = require('./../models/achievement.js');

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
    info: function(achievementID, complete) {
        var json = {};

        var dictSearch = {
            _id: achievementID
        };
        if (achievementID == null) {
            dictSearch = {};
        }
        Achievement.find(dictSearch, function(err, achievements) {
            if (err == null) {
                if (achievements.length > 0) {
                    json["result"] = "success";
                    json["achievements"] = [
                        achievements[0].json
                    ];
                    return complete(err1, json);
                } else {
                    json["result"] = "success";
                    json["achievements"] = [];
                    return complete(err, json);
                }
            } else {
                json["result"] = "failed";
                json["message"] = "Invalid search";
                return complete(err, json);
            }
        });
    }
};
