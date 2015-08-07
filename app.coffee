express = require 'express'
bodyparser = require 'body-parser'
swig = require 'swig'

app = module.exports = express()

app.use (bodyparser.urlencoded { extended: false })

# require and setup controllers
controllers = require './controllers'
controllers.forEach (path) ->
  controller = require './controllers' + path
  app.post path, controller.post if controller.post
  app.get path, controller.get if controller.get

# render links to routes on root page
app.get '/', (req, res) ->
  res.sendFile __dirname + '/index.html'

# boot it up
server = app.listen 3000, () ->
  host = server.address().address;
  port = server.address().port;

  console.log 'words listening on port %s', port
