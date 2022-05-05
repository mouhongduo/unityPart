using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XLua;

namespace Base
{
    [CSharpCallLua]
    public interface ITimer
    {
        public void DoUpdate100();
        public void DoUpdate500();
        public void DoUpdate1000();
    }

    [CSharpCallLua]
    public class Timer : MonoBehaviour, ITimer
    {
        float m_Time100;
        float m_Time500;
        float m_Time1000;
        ITimer m_Timer;

        private void Start()
        {
            CSharpCallLua cSharpCallLua = Main.cSharpCallLua;
            m_Time100 = UnityEngine.Time.time;
            m_Time500 = UnityEngine.Time.time;
            m_Time100 = UnityEngine.Time.time;
            m_Timer = cSharpCallLua.timer;
        }

        public void DoUpdate100()
        {
            m_Timer.DoUpdate100();
        }

        public void DoUpdate1000()
        {
            m_Timer.DoUpdate1000();
        }

        public void DoUpdate500()
        {
            m_Timer.DoUpdate500();
        }

        private void Update()
        {
            float thisTime = UnityEngine.Time.time;
            if(thisTime - m_Time100 >= 100 * 0.001)
            {
                DoUpdate100();
                m_Time100 = thisTime;
            }
            if (thisTime - m_Time500 >= 500 * 0.001)
            {
                DoUpdate500();
                m_Time500 = thisTime;
            }
            if (thisTime - m_Time1000 >= 1000 * 0.001)
            {
                DoUpdate1000();
                m_Time1000 = thisTime;
            }
        }
    }
}

