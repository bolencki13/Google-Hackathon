var express = require('express');
var router = express.Router();

// MIDDLEWARE
router.use(function(req, res, next) {
    next();
});



module.exports = router;
