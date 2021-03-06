express = require('express')
cookieParser = require('cookie-parser')
bodyParser = require('body-parser')

twiliof = require "twilio-flow"
VoiceRouter = require './voice-router'

app = express()
app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: false)
app.use cookieParser()
app.use '/voice', twiliof.bind(express.Router(), VoiceRouter )

# catch 404 and forward to error handler
app.use (req, res, next) ->
	err = new Error('Not Found')
	err.status = 404
	next err
	return
# error handlers
# development error handler
# will print stacktrace
if app.get('env') == 'development'
	app.use (err, req, res, next) ->
		res.status err.status or 500
		res.render 'error',
			message: err.message
			error: err
		return
# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next) ->
	res.status err.status or 500
	res.render 'error',
		message: err.message
		error: {}
	return
module.exports = app
