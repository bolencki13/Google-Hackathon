var express = require('express');

var Drag = require('./../models/drag.js');

module.exports = {
    register: function(info, complete) {
        var json = {};
        var drag = new Drag({
            patient: info["patient"],
            duration: info["duration"]
        });
        drag.save(function(err, drag) {
            if (err == null) {
                json["result"] = "success";
                json["drags"] = [
                    drag.json()
                ];
                return complete(err, json);
            } else {
                json["result"] = "failed";
                json["message"] = err;
                return complete(err, json);
            }
        });
    },
    info: function(dragID, complete) {
        var json = {};
        Drag.find({
            _id: dragID
        }, function(err, drags) {
            if (err == null) {
                if (drags.length > 0) {
                    json["result"] = "success";
                    json["drags"] = [
                        drags[0].json()
                    ];
                    return complete(err, json);
                } else {
                    json["result"] = "success";
                    json["drags"] = [];
                    return complete(err, json);
                }
            } else {
                json["result"] = "failed";
                json["message"] = "Invalid drag id";
                return complete(err, json);
            }
        });
    },
    listUser: function(patientID, complete) {
        var json = {};
        Drag.find({
            patient: patientID
        }, function(err, drags) {
            if (err == null) {
                json["result"] = "success";

                var aryDrags = new Array();
                for (var x = 0; x < drags.length; x++) {
                    aryDrags.push(drags[x].json());
                }
                json["drags"] = aryDrags;
                return complete(err, json);
            } else {
                json["result"] = "failed";
                json["message"] = "Invalid drag id";
                return complete(err, json);
            }
        });
    }
};
