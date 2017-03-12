var express = require('express');
var http = require('http');

var doctors = require('./doctorManagement');
var patients = require('./patientManagement');
var achievements = require('./achievementManagement');
var drags = require('./dragManagement');

var _Doctor = require('./../models/doctor');

module.exports = {
    newXPatients: function(number, complete) {
            var options = {
                host: 'random-name-generator.info',
                port: 80,
                path: '/random/?n='+number+'&g=1&st=2'
            };

            var __this = this;
            http.get(options, function(res) {
                var bodyChunks = [];
                res.on('data', function(chunk) {
                    bodyChunks.push(chunk);
                }).on('end', function() {
                    var body = Buffer.concat(bodyChunks).toString();
                    body = body.substring(body.indexOf("<ol class=\"nameList\">") + 21);
                    body = body.substring(0, body.indexOf("</ol>"));
                    var aryNames = body.split("<li>");
                    for (var x = 0; x < aryNames.length; x++) {
                        var name = aryNames[x];
                        name = name.replace("\t","");
                        name = name.replace("</li>");
                        name = name.replace(/\s+/g,' ').trim();
                        __this.newPatient(name, function(err, json) {
                            if (x >= aryNames.length-1 || err) {
                                return complete(err,json);
                            }
                        });
                    }
                })
            }).on('error', function(e) {
                return complete(e, {
                    result: "failed",
                    message: e
                });
            });
    },
    newPatient: function(name, complete) {
        _Doctor.find({}, function(err, docs) {
            var nicotineLevel = level();
            if (err == null) {
                if (docs.length > 0) {
                    var docID = docs[0].id;
                    patients.register({
                        id: mongoID(),
                        name: name,
                        doctor: docID,
                        nicotineLevel: nicotineLevel,
                        achievements: []
                    }, function(err2, json2) {
                        for (var x = 0; x < 10; x++) {
                            drags.register({
                                id: mongoID(),
                                patient: json2["patients"][0]["id"],
                                duration: (x + 1)
                            }, function(err3, json3) {
                                if (err3) console.log(err3);
                            });
                        }
                        return complete(err2, json2);
                    });
                } else {
                    doctors.register({
                        id: mongoID(),
                        name: "Dr. Jeff Anderson"
                    }, function(err, json) {
                        achievements.register({
                            id: mongoID(),
                            name: "Achievement",
                            description: "Achievement description"
                        }, function(err1, json1) {
                            patients.register({
                                id: mongoID(),
                                name: name,
                                nicotineLevel: nicotineLevel,
                                doctor: json["doctors"][0]["id"],
                                achievements: [
                                    json1["achievements"][0]["id"]
                                ]
                            }, function(err2, json2) {
                                if (err2 || json2.length < 1) {
                                    json2["result"] = "failed";
                                    json2["message"] = err2;
                                    return complete(err2, json2);
                                }
                                for (var x = 0; x < 10; x++) {
                                    drags.register({
                                        id: mongoID(),
                                        patient: json2["patients"][0]["id"],
                                        duration: (x + 1)
                                    }, function(err3, json3) {
                                        if (err3) console.log(err3);
                                    });
                                }
                                return complete(err2, json2);
                            });
                        });
                    });
                }
            }
        });
    }
};

function mongoID() {
    var timestamp = (new Date().getTime() / 1000 | 0).toString(16);
    return timestamp + 'xxxxxxxxxxxxxxxx'.replace(/[x]/g, function() {
        return (Math.random() * 16 | 0).toString(16);
    }).toLowerCase();
};

function level() {
    return Math.floor(Math.random() * 24) + 1
}
