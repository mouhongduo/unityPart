using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using XLua;

public class Main : MonoBehaviour
{
    LuaEnv luaenv = null;
    // Use this for initialization
    void Start()
    {
        luaenv = new LuaEnv();
        luaenv.AddLoader((ref string fileName) =>
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
        luaenv.DoString("require 'luaMain'");
    }

    // Update is called once per frame
    void Update()
    {
        if (luaenv != null)
        {
            luaenv.Tick();
        }
    }

    void OnDestroy()
    {
        luaenv.Dispose();
    }
}
