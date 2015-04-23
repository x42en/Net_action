# Copyright [2014] 
# @Email: x62en (at) users (dot) noreply (dot) github (dot) com
# @Author: Ben Mz

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

request = require 'request'

DEFAULT_FORMAT = 'json'

module.exports = class Net_action
	
	constructor: (@ROOT_DATA, @DEBUG_STATE) ->
		unless @DEBUG_STATE
			@DEBUG_STATE = false
		
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
			if @DEBUG_STATE
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

		if @DEBUG_STATE
			console.log "#[+] EXEC #{method} -> #{@ROOT_DATA}/#{url}"

		request
			method: method
			json: true
			form: params
			uri: "#{@ROOT_DATA}/#{url}"
			(error, response, result) =>
				if result? and @format is DEFAULT_FORMAT
					if result.State? and result.State
						scb result
					else
						ecb result
				else
					ecb "#{error}/#{response}"
