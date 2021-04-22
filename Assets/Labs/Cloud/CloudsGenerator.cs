using System;
using System.Collections.Generic;
using UnityEngine;

public class CloudsGenerator : MonoBehaviour
{
    public List<Point> _points = new List<Point>();

    public ComputeShader mappingShader;
    public RenderTexture map;
    public Material cloudMat;
    public Material volShadowMat;

    public int mapSize;

    private readonly int _renderTexSize = 1024;

    private struct PosData
    {
        public Vector2 Pos;
        public float Radius;
        public float Strength;
    }


    private void Start()
    {
        map = new RenderTexture(_renderTexSize, _renderTexSize, 24);
        map.enableRandomWrite = true;
        map.Create();
        cloudMat.SetTexture("_FurTex", map);
        volShadowMat.SetTexture("_FurTex", map);
    }

    private void FixedUpdate()
    {
        RenderCloudMap();
        
    }

    public void RenderCloudMap()
    {
        var data = new PosData[_points.Count];

        for (var i = 0; i < _points.Count; i++)
        {
            data[i].Pos.x = (((-_points[i].transform.position.x) + (mapSize)) / (2*mapSize)) * _renderTexSize;
            data[i].Pos.y = (((-_points[i].transform.position.z) + (mapSize)) / (2*mapSize)) * _renderTexSize;

            Debug.Log(data[i].Pos);

            data[i].Strength = _points[i].strength;

            data[i].Radius = _points[i].radius;
        }


        var buffer = new ComputeBuffer(data.Length, 4 * 4);
        buffer.SetData(data);

        var kernelHandle = mappingShader.FindKernel("CSMain");
        mappingShader.SetFloat("pointCount", _points.Count);
        mappingShader.SetBuffer(kernelHandle, "dataBuffer", buffer);
        mappingShader.SetTexture(kernelHandle, "Result", map);
        mappingShader.Dispatch(kernelHandle, map.width / 8, map.height / 8, 1);
        buffer.Release();
        
    }
}

