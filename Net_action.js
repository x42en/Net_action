/****************************************************/
/*         Net_action - v0.1.6                      */
/*                                                  */
/*    Easily interact with REST API in node.js      */
/****************************************************/
/*             -    Copyright 2014    -             */
/*                                                  */
/*   License: Apache v 2.0                          */
/*   @Author: Ben Mz                                */
/*   @Email: bmz (at) certiwise (dot) com           */
/*                                                  */
/****************************************************/

(function() {
  var DEFAULT_FORMAT, Net_action, request;

  request = require('request');

  DEFAULT_FORMAT = 'json';

  module.exports = Net_action = (function() {
    function Net_action(ROOT_DATA, DEBUG_STATE) {
      this.ROOT_DATA = ROOT_DATA;
      this.DEBUG_STATE = DEBUG_STATE;
      if (!this.DEBUG_STATE) {
        this.DEBUG_STATE = false;
      }
    }

    Net_action.prototype.get = function(_arg) {
      var errorCallback, params, ressource, successCallback;
      ressource = _arg.ressource, params = _arg.params, this.format = _arg.format, successCallback = _arg.successCallback, errorCallback = _arg.errorCallback;
      if (!this.format) {
        this.format = DEFAULT_FORMAT;
      }
      return this._interact({
        method: 'GET',
        params: params,
        ressource: ressource,
        scb: successCallback,
        ecb: errorCallback
      });
    };

    Net_action.prototype.post = function(_arg) {
      var errorCallback, params, ressource, successCallback;
      ressource = _arg.ressource, params = _arg.params, this.format = _arg.format, successCallback = _arg.successCallback, errorCallback = _arg.errorCallback;
      if (!this.format) {
        this.format = DEFAULT_FORMAT;
      }
      return this._interact({
        method: 'POST',
        params: params,
        ressource: ressource,
        scb: successCallback,
        ecb: errorCallback
      });
    };

    Net_action.prototype.put = function(_arg) {
      var errorCallback, params, ressource, successCallback;
      ressource = _arg.ressource, params = _arg.params, this.format = _arg.format, successCallback = _arg.successCallback, errorCallback = _arg.errorCallback;
      if (!this.format) {
        this.format = DEFAULT_FORMAT;
      }
      return this._interact({
        method: 'PUT',
        params: params,
        ressource: ressource,
        scb: successCallback,
        ecb: errorCallback
      });
    };

    Net_action.prototype["delete"] = function(_arg) {
      var errorCallback, ressource, successCallback;
      ressource = _arg.ressource, this.format = _arg.format, successCallback = _arg.successCallback, errorCallback = _arg.errorCallback;
      if (!this.format) {
        this.format = DEFAULT_FORMAT;
      }
      return this._interact({
        method: 'DELETE',
        ressource: ressource,
        params: null,
        scb: successCallback,
        ecb: errorCallback
      });
    };

    Net_action.prototype._interact = function(_arg) {
      var ecb, format, method, params, ressource, scb, url;
      method = _arg.method, ressource = _arg.ressource, params = _arg.params, scb = _arg.scb, ecb = _arg.ecb;
      if (this.ROOT_DATA == null) {
        if (this.DEBUG_STATE) {
          console.error('#[!] No host defined !!');
        }
        return false;
      }
      if (params == null) {
        params = {};
      }
      this.format = this.format.toLowerCase();
      if (method === "GET") {
        ressource = escape(ressource);
        url = "" + ressource + "?format=" + this.format;
        if ((params != null) && typeof params === 'string') {
          url += "" + params;
          params = '';
        }
      } else {
        url = "" + ressource;
      }
      if (this.DEBUG_STATE) {
        console.log("#[*] EXEC " + method + " -> " + this.ROOT_DATA + "/" + url);
      }
      format = this.format === DEFAULT_FORMAT ? true : false;
      return request({
        method: method,
        json: format,
        form: params,
        uri: "" + this.ROOT_DATA + "/" + url
      }, (function(_this) {
        return function(error, response, body) {
          var result;
          if (typeof body === 'object' && body !== null) {
            result = body;
          } else {
            result = {};
            result.Html = body;
          }
          result.Method = method;
          result.HTTPCode = response.statusCode;
          if (!error && response.statusCode === 200) {
            return scb(result);
          } else {
            return ecb(result);
          }
        };
      })(this));
    };

    return Net_action;

  })();

}).call(this);
