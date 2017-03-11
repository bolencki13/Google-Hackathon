var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var doctorSchema = new Schema({
    name: {
        type: String,
        required: true
    },
    date: {
        type: Date,
        default: new Date().toISOString(),
        required: true
    },
});

doctorSchema.methods.json = function json() {
    var json = {};
    json["id"] = this.id;
    json["name"] = this.name;
    return json;
}

var Doctor = mongoose.model('Doctor', doctorSchema);
module.exports = Doctor;
