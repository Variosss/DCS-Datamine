
local Window            = require('Window')
local WebViewWidget 	= require('WebViewWidget')
local DialogLoader		= require('DialogLoader')
local Gui               = require('dxgui')

local cefWindow 

function CEFTestOpen()
    cefWindow = Window.new('1111')
    cefWindow:setVisible(true)
    cefWindow:setSize(800, 600)
    local webview =  WebViewWidget.new()
    webview:setSize(800, 600)
	
	webview:cefCallback(
	function  ( a ) 
		webview:cefLoadUrl('www.google.com')
		return 0 
	end 
	)
    cefWindow:insertWidget(webview)
end

function CEFTestClose()
    if  cefWindow then
        cefWindow:close()
	    cefWindow = nil
    end
end