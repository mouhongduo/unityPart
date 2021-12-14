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

                // ����lua·��
                string luaPath = Application.dataPath + "/Scripts/Lua/" + fileName + ".lua";
                // ��ȡlua·����ָ��lua�ļ�����
                string strLuaContent = File.ReadAllText(luaPath);
                // ��������ת��
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
