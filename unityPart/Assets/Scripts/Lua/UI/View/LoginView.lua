--this file is auto created by MouHongduo UI tool,you can edit it 
--do not need to care initialization of ui widget any more\n
-------------------------------------------------------------------------------
local Reactive = require "DynamicBind.Reactivity.Reactive"
local BindType = require "DynamicBind.UIBind.BindType"
local UIBind = require "DynamicBind.UIBind.UIBind"
local LoginModel = Global.Models["LoginModel"]
local BindEvent = { }
local BindMap
local LoginView = { }

BindEvent = {
--region you write
	userAccount = function()
		return LoginModel.Setter.SetUserAccount
	end,
	userPassword = function()
		return LoginModel.Setter.SetUserPassword
	end,
	OnClickLogin = function()
		local UIManager = Global.UIManager
		UIManager.CloseUI("LoginView")
	end,
--endregion
}
BindMap = {
	{name = "AccountInputField", func = BindEvent.userAccount, bindType = BindType.BindInput},
	{name = "PasswordInputField", func = BindEvent.userPassword, bindType = BindType.BindInput},
	{name = "Login", func = BindEvent.OnClickLogin, bindType = BindType.BindClick},
}
LoginView.CreateView = function(vm)
	UIBind.CreateView(BindMap, vm)
end
return LoginView
