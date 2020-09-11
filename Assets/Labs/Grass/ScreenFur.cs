using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[ExecuteInEditMode]  
public class ScreenFur : MonoBehaviour
{
    public Texture2D GrassTexture;  
    public Texture2D AOTexture;  
    public Color GrassColor = Color.white;  
    public float GrassTextureScale = 0.1f;
    [Range(0, 1)]
	public float BottomThreshold = 0f;
	[Range(0, 1)]
	public float TopThreshold = 1f;

    private Material _material;  


    void OnEnable()  
    {
        // dynamically create a material that will use our shader  
        _material = new Material(Shader.Find("Grass/FurGrass_Screen"));  
        // tell the camera to render depth and normals  
        GetComponent<Camera>().depthTextureMode |= DepthTextureMode.DepthNormals;  
    }   
    void OnRenderImage(RenderTexture src, RenderTexture dest)   
    {  
        // set shader properties  
        _material.SetMatrix("_CamToWorld", GetComponent<Camera>().cameraToWorldMatrix);  
        _material.SetColor("_Color", GrassColor);  
        _material.SetTexture("_GrassTex", GrassTexture);  
        _material.SetTexture("_AOTex", AOTexture);  
        _material.SetFloat("_BottomThreshold", BottomThreshold);
		_material.SetFloat("_TopThreshold", TopThreshold);
        _material.SetFloat("_GrassTexScale", GrassTextureScale);

        // execute the shader on input texture (src) and write to output (dest)  
        Graphics.Blit(src, dest, _material);  
    }  
}  