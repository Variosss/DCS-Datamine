local base = _G

module('WebViewWidget', package.seeall)
mtab = { __index = _M }

local Factory = require('Factory')
local Widget = require('Widget')
local gui_webview = require('gui_webview')

Factory.setBaseClass(_M, Widget)

function new()
	return Factory.create(_M)
end

function construct(self)
	Widget.construct(self)
end

function newWidget(self)
	return gui_webview.NewWebViewWidget()
end

function browserCreated(self, callback)
	gui_webview.browserCreated(self.widget,callback)
end

function cefLoadUrl(self, url)
	gui_webview.cefLoadUrl(self.widget,url)
end

function edQueryCancelCallback(self,callback)	
	gui_webview.edQueryCancelCallback(self.widget,callback)	
end

function edQueryCallback(self, callback)
	gui_webview.edQueryCallback(self.widget,callback)	
end

function edQuerySuccess(self, query_id, response)
	gui_webview.edQuerySuccess(self.widget,query_id, response)
end

function edQueryFailure(self, query_id, code, error_message)
	gui_webview.edQueryFailure(self.widget,query_id, code, error_message)
end
