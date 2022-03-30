using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityEngine.UI;
using XLua;

namespace Base
{
    public class Main : MonoBehaviour
    {
        public static LuaEnv luaEnv = new LuaEnv();
        public List<IManager> managers = new List<IManager>();
        public List<IController> controllers = new List<IController>();
        // Use this for initialization
        void Awake()
        {
            addLuaLoader();
            luaEnv.DoString("require 'luaMain'");
            initAndAwakeManagers();
            initAndAwakeControllers();
        }
        void Start()
        {
            
        }

        // Update is called once per frame
        void Update()
        {
            controllersUpdate();
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

        private void initAndAwakeControllers()
        {
            CSharpCallLua cSharpCallLua = luaEnv.Global.Get<CSharpCallLua>("CSharpCallLua");
            Debug.Log(cSharpCallLua.controllers.Count);
            controllers = cSharpCallLua.controllers;
            foreach(var controller in controllers)
            {
                controller.Awake();
            }
            //IController cameraController = cSharpCallLua.cameraController;
            //cameraController.Awake();
            Debug.Log("CSharpCallLua init over");
        }

        private void controllersUpdate()
        {
            foreach (var controller in controllers)
            {
                controller.Update();
            }
        }
    }

}
