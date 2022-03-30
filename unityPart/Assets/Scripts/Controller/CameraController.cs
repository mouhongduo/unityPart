using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using Base;
using XLua;

public class CameraController : IController
{
    //GameObject avatar;
    //GameObject camera;

    //float RotateScale = 8f;

    ///// <summary>
    ///// 范围
    ///// </summary>
    //Vector2 Vertical = new Vector2(0, 60); 

    [CSharpCallLua]
    public delegate Action LuaAwake();
    [CSharpCallLua]
    public delegate Action LuaStart();
    [CSharpCallLua]
    public delegate Action LuaUpdate();

    public void Awake()
    {
        Debug.Log("1231232131");

    }

    // Start is called before the first frame update
    public void Start()
    {
    }

    // Update is called once per frame
    public void Update()
    {
        //Vector3 centerPos = avatar.transform.position;
        ///////水平旋转
        //camera.transform.RotateAround(centerPos, Vector3.up, Input.GetAxisRaw("Mouse X") * Time.timeScale * RotateScale);

        ///////垂直旋转
        //Vector3 oldPos = camera.transform.position;
        //Quaternion oldRatation = camera.transform.rotation;
        //camera.transform.RotateAround(centerPos, camera.transform.right, Input.GetAxisRaw("Mouse Y") * Time.timeScale * RotateScale / 4);
        //if(camera.transform.rotation.eulerAngles.x < Vertical.x || camera.transform.rotation.eulerAngles.x > Vertical.y)
        //{
        //    camera.transform.position = oldPos;
        //    camera.transform.rotation = oldRatation;
        //}
    }
}
