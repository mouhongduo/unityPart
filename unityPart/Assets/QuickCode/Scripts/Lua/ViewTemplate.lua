--this file is auto created by QuickCode,you can edit it 
--do not need to care initialization of ui widget any more 
--------------------------------------------------------------------------------
--/**
--* @author :
--* date    :
--* purpose :
--*/
--------------------------------------------------------------------------------
local Reactive = require "DynamicBind.Reactivity.Reactive"
local BindType = require "DynamicBind.UIBind.BindType"
local UIBind = require "DynamicBind.UIBind.UIBind"

local BindEvent

local LoginView = {}

BindEvent = {
	OnClickLogin = function()
		print("OnClickLogin")
	end
}

local BindMap = {
	{name = "Login", func = BindEvent.OnClickLogin, bindType = BindType.BindClick}
}

LoginView.CreateView = function(vm)
	UIBind.CreateView(BindMap, vm)
end


return LoginView
