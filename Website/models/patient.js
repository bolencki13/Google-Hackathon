var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var Doctor = require('./doctor');
var Achievement = require('./achievement');
var Drag = require('./drag');

var patientSchema = new Schema({
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
});

patientSchema.methods.json = function json(complete) {
    var json = {};
    Doctor.find({
        _id: this.doctor
    }, function(err, doctors) {
        if (err == NULL) {
            Achievement.find({
                _id: {
                    $in: this.achievements
                }
            }, function(err1, achievements) {
                if (err1 == NULL) {
                    json["id"] = this.id;
                    json["name"] = this.name;
                    json["nicotineLevel"] = this.nicotineLevel;

                    var aryDoctors = new Array();
                    for (var x = 0; x < doctors.length; x++) {
                        aryDoctors.push(doctors[x].json);
                    }
                    json["doctor"] = aryDoctors;

                    var aryAchievements = new Array();
                    for (var x = 0; x < achievements.length; x++) {
                        aryAchievements.push(achievements[x].json);
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
