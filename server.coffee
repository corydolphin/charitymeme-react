path        = require "path"
url         = require "url"
express     = require "express"
ReactAsync  = require "react-async"
App         = require "./src/app.coffee"
browserify  = require 'connect-browserify'
development = process.env.NODE_ENV isnt "production"

app = express()
app.port = process.env.PORT or '3000'

renderApp = (req, res, next) ->
  path = url.parse(req.url).pathname
  app = App(path: path)
  ReactAsync.renderComponentToStringWithAsyncState app, (err, markup) ->
    return next(err)  if err
    res.send "<!doctype html>\n" + markup

api = express().get("/users/:username", (req, res) ->
  username = req.params.username
  res.send
    username: username
    name: username.charAt(0).toUpperCase() + username.slice(1)
)

# app.use "/assets/bundle.js", browserify(
#   entry: "./src/app.coffee"
#   transforms: ["coffeeify"]
#   extensions: [".coffee"]
#   debug: true
# )

app.use "/assets", express.static(path.join(__dirname, "assets"))

app.use "/api", api
app.use renderApp

app.listen app.port, ->
  console.log "Point your browssser at http://localhost:#{app.port}"