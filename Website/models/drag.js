var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var Patient = require('./patient')

var dragSchema = new Schema({
    _id: {
        type: String,
        require: true,
        unique: true
    },
    duration: {
        type: Number,
        default: 0
    },
    date: {
        type: Date,
        default: new Date().toISOString(),
        required: true
    },
    patient: {
        type: String,
        required: true,
    }
}, {
    _id: false
});

dragSchema.methods.json = function json() {
    var json = {};
    json["id"] = this.id;
    json["duration"] = this.duration;
    json["date"] = this.date;
    json["patient_id"] = this.patient;
    return json;
}

var Drag = mongoose.model('Drag', dragSchema);
module.exports = Drag;
