using System.Collections;
using System.Collections.Generic;
using UnityEngine.AddressableAssets;
using UnityEngine;
using UnityEditor;
using Game;

namespace MHDEditor
{
    public class UIInjections : MonoBehaviour
    {
        public static GameObject loadGameObject;

        [MenuItem("MHD/Test")]
        public static void test()
        {
            Debug.Log("Begin inject");
            GameObject gameObject = AssetDatabase.LoadAssetAtPath<GameObject>("Assets/Prefabs/UI/Test.prefab");
            LuaBehaviour luaBehaviour = gameObject.GetComponent<LuaBehaviour>();

            initUI(luaBehaviour);
            Debug.Log("Inject has been done");
        }

        private static void initUI(LuaBehaviour luaBehaviour)
        {
            Debug.Log("initUI begin");
            luaBehaviour.injections.Clear();
            for (int i = 0; i < luaBehaviour.transform.childCount; i++)
            {
                GameObject gameObject = luaBehaviour.transform.GetChild(i).gameObject;
                luaBehaviour.injections.Add(new Injection(gameObject.name, gameObject));
            }
            Debug.Log("initUI over");
        }
    }
}


