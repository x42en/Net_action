# Net_action

[![NPM](https://nodei.co/npm/net-action.png?compact=true)](https://nodei.co/npm/net-action/)

Easy to use Request wrapper in order to interact with RESTful API

## Install

Install with npm:
  ```sh
    npm install net-action
  ```
  
## Basic Usage

Require the module:
  ```coffeescript
    NETWORK = require 'net-action'
  ```

Instantiate with URL:
  ```coffeescript
    net = new NETWORK('http://localhost/test')
  ```


Execute GET method:
  ```coffeescript
    net.get
      ressource: 'hello'
      format: 'json'
  ```

Execute POST method:
  ```coffeescript
    net.post
      ressource: 'hello/42'
      params: { 'hello': 'world' }
      format: 'json'
  ```

Execute PUT method:
  ```coffeescript
    net.put
      ressource: 'hello/42'
      params: { 'hello': 'better world' }
      format: 'json'
  ```

Execute DELETE method:
  ```coffeescript
    net.delete
      ressource: 'hello/42'
      format: 'json'
  ```


## Extended usage

All methods supports success and error callback parameters:
  ```coffeescript
    net.put
      ressource: 'hello/42'
      params: { 'hello': 'better world' }
      successCallback: do_something()
      errorCallback: do_another_thing()
  ```