using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OceanCamera : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        if (!(Camera.main is null)) Camera.main.depthTextureMode = DepthTextureMode.Depth;
    }
    
}
