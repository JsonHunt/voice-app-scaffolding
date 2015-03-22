sql = require 'sql-bricks'
_ = require 'underscore'

twilio = require 'twilio'
accountSID = 'AC8b3510dfe729785e2fa921c066ae4586'
authToken = 'bdc7f50dbc9ce7997d032a0e6c16c9b0'
twilio(accountSID, authToken)

FastBricks = require 'fast-bricks'
fastB = new FastBricks()
fastB.loadConfig('database-config.cson')
query = fastB.query

class VoiceService
	callURL: 'http://www.gamedealalerts.com:3000/voice/incoming'
	callbackURL: 'http://www.gamedealalerts.com:3000/voice/status'

	constructor: ()->

	saveCall: (call)->
		columns: ['id','time_started','time_ended','duration','from','to','caller_id']
		dbCall = _.pick call, columns
		query sql.insert 'call', dbCall, (err,result)->


	sendSMS: (from,to,body,callback)->
		twilioMsg =
			to: to
			from: from
			body: body
		twilio.messages.create twilioMsg, callback

	makeCall: (from,to,startURL,statusURL,callback)->
		twilioCall =
			to: to
			from: from
			url: startURL
			statusCallback: statusURL
		twilio.calls.create twilioCall, callback

module.exports = new VoiceService()
