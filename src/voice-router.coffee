
class VoiceRouter
	service: require './voice-service'

	incoming: (call)->
		call.say "Thank you for calling"
		call.goto "end"

	status: (call)->
		call.time_ended = new Date()
		service.saveCall(call)


	end:(call)->
		call.say "Goodbye"
		call.hangup()

module.exports = new VoiceRouter()
