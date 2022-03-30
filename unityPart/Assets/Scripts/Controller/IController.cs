using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XLua;

namespace Base{
    [CSharpCallLua]
    public interface IController
    {
        public void Awake();
        public void Start();
        public void Update();
    }
}


