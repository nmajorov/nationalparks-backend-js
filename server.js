var restify = require('restify'),
    fs      = require('fs'),
    config  = require('./bin/config.js'),
    db      = require('./bin/db.js');
var server  = restify.createServer();

server.use(restify.plugins.queryParser())

// Routes
server.get('/ws/data/load', (req,res,next) => {

  var count = db.initDB();

  res.json(200, {"inserted":"true"})


  next()

});
server.get('/ws/data/within', db.selectBox);
server.get('/ws/data/all', db.selectAll);
server.get('/ws/data/destroy',  (req,res,next) => {
  db.flushDB();
  res.json(200,{'destroyed':'true'});
  next()
});
server.get('/ws/backends/info', db.wsinfo);
server.get('/ws/backends/info/:who', db.wsinfo);
server.get('/ws/info', db.wsinfo);
server.get('/ws/info/:who', db.wsinfo);
server.get('/ws/healthz', function (req, res, next) { res.send("OK"); });
server.get('/ws/healthz/:ok', function (req, res, next) { res.send("OK"); });
server.get('/', function (req, res, next)
{
  res.send("Welcome to the National Parks data service.");
});

server.listen(config.get('PORT'), config.get('IP'), function () {
  console.log( "Listening on " + config.get('IP') + ", port " + config.get('PORT') )
});
