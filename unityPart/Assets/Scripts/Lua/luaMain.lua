print("xlua start")

CSharpCallLua = require("CSharpCallLua.CSharpCallLua")
Global = require("Global")


UIEnum = require("Config.UIEnum")
RolerEnum = require("Config.RolerEnum")
Global.Managers.UIManager.OpenUI(UIEnum.Home.path .. UIEnum.Home.name)