React                          = require "react"
ReactAsync                     = require "react-async"
superagent                     = require "superagent"
{Pages, Page, NotFound, Link } = require "react-router-component"

MainPage = React.createClass
  displayName: "MainPage"
  render: ->
    React.DOM.div { className: "MainPage"},
      React.DOM.h1 null, "Hello, anonymous!"
      React.DOM.p null,
        Link { href: "/users/doe" }, "Login"

module.exports = MainPage