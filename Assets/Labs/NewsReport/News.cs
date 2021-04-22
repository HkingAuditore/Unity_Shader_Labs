using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class News : MonoBehaviour
{
    public String content;
    public float Width { get; set; }
    public float Starter { get; set; }
    public float Outer { get; set; }
    public float Ender { get; set; }
    public float Speed { get; set; }

    public RectTransform Recter { get; set; }

    public bool IsEnd = false;
    public bool isOut = false;

    private Text newsText;

    private void Start()
    {
        Generate();
    }
    private void FixedUpdate()
    {
        if (!isOut)
        {
            Recter.position -= new Vector3(Speed,0,0);

        }
        else
        {
            this.gameObject.SetActive(false);
            Generate();
        }
        IsEnd = IsNewsEnd();
        isOut = IsNewsOut();
        
    }


    private bool IsNewsEnd() => this.Recter.position.x <this.Ender;
    private bool IsNewsOut() => this.Recter.position.x < this.Outer;

    public void Generate()
    {
        IsEnd = false;
        isOut = false;
        this.newsText = this.GetComponent<Text>();
        newsText.text = content;
        
        Recter = this.GetComponent<RectTransform>();
        Width=newsText.preferredWidth;
        Recter.position = new Vector3(Starter,Recter.position.y,Recter.position.z);
        this.Outer = -this.Width;
        this.Ender = Starter - this.Width;
        
    }


    
}
