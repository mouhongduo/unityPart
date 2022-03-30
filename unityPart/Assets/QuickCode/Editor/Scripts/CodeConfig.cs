using UnityEngine;
using System.Collections;
using System.Collections.Generic;

namespace PSDUIImporter
{
    public class CodeConfig
    {
        /// <summary>
        /// 需要注册事件的UI控件类型
        /// </summary>
        public enum EventWidgetType
        {
            Button,
            Toggle,
            Slider,
            InputField,
            ScrollRect,
            Scrollbar,
            Dropdown,
        }

        public static string ViewGeneratePath = "Assets/Scripts/Lua/UI/View/";
        public static string ModelGeneratePath = "Assets/Scripts/Lua/UI/Model/";
        public static string ActionGeneratePath = "Assets/Scripts/Lua/UI/Action/";

        public static Dictionary<string, string> eventCBParamDic = new Dictionary<string, string> { { "Toggle", "bool" }, 
            { "Slider", "float" }, { "InputField", "string" }, { "ScrollRect", "Vector2" }, { "Scrollbar", "float" }, { "Dropdown", "int" }, 
        };


        #region lua代码格式
        public const string regionStartLua = "--region you write\n";
        public const string regionEndLua = "--endregion\n";

        
        public const string LuaBracketStart = "{";
        public const string LuaBracketWithEnd = "}\n";
        public const string LuaBracketWithoutEnd = "}";
        public const string LuaMethodEnd = "end\n";

        /// <summary>
        /// View生成
        /// </summary>
        public const string codeAnnotationLua = 
            @"--this file is auto created by MouHongduo UI tool,you can edit it 
--do not need to care initialization of ui widget any more\n
-------------------------------------------------------------------------------" + "\n";
        public const string DynamicBindRequire =
            "local Reactive = require \"DynamicBind.Reactivity.Reactive\"\n" +
            "local BindType = require \"DynamicBind.UIBind.BindType\"\n" +
            "local UIBind = require \"DynamicBind.UIBind.UIBind\"\n" +
            "local {0} = Global.Models[\"{1}\"]\n";
        /// 0,1,3,4都是大括号
        public const string variblesDecleration = 
            "local BindEvent = {0} {1}\n" +
            "local BindMap\n" + 
            "local {2} = {3} {4}\n";
        public const string BindEventStart = "BindEvent = {\n";
        public const string BindMapStart = "BindMap = {\n";
        /// 第一个变量和最后一个变量都是大括号，因为大括号在format函数中会出错
        public const string BindItemString = "\t{0}name = \"{1}\", func = BindEvent.{2}, bindType = BindType.{3}{4},\n";
        public const string ViewStartFunction = 
            "{0}.CreateView = function(vm)\n" +
                "\tUIBind.CreateView(BindMap, vm)\n" +
            "end\n";
        public const string LuaReturn = "return {0}\n";

        /// <summary>
        /// Model生成
        /// </summary>
        public const string ReactiveRequire = "local Reactive = require(\"DynamicBind.Reactivity.Reactive\")\n";
        public const string SourceDataDecl = "local model = ";
        public const string SetterDecl = "local Setter = ";
        public const string SetterItemFunc = 
            "\tSet{0} = function(newValue)\n" +
                "\t\tmodel.{1} = newValue\n" +
            "\tend,\n";
        public const string GetterDecl = "local Getter = ";
        public static string GetterItemFunc =
            "\tGet{0} = function()\n" +
                "\t\treturn model.{1}\n" +
            "\tend,\n";
        public const string PackingCode = "local React = Reactive.reactive(model)\n";
        public const string ModelReturn = "return {Setter = Setter,  Getter = Getter}";

        ////////////////////////////////////////////////////////////
        //文件和类
        public const string classStartLua = "\nlocal {0} = class(\"{1}\");\n";
        public const string classEndLua = "\nreturn {0};\n";
        public const string assignCodeFmtLua = "\tself.{0} = self.transform:Find(\"{1}\"):GetComponent(\"{2}\"); \n";
        public const string assignGameObjectCodeFmtLua = "\t\tself.{0} = self.transform.Find(\"{1}\").gameObject; \n";
        //根物体上挂载的控件
        public const string assignRootCodeFmtLua = "\tself.{0} = self.transform:GetComponent(\"{1}\"); \n";

        public const string onClickSerilCodeLua = "\tself.{0}.onClick:AddListener(function () self:On{1}Clicked(); end); \n";
        public const string onValueChangeSerilCodeLua = "\n\tself.{0}.onValueChanged:AddListener(function (args) self:On{1}ValueChanged(args); end);";
        public const string btnCallbackSerilCodeLua = "\nfunction Class:On{0}Clicked()\n\nend\n";
        public const string eventCallbackSerilCodeLua = "\nfunction Class:On{0}ValueChanged(args)\n\nend\n";
        #endregion
    }
}
