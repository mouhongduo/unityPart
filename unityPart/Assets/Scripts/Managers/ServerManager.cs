using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XLua;

namespace Base{

    public struct BattleData
    {
        public double positionX;
        public double positionY;
        public double positionZ;
    }

    [LuaCallCSharp]
    public class ServerManager : IManager
    {
        public void Awake()
        {
            NetCore.Init();
            NetSender.Init();
            NetReceiver.Init();
            NetCore.enabled = true;
        }

        public void Start()
        {
            

        }

        public static void Connect(string name)
        {
            NetCore.Connect("106.52.92.53", 8888, () =>
            {
                // 连接结果
                Debug.Log("connect result: " + NetCore.connected);
                if (NetCore.connected)
                {
                    SendJoin(name);
                    NetReceiver.AddHandler<Protocol.heartbeat>((data) =>
                    {
                        Debug.Log("收到服务端的heartbeat消息");
                        return null;
                    });
                }
            });
        }

        static void SendJoin(string name)
        {
            var req = new SprotoType.join.request();
            req.name = name;
            Debug.Log("发送SendJoin消息给服务端");
            NetSender.Send<Protocol.join>(req, (data) =>
            {
                var rsp = data as SprotoType.join.response;
                Debug.LogFormat("服务端join返回, status: {0}, id: {1}", rsp.code, rsp.id);
            });
        }

        public static void SendBattle(Vector3 data)
        {
            var req = new SprotoType.battle.request();
            SetBattleData(req, data);
            var timeBegin = Time.time;
            NetSender.Send<Protocol.battle>(req, (data) =>
            {
                var timeEnd = Time.time;
                Debug.Log(timeEnd - timeBegin);
                var rsp = data as SprotoType.battle.response;
            });
        }
        private static void SetBattleData(SprotoType.battle.request req, Vector3 data)
        {
            req.positionX = data.x;
            req.positionY = data.y;
            req.positionZ = data.z;
        }

        void IManager.Update()
        {
            NetCore.Dispatch();
        }
    }
}
