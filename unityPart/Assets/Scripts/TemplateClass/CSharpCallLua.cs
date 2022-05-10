using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Base;
using XLua;

[CSharpCallLua]
public interface CSharpCallLua
{
    public Dictionary<string, IController> controllersMap { get; set; }
    public Dictionary<string, IManager> managersMap { get; set; }
    public ITimer timer { get; set; }
    public void SetAvatarAndEnemy(GameObject avatar, GameObject enemy);
    public void OnGameBegin();
    //public IController cameraController;
    //public List<IController> controllers;
}
