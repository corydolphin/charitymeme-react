React                          = require "react"
ReactAsync                     = require "react-async"
superagent                     = require "superagent"
{Pages, Page, NotFound, Link } = require "react-router-component"

UserPage = React.createClass
  displayName: "UserPage"
  mixins: [ReactAsync.Mixin]
  statics:
    getUserInfo: (username, cb) ->
      superagent.get "http://localhost:3000/api/users/" + username, (err, res) ->
        cb err, (if res then res.body else null)
        return

      return

  getInitialStateAsync: (cb) ->
    @type.getUserInfo @props.username, cb
    return

  componentWillReceiveProps: (nextProps) ->
    if @props.username isnt nextProps.username
      @type.getUserInfo nextProps.username, ((err, info) ->
        throw err  if err
        @setState info
        return
      ).bind(this)
    return

  render: ->
    otherUser = (if @props.username is "doe" then "ivan" else "doe")
    React.DOM.div { className: "UserPage" },
      React.DOM.h1 null, "Hello, ", @state.name, "!"

      React.DOM.p null,
        "Go to ",
        Link { href: "/users/" + otherUser }, "/users/" + otherUser,

      React.DOM.p null,
        Link { href: "/"}, "Logout"

module.exports = UserPage