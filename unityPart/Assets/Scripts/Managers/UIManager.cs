using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AddressableAssets;
using UnityEngine.ResourceManagement.AsyncOperations;
using XLua;
using UnityEngine.UI;

namespace Base
{
    [LuaCallCSharp]
    public class UIManager : IManager
    {
        public static GameObject canvasGO;
        public static GameObject ObjectPool;
        GameObject UICamera;
        static Dictionary<string, GameObject> UIMap = new Dictionary<string, GameObject>();
        static Dictionary<string, GameObject> PoolMap = new Dictionary<string, GameObject>();
        public void Awake()
        {
            UICamera = GameObject.Find("UICamera");
            canvasGO = GameObject.Find("Canvas");
            ObjectPool = GameObject.Find("ObjectPool");
            if(canvasGO == null)
            {
                canvasGO = new GameObject("Canvas");
                Canvas canvas = canvasGO.AddComponent<Canvas>();
                canvas.renderMode = RenderMode.ScreenSpaceCamera;
                canvasGO.AddComponent<GraphicRaycaster>();
                canvasGO.layer = LayerMask.NameToLayer("UI");
                canvasGO.transform.position = UICamera.transform.position + new Vector3(0,0,1000);
            }
        }

        
        public static void OpenUI(string name)
        {
            Addressables.LoadAssetAsync<GameObject>(name).Completed += OnLoadOver;
        }

        private static void OnLoadOver(AsyncOperationHandle<GameObject> obj)
        {
            GameObject gameObject = obj.Result;
            var ui = Object.Instantiate(gameObject,canvasGO.transform);
            UIMap.Add(gameObject.name, ui);
        }

        public static void CloseUI(string name)
        {
            UIMap.TryGetValue(name, out GameObject ui);
            UIMap.Remove(name);
            ui.transform.SetParent(ObjectPool.transform);
            ui.SetActive(false);
            PoolMap.Add(name, ui);
        }
    }
}

