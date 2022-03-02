using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AddressableAssets;
using UnityEngine.ResourceManagement.AsyncOperations;
using XLua;
using UnityEngine.UI;

namespace Game
{
    [LuaCallCSharp]
    public class UIManager : IManager
    {
        public static GameObject canvasGO;
        GameObject UICamera;
        public void Awake()
        {
            UICamera = GameObject.Find("UICamera");
            canvasGO = GameObject.Find("Canvas");
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
            Object.Instantiate(gameObject,canvasGO.transform); 
        }

        
    }
}

