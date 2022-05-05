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
        public static CSharpCallLua cSharpCallLua;
        public List<IManager> managers = new List<IManager>();
        public Dictionary<string, IController> controllersMap = new Dictionary<string, IController>();
        public Dictionary<string, IManager> managersMap = new Dictionary<string, IManager>();
        public float lastTime10;
        public float lastTime50;
        public float lastTime100;
        // Use this for initialization
        void Awake()
        {
            addLuaLoader();
            luaEnv.DoString("require 'luaMain'");
            cSharpCallLua = luaEnv.Global.Get<CSharpCallLua>("CSharpCallLua");
            initAndAwakeManagers();
            initAndAwakeControllers();
        }
        void Start()
        {
            controllersStart();
            managersStart();
        }

        // Update is called once per frame
        void Update()
        {
            controllersUpdate();
            managersUpdate();
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
                // 定义lua路径
                string trueFileName = fileName.Replace('.', '\\');//vsc中lua文件索引必须要以，文件名实例DynamicBind.Reactivity.Dep
                string luaPath = Application.dataPath + "/Scripts/Lua/" + trueFileName + ".lua";
                // 读取lua路径中指定lua文件内容
                string strLuaContent = File.ReadAllText(luaPath);
                // 数据类型转换
                byArrayReturn = System.Text.Encoding.UTF8.GetBytes(strLuaContent);

                return byArrayReturn;
            });
        }


        private void initAndAwakeManagers()
        {
            managersMap = cSharpCallLua.managersMap;
            managers.Add(new ServerManager());
            managers.Add(new SpawnManager());
            managers.Add(new UIManager());

            foreach(var manager in managers)
            {
                manager.Awake();
            }
             foreach (var pair in managersMap)
            {
                pair.Value.Awake();
            }
        }

        private void initAndAwakeControllers()
        {
            
            controllersMap = cSharpCallLua.controllersMap;
            foreach(var pair in controllersMap)
            {
                pair.Value.Awake();
            }
            //IController cameraController = cSharpCallLua.cameraController;
            //cameraController.Awake();
            Debug.Log("CSharpCallLua init over");
        }

        private void controllersStart()
        {
            foreach (var pair in controllersMap)
            {
                pair.Value.Start();
            }
        }

        private void controllersUpdate()
        {
            foreach (var pair in controllersMap)
            {
                pair.Value.Update();
            }
        }
        private void managersUpdate()
        {
            foreach (var manager in managers)
            {
                manager.Update();
            }
            foreach (var pair in managersMap)
            {
                pair.Value.Update();
            }
        }

        private void managersStart()
        {
            foreach (var pair in managersMap)
            {
                pair.Value.Start();
            }
            foreach (var manager in managers)
            {
                manager.Start();
            }
        }
    }

}
