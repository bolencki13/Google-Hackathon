var express = require('express');

var Achievement = require('./../models/achievement.js');

module.exports = {
    register: function(info, complete) {
        var json = {};
        var achievement = new Achievement({
            name: info["name"],
            type: info["type"],
            goal: info["goal"],
            description: info["description"]
        });
        achievement.save(function(err, achievement) {
            if (err == null) {
                    json["result"] = "success";
                    json["achievements"] = [
                        achievement.json()
                    ];
                    return complete(err,json);
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
                    json["result"] = "success";

                    var aryAchievements = new Array();
                    for (var x = 0; x < achievements.length; x++) {
                        aryAchievements.push(achievements[x].json());
                    }
                    json["achievements"] = aryAchievements;
                    return complete(err, json);
            } else {
                json["result"] = "failed";
                json["message"] = "Invalid search";
                return complete(err, json);
            }
        });
    }
};
