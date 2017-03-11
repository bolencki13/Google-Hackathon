var express = require('express');
var path = require('path');
var router = express.Router();


// WEBSITE
router.get('/test', function(req, res) {
    res.render('index');
});

module.exports = router;
