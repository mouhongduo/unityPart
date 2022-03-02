using UnityEngine;
using System.Collections;
using System.Collections.Generic;

namespace Quick.Code
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

        public static Dictionary<string, string> eventCBParamDic = new Dictionary<string, string> { { "Toggle", "bool" }, 
            { "Slider", "float" }, { "InputField", "string" }, { "ScrollRect", "Vector2" }, { "Scrollbar", "float" }, { "Dropdown", "int" }, 
        };


        #region lua代码格式
        public const string regionStartFmtLua = "\n--region {0} \n";
        public const string regionEndLua = "--endregion \n";

        public static string eventRegionLua = string.Format(regionStartFmtLua, "UI Event Register");
        public static string assignRegionLua = string.Format(regionStartFmtLua, "UI Variable Assignment");

        public const string methodStartFmtLua = "function Class:{0}()\n";
        public const string methodEndLua = "\nend\n";

        public const string codeAnnotationLua = @"--this file is auto created by MouHongduo UI tool,you can edit it 
--do not need to care initialization of ui widget any more 
--------------------------------------------------------------------------------";

        public const string assignCodeFmtLua = "\tself.{0} = self.transform:Find(\"{1}\"):GetComponent(\"{2}\"); \n";
        public const string assignGameObjectCodeFmtLua = "\t\tself.{0} = self.transform.Find(\"{1}\").gameObject; \n";
        //根物体上挂载的控件
        public const string assignRootCodeFmtLua = "\tself.{0} = self.transform:GetComponent(\"{1}\"); \n";

        public const string onClickSerilCodeLua = "\tself.{0}.onClick:AddListener(function () self:On{1}Clicked(); end); \n";
        public const string onValueChangeSerilCodeLua = "\n\tself.{0}.onValueChanged:AddListener(function (args) self:On{1}ValueChanged(args); end);";
        public const string btnCallbackSerilCodeLua = "\nfunction Class:On{0}Clicked()\n\nend\n";
        public const string eventCallbackSerilCodeLua = "\nfunction Class:On{0}ValueChanged(args)\n\nend\n";

        //文件和类
        public const string requireCode = "\nrequire \"class\"\n\n";
        public const string classStartLua = "\nlocal {0} = class(\"{1}\");\n";
        public const string classEndLua = "\nreturn {0};\n";
        public const string classCtorLua = "\nfunction {0}:ctor(...)\n\t--assign transform by your ui framework\n\tself.transform = nil;\nend\n";
        #endregion
    }
}
