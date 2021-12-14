using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AddressableAssets;
using UnityEngine.ResourceManagement.AsyncOperations;
using XLua;

namespace Game
{
    [LuaCallCSharp]
    public class UIManager
    {
        public static void OpenUI(string name)
        {
            Addressables.LoadAssetAsync<GameObject>(name).Completed += OnLoadOver;
        }

        private static void OnLoadOver(AsyncOperationHandle<GameObject> obj)
        {
            GameObject gameObject = obj.Result;
            Object.Instantiate(gameObject);
        }
    }
}

