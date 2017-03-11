var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var doctorSchema = new Schema({
    _id: {
        type: String,
        require: true,
        unique: true
    },
    name: {
        type: String,
        required: true
    },
    date: {
        type: Date,
        default: new Date().toISOString(),
        required: true
    },
}, {
    _id: false
});

doctorSchema.methods.json = function json() {
    var json = {};
    json["id"] = this.id;
    json["name"] = this.name;
    return json;
}

var Doctor = mongoose.model('Doctor', doctorSchema);
module.exports = Doctor;
