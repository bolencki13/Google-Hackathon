var express = require('express');
var router = express.Router();

// MIDDLEWARE
router.use(function(req, res, next) {
    next();
});

// get user (user_id) (/user_id)
// get achievement (user_id => achievements to user || all)

// post user (login)
// post doctor (login)
// post drags (drag_id,duration,date) (create)
// achievements calculated server side


module.exports = router;
