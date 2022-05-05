--this file is auto created by MouHongduo UI tool,you can edit it 
--do not need to care initialization of ui widget any more\n
-------------------------------------------------------------------------------
local Reactive = require("DynamicBind.Reactivity.Reactive")
local model = {
	matchTime = nil,
	isMatch = false,
}
local Setter = {
	SetMatchTime = function(newValue)
		model.matchTime = newValue
	end,
	SetIsMatch = function(newValue)
		model.isMatch = newValue
	end
}
local Getter = {
	GetMatchTime = function()
		return model.matchTime
	end,
}
local React = Reactive.reactive(model)
return {Setter = Setter,  Getter = Getter}