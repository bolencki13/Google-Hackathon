var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var Doctor = require('./doctor');
var Achievement = require('./achievement');
var Drag = require('./drag');

var patientSchema = new Schema({
    _id: {
        type: String,
        require: true,
        unique: true
    },
    name: {
        type: String,
        required: true
    },
    doctor: {
        type: String,
        required: true
    },
    achievements: {
        type: Array,
        default: new Array()
    },
    nicotineLevel: {
        type: Number,
        default: 100
    },
    date: {
        type: Date,
        default: new Date().toISOString(),
        required: true
    },
}, {
    _id: false
});

patientSchema.methods.json = function json(complete) {
    var achievements = this.achievements;

    var json = {};
    json["id"] = this.id;
    json["name"] = this.name;
    json["nicotineLevel"] = this.nicotineLevel;

    Doctor.find({
        _id: this.doctor
    }, function(err, doctors) {
        if (err == null) {
            Achievement.find({
                _id: {
                    $in: achievements
                }
            }, function(err1, achievements) {
                if (err1 == null) {
                    json["doctor"] = doctors[0].json();

                    var aryAchievements = new Array();
                    for (var x = 0; x < achievements.length; x++) {
                        aryAchievements.push(achievements[x].json());
                    }
                    json["achievements"] = aryAchievements;

                    complete(err1, json);
                } else {
                    complete(err1, json);
                }
            });
        } else {
            complete(err, json);
        }
    });
}


var Patient = mongoose.model('Patient', patientSchema);
module.exports = Patient;
