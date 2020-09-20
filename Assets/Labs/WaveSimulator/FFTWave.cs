using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using Random = UnityEngine.Random;

public class FFTWave : MonoBehaviour
{
    public ComputeShader fftComputeShader;

    private RenderTexture _testRT;
    private RenderTexture _gaussianRandomRT;
    
    private Material _material;
    private int _renderTextureSize = 128;
    
    private static readonly int MainTex = Shader.PropertyToID("_MainTex");
    public Vector4 windAndSeed = new Vector4(0.1f, 0.2f, 0, 0);//风向和随机种子 xy为风, zw为两个随机种子
    public float windScale = 2;     //风强

    private float time = 0;
    private int _kernelComputeGaussianRandom;

    private void Awake()
    {
        _material = this.GetComponent<Renderer>().material;
        
        _testRT = CreateRenderTexture(_renderTextureSize);
        
        _gaussianRandomRT = CreateRenderTexture(_renderTextureSize);
        _kernelComputeGaussianRandom = fftComputeShader.FindKernel("ComputeGaussianRandom");
        fftComputeShader.SetInt("N", _renderTextureSize);
        fftComputeShader.SetTexture(_kernelComputeGaussianRandom, "GaussianRandomRT", _gaussianRandomRT );
        fftComputeShader.Dispatch(_kernelComputeGaussianRandom, _renderTextureSize / 8, _renderTextureSize / 8, 1);
    }

    private void Start()
    {
        GetRenderTexture("CreateWaveRenderTexture", ref _testRT);
        _material.SetTexture(MainTex,_testRT);
    }

    private void Update()
    {
        time += Time.deltaTime;
        GetRenderTexture("CreateWaveRenderTexture", ref _testRT);
    }

    private void GetRenderTexture(string kernelName,ref RenderTexture renderTexture)
    {
        var kernelIndex = fftComputeShader.FindKernel(kernelName);
        fftComputeShader.SetInt("N", _renderTextureSize);
        
        windAndSeed.z = Random.Range(1, 10f);
        windAndSeed.w = Random.Range(1, 10f);
        Vector2 wind = new Vector2(windAndSeed.x, windAndSeed.y);
        wind.Normalize();
        wind *= windScale;

        fftComputeShader.SetVector("WindAndSeed", new Vector4(wind.x, wind.y, windAndSeed.z, windAndSeed.w));
        fftComputeShader.SetFloat("Time", time);
        
        fftComputeShader.SetTexture(kernelIndex, "GaussianRandomRT", _gaussianRandomRT);
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
