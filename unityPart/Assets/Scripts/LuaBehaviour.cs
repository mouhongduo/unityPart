/*
 * Tencent is pleased to support the open source community by making xLua available.
 * Copyright (C) 2016 THL A29 Limited, a Tencent company. All rights reserved.
 * Licensed under the MIT License (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
 * http://opensource.org/licenses/MIT
 * Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
*/

using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using XLua;
using System;
using System.IO;

namespace Base
{
    [System.Serializable]
    public class BindItem
    {
        public string name;
        public string funcName;
        public string bindType;
        public GameObject gameObject;
        public BindItem(string name, string funcName, string bindType, GameObject gameObject)
        {
            this.name = name;
            this.funcName = funcName;
            this.bindType = bindType;
            this.gameObject = gameObject;
        }
    }

    public class ActionItem
    {
        public string name;
        public string funcName;
        public ActionItem(string name, string funcName)
        {
            this.name = name;
            this.funcName = funcName;
        }
    }


    [LuaCallCSharp]
    public class LuaBehaviour : MonoBehaviour
    {
        public List<BindItem> bindItems;
        internal static LuaEnv luaEnv; //all lua behaviour shared one luaenv only!
        internal static float lastGCTime = 0;
        internal const float GCInterval = 1;//1 second 

        private Action luaStart;
        private Action luaUpdate;
        private Action luaOnDestroy;

        private LuaTable scriptEnv;

        void Awake()
        {
            luaEnv = Main.luaEnv;
            scriptEnv = luaEnv.NewTable();

            // 为每个脚本设置一个独立的环境，可一定程度上防止脚本间全局变量、函数冲突
            LuaTable meta = luaEnv.NewTable();
            meta.Set("__index", luaEnv.Global);
            scriptEnv.SetMetaTable(meta);
            meta.Dispose();


            scriptEnv.Set("self", this);
            scriptEnv.Set("scriptName", this.name.Split('(')[0]);//取LoginView(Clone)中括号前的单词
            foreach (var bindItem in bindItems)
            {
                scriptEnv.Set(bindItem.name, bindItem.gameObject);
            }

            byte[] byArrayReturn = null;
            string fileName = "LuaBehaviour";
            // 定义lua路径
            string luaPath = Application.dataPath + "/Scripts/Lua/" + fileName + ".lua";
            // 读取lua路径中指定lua文件内容
            string strLuaContent = File.ReadAllText(luaPath);
            // 数据类型转换
            byArrayReturn = System.Text.Encoding.UTF8.GetBytes(strLuaContent);

            luaEnv.DoString(byArrayReturn, "luaBehavior", scriptEnv);

            Action luaAwake = scriptEnv.Get<Action>("awake");
            scriptEnv.Get("start", out luaStart);
            scriptEnv.Get("update", out luaUpdate);
            scriptEnv.Get("ondestroy", out luaOnDestroy);

            if (luaAwake != null)
            {
                luaAwake();
            }
        }

        // Use this for initialization
        void Start()
        {
            if (luaStart != null)
            {
                luaStart();
            }
        }

        // Update is called once per frame
        void Update()
        {
            if (luaUpdate != null)
            {
                luaUpdate();
            }
            if (Time.time - LuaBehaviour.lastGCTime > GCInterval)
            {
                luaEnv.Tick();
                LuaBehaviour.lastGCTime = Time.time;
            }
        }

        void OnDestroy()
        {
            if (luaOnDestroy != null)
            {
                luaOnDestroy();
            }
            luaOnDestroy = null;
            luaUpdate = null;
            luaStart = null;
            scriptEnv.Dispose();
            bindItems = null;
        }
    }
}
