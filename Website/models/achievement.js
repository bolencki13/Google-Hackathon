var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var achievementSchema = new Schema({
    name: {
        type: String,
        required: true
    },
    type: {
        type: Number,
        default: -1,
        required: true
    },
    goal: {
        type: Number,
        default: 0,
        required: true
    },
    description: {
        type: String,
        required: true
    },
    date: {
        type: Date,
        default: new Date().toISOString(),
        required: true
    },
    patient: {
        type: String,
        required: true
    }
});

achievementSchema.methods.json = function json() {
    var json = {};
    json["id"] = this.id;
    json["name"] = this.name;
    json["type"] = this.type;
    json["goal"] = this.goal;
    json["description"] = this.description;
    json["date"] = this.date;
    json["patient_id"] = this.patient;

    return json;
}

var Achievement = mongoose.model('Achievement', achievementSchema);
module.exports = Achievement;
