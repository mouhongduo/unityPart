using System;
using System.Collections;
using System.Collections.Generic;
using DG.Tweening;
using UnityEngine;
using Base;

public class AvatarController : IController
{
    public GameObject avatar;
    private Animator Animator;
    private GameObject camera;

    private float speed = 1;

    public void Awake()
    {
        avatar = GameObject.Find("Avatar");
        Animator = avatar.GetComponent<Animator>();
        camera = GameObject.Find("MainCamera");
    }
    // Start is called before the first frame update
    public void Start()
    {
        
    }

    // Update is called once per frame
    public void Update()
    {
        if (Input.GetKey(KeyCode.W))
        {
            //Input.GetKey(KeyCode.Mouse0)
            //Animator.SetInteger
            var pos = avatar.transform.position;
            Debug.Log("现在输入的是W123");
            Animator.SetBool("Walk", true);
            avatar.transform.Rotate(0, camera.transform.eulerAngles.y - avatar.transform.eulerAngles.y, camera.transform.eulerAngles.z - avatar.transform.eulerAngles.z);
            avatar.transform.Translate(avatar.transform.forward * speed * Time.deltaTime, Space.World);
            camera.transform.Translate(avatar.transform.forward * speed * Time.deltaTime, Space.World);
        }
        else if (Input.GetKeyDown(KeyCode.W) && Input.GetKeyUp(KeyCode.LeftShift))
        {
            Animator.SetBool("Run", true);
        }
        else if (Input.GetKeyUp(KeyCode.W))
        {
            Animator.SetBool("Run", false);
            Animator.SetBool("Walk", false);
        }
    }
}
