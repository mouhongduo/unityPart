using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AddressableAssets;
using UnityEngine.ResourceManagement.AsyncOperations;
using System.Threading.Tasks;
using XLua;

namespace Base
{
    [LuaCallCSharp]
    public class SpawnManager : IManager
    {
        public static Dictionary<string, GameObject> prefabsMap = new Dictionary<string, GameObject>();
        public string[] prefabNames = { 
            "Assets/Prefabs/Roler/BlackMan.prefab",
            "Assets/Prefabs/Roler/NewBlackMan.prefab"
        };
        public void Awake()
        {
            LoadAllPrefab();
        }

        private async void LoadAllPrefab()
        {
            for(int i = 0; i < prefabNames.Length; i++)
            {
                GameObject prefab = await Addressables.LoadAssetAsync<GameObject>(prefabNames[i]).Task;
                prefabsMap.Add(prefabNames[i], prefab);
            }
        }

        public static GameObject SpawnPrefab(string name, Vector3 position, Quaternion rotation)
        {
            GameObject gameObject = GameObject.Instantiate(prefabsMap[name], position, rotation);
            return gameObject;
        }

        public void OnloadOver()
        {

        }

        public void Update()
        {

        }

        public void Start()
        {

        }
    }
}

