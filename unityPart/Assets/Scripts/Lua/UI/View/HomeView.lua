--this file is auto created by MouHongduo UI tool,you can edit it 
--do not need to care initialization of ui widget any more\n
-------------------------------------------------------------------------------
local Reactive = require "DynamicBind.Reactivity.Reactive"
local BindType = require "DynamicBind.UIBind.BindType"
local UIBind = require "DynamicBind.UIBind.UIBind"
local HomeModel = Global.Models["HomeModel"]
local BindEvent = { }
local BindMap
local HomeView = { }

BindEvent = {
--region you write
	OnclickQuit = function()
		CS.UnityEngine.Application.Quit()
	end,
	OnClickLocalBattle = function()
		print("LocalBattle")
	end,
	OnClickOnlineBattle = function()
		Global.Managers.GameManager.BeginOnlineBattle()
	end,
	showMatchBox = function()
		return HomeModel.isMatch
	end,
	matchTime = function()
		return HomeModel.matchTime
	end,
--endregion
}
BindMap = {
	{name = "Quit", func = BindEvent.OnclickQuit, bindType = BindType.BindClick},
	{name = "LocalBattle", func = BindEvent.OnClickLocalBattle, bindType = BindType.BindClick},
	{name = "OnlineBattle", func = BindEvent.OnClickOnlineBattle, bindType = BindType.BindClick},
	{name = "matchBox", func = BindEvent.showMatchBox, bindType = BindType.BindShow},
	{name = "MatchTimeText", func = BindEvent.matchTime, bindType = BindType.BindText},
}
HomeView.CreateView = function(vm)
	UIBind.CreateView(BindMap, vm)
end
return HomeView
