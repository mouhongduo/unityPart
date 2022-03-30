using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityEngine.UI;
using XLua;

namespace Game
{
    public class Main : MonoBehaviour
    {
        public static LuaEnv luaEnv = new LuaEnv();
        public List<IManager> managers = new List<IManager>();
        // Use this for initialization
        void Awake()
        {
            addLuaLoader();
            initAndAwakeManagers();
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

        private void addLuaLoader()
        {
            luaEnv.AddLoader((ref string fileName) =>
            {
                byte[] byArrayReturn = null;
                // ����lua·��
                string trueFileName = fileName.Replace('.', '\\');//vsc��lua�ļ���������Ҫ�ԣ��ļ���ʵ��DynamicBind.Reactivity.Dep
                string luaPath = Application.dataPath + "/Scripts/Lua/" + trueFileName + ".lua";
                // ��ȡlua·����ָ��lua�ļ�����
                string strLuaContent = File.ReadAllText(luaPath);
                // ��������ת��
                byArrayReturn = System.Text.Encoding.UTF8.GetBytes(strLuaContent);

                return byArrayReturn;
            });
        }
        private void initAndAwakeManagers()
        {
            managers.Add(new UIManager());

            foreach(var manager in managers)
            {
                manager.Awake();
            }
        }
    }

}
