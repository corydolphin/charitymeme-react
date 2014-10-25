React                          = require "react"
Router                         = require "./router.coffee"

App = React.createClass
  displayName: "App"
  render: ->
    console.log "App render!!!"
    React.DOM.html null,
      React.DOM.head null,
        React.DOM.link { rel: "stylesheet", href: "/assets/style.css"}
        React.DOM.script { src: "/assets/bundle.js" }
      Router(path: @props.path)

module.exports = App
if typeof window isnt "undefined"
  window.onload = ->
    React.renderComponent App(), document