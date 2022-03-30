using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.IO;
using UnityEngine;
using Base;

namespace PSDUIImporter
{
    public class CodeGenerateCtrl
    {
        public static void DoGenerateCode(GameObject view)
        {
            string pre = view.name.Substring(0,view.name.Length - 4);
            var items = PSDImportUtility.bindItems;
            string viewPrePath = CodeConfig.ViewGeneratePath;
            string modelPrePath = CodeConfig.ModelGeneratePath;
            GenerateView(pre, viewPrePath);
            GenerateModel(pre, modelPrePath);
            
            Debug.Log("脚本生成成功");
        }

        private static void GenerateView(string name, string path)
        {
            Debug.Log("脚本开始生成:" + name + "View.lua");
            string viewName = name + "View";
            string modelName = name + "Model";
            string viewPath = path + viewName + ".lua";
            var items = PSDImportUtility.bindItems;


            StringBuilder scriptBuilder = new StringBuilder();
            scriptBuilder.Append(CodeConfig.codeAnnotationLua);
            scriptBuilder.AppendFormat(CodeConfig.DynamicBindRequire, modelName, modelName);
            scriptBuilder.AppendFormat(CodeConfig.variblesDecleration, CodeConfig.LuaBracketStart, CodeConfig.LuaBracketWithoutEnd, viewName
                , CodeConfig.LuaBracketStart, CodeConfig.LuaBracketWithEnd);

            scriptBuilder.Append(CodeConfig.BindEventStart);
            scriptBuilder.Append(CodeConfig.regionStartLua);
            scriptBuilder.Append(CodeConfig.regionEndLua);
            scriptBuilder.Append(CodeConfig.LuaBracketWithEnd);

            scriptBuilder.Append(CodeConfig.BindMapStart);
            scriptBuilder.Append(AddBindItem(items));
            scriptBuilder.Append(CodeConfig.LuaBracketWithEnd);



            scriptBuilder.AppendFormat(CodeConfig.ViewStartFunction, viewName);
            scriptBuilder.AppendFormat(string.Format(CodeConfig.LuaReturn, viewName));
            File.WriteAllText(viewPath, scriptBuilder.ToString().Replace("Class", viewName), new UTF8Encoding(false));
        }

        private static void GenerateModel(string name, string path)
        {
            Debug.Log("脚本开始生成:" + name + "Model.lua");
            string modelName = name + "Model";
            string modelPath = path + modelName + ".lua";
            var items = PSDImportUtility.bindItems;

            StringBuilder scriptBuilder = new StringBuilder();
            scriptBuilder.Append(CodeConfig.codeAnnotationLua);
            scriptBuilder.Append(CodeConfig.ReactiveRequire);
            scriptBuilder.Append(CodeConfig.SourceDataDecl + CodeConfig.LuaBracketStart + "\n");
            scriptBuilder.Append(AddSourceData(items));
            scriptBuilder.Append(CodeConfig.LuaBracketWithEnd);

            scriptBuilder.Append(CodeConfig.SetterDecl + CodeConfig.LuaBracketStart + "\n");
            scriptBuilder.Append(AddSetter(items));
            scriptBuilder.Append(CodeConfig.LuaBracketWithEnd);

            scriptBuilder.Append(CodeConfig.GetterDecl + CodeConfig.LuaBracketStart + "\n");
            scriptBuilder.Append(AddGetter(items));
            scriptBuilder.Append(CodeConfig.LuaBracketWithEnd);
            scriptBuilder.Append(CodeConfig.PackingCode);
            scriptBuilder.Append(CodeConfig.ModelReturn);
            File.WriteAllText(modelPath, scriptBuilder.ToString().Replace("Class", modelPath), new UTF8Encoding(false));
        }

        private static StringBuilder AddBindItem(List<BindItem> bindItems)
        {
            StringBuilder stringBuilder = new StringBuilder();

            foreach(BindItem item in bindItems)
            {
                stringBuilder.AppendFormat(CodeConfig.BindItemString, CodeConfig.LuaBracketStart, item.name, item.funcName, item.bindType, CodeConfig.LuaBracketWithoutEnd);
            }

            return stringBuilder;
        }

        private static StringBuilder AddSourceData(List<BindItem> bindItems)
        {
            StringBuilder stringBuilder = new StringBuilder();

            foreach (BindItem item in bindItems)
            {
                if (isAddModel(item.bindType))
                {
                    stringBuilder.Append("\t" + item.funcName + " = nil,\n");
                }
            }

            return stringBuilder;
        }
        private static StringBuilder AddSetter(List<BindItem> bindItems)
        {
            StringBuilder stringBuilder = new StringBuilder();

            foreach (BindItem item in bindItems)
            {
                if (isAddModel(item.bindType))
                {
                    string bigHeadName = item.funcName[0].ToString().ToUpper() + item.funcName.Substring(1);
                    stringBuilder.AppendFormat(CodeConfig.SetterItemFunc, bigHeadName, item.funcName);
                }
            }

            return stringBuilder;
        }
        private static StringBuilder AddGetter(List<BindItem> bindItems)
        {
            StringBuilder stringBuilder = new StringBuilder();

            foreach (BindItem item in bindItems)
            {
                if (isAddModel(item.bindType))
                {
                    string bigHeadName = item.funcName[0].ToString().ToUpper() + item.funcName.Substring(1);
                    stringBuilder.AppendFormat(CodeConfig.GetterItemFunc, bigHeadName, item.funcName);
                }
            }

            return stringBuilder;
        }


        private static bool isAddModel(string type)
        {
            bool isAddModel = false;

            if(type == "BindText" || type == "BindInput")
            {
                isAddModel = true;
            }

            return isAddModel;
        }
    }

    
}


