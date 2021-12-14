using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using XLua;

namespace Game
{
    public class Main : MonoBehaviour
    {
        public static LuaEnv luaEnv = new LuaEnv();
        // Use this for initialization
        void Awake()
        {
            luaEnv.AddLoader((ref string fileName) =>
            {
                byte[] byArrayReturn = null;

                // 定义lua路径
                string luaPath = Application.dataPath + "/Scripts/Lua/" + fileName + ".lua";
                // 读取lua路径中指定lua文件内容
                string strLuaContent = File.ReadAllText(luaPath);
                // 数据类型转换
                byArrayReturn = System.Text.Encoding.UTF8.GetBytes(strLuaContent);

                return byArrayReturn;
            });
        }
        void Start()
        {
            luaEnv.DoString("require 'luaMain'");
        }

        // Update is called once per frame
        void Update()
        {
            if (luaEnv != null)
            {
                luaEnv.Tick();
            }
        }

        void OnDestroy()
        {
            luaEnv.Dispose();
        }
    }

}
