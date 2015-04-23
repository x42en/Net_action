request = require 'request'

DEFAULT_FORMAT = 'json'
DEBUG_STATE = true

module.exports = class Net_action
	
	constructor: (@ROOT_DATA) ->
		
	get: ({ressource, params, @format, successCallback, errorCallback}) ->
		unless @format?
			@format = DEFAULT_FORMAT
		
		@_interact
			method: 'GET'
			params: params
			ressource: ressource
			scb: successCallback
			ecb: errorCallback

	post: ({ressource, params, @format, successCallback, errorCallback}) ->
		unless @format?
			@format = DEFAULT_FORMAT
		
		@_interact
			method: 'POST'
			params: params
			ressource: ressource
			scb: successCallback
			ecb: errorCallback

	put: ({ressource, params, @format, successCallback, errorCallback}) ->
		unless @format?
			@format = DEFAULT_FORMAT
		
		@_interact
			method: 'PUT'
			params: params
			ressource: ressource
			scb: successCallback
			ecb: errorCallback

	delete: ({ressource, @format, successCallback, errorCallback}) ->
		unless @format?
			@format = DEFAULT_FORMAT
		
		@_interact
			method: 'DELETE'
			ressource: ressource
			params: null
			scb: successCallback
			ecb: errorCallback

	_interact: ({method, ressource, params, scb, ecb}) ->
		unless @ROOT_DATA?
			if DEBUG_STATE
				console.error '#[!] No host defined !!'
			return false

		unless params?
			params = {}

		if method is "GET"
			# avoid forcing parameters in ressource
			ressource = escape ressource
			url = "#{ressource}?format=#{@format}"
			if params? and typeof params is 'string'
				url += "#{params}"
				params = ''
		else
			url = "#{ressource}"

		if DEBUG_STATE
			console.log "#[+] EXEC #{method} -> #{@ROOT_DATA}/#{url}"

		request
			method: method
			json: true
			form: params
			uri: "#{@ROOT_DATA}/#{url}"
			(error, response, result) =>
				if result?
					if result.State? and result.State
						scb result
					else
						ecb result
				else
					ecb "#{error}/#{response}"
