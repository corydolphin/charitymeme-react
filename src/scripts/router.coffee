React                          = require "react"
ReactAsync                     = require "react-async"
superagent                     = require "superagent"
{Pages, Page, NotFound, Link } = require "react-router-component"
MainPage                       = require "./main_page.coffee"
UserPage                       = require "./user_page.coffee"


NotFoundHandler = React.createClass
  displayName: "NotFoundHandler"
  render: ->
    React.DOM.p null, "Page not found"

Router = React.createClass
  displayName: "Router"
  render: ->
    Pages { className: "App", path: @props.path },
      Page { path: "/", handler: MainPage }
      Page { path: "/users/:username", handler: UserPage }
      NotFound { handler: NotFoundHandler }

module.exports = Router
# if typeof window isnt "undefined"
#   window.onload = ->
#     React.renderComponent App(), document