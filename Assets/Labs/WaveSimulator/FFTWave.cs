using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

public class FFTWave : MonoBehaviour
{
    public ComputeShader fftComputeShader;

    private RenderTexture _testRT;
    private Material _material;
    private int _renderTextureSize = 128;
    private static readonly int MainTex = Shader.PropertyToID("_MainTex");

    private void Awake()
    {
        _material = this.GetComponent<Renderer>().material;
        _testRT = CreateRenderTexture(_renderTextureSize);
    }

    private void Start()
    {
        GetRenderTexture("CreateWaveRenderTexture", ref _testRT);
        _material.SetTexture(MainTex,_testRT);
        SaveRenderTextureToPNG(_testRT, "test");
    }

    private void GetRenderTexture(string kernelName,ref RenderTexture renderTexture)
    {
        var kernelIndex = fftComputeShader.FindKernel(kernelName);
        fftComputeShader.SetInt("N", _renderTextureSize);
        fftComputeShader.SetTexture(kernelIndex,"Result",renderTexture);
        fftComputeShader.Dispatch(kernelIndex,_renderTextureSize / 8,_renderTextureSize / 8,1);
    }
    // 生成RT
    private RenderTexture CreateRenderTexture(int size)
    {
        var rt = new RenderTexture(size, size, 0, RenderTextureFormat.ARGBFloat) {enableRandomWrite = true};
        rt.Create();
        return rt;
    }
    
    public bool SaveRenderTextureToPNG(RenderTexture rt, string pngName)
    {
        RenderTexture prev = RenderTexture.active;
        string contents = $"Assets/../rt_{DateTime.Now.Hour}_{DateTime.Now.Minute}_{DateTime.Now.Second}.png";
        RenderTexture.active = rt;
        Texture2D png = new Texture2D(rt.width, rt.height, TextureFormat.ARGB32, false);
        png.ReadPixels(new Rect(0, 0, rt.width, rt.height), 0, 0);
        byte[] bytes = png.EncodeToPNG();
        if (!Directory.Exists(contents))
            Directory.CreateDirectory(contents);
        FileStream file = File.Open(contents + "/" + pngName + ".png", FileMode.Create);
        BinaryWriter writer = new BinaryWriter(file);
        writer.Write(bytes);
        file.Close();
        Texture2D.DestroyImmediate(png);
        png = null;
        RenderTexture.active = prev;
        return true;

    } 
}
