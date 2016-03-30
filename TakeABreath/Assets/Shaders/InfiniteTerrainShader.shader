﻿Shader "Unlit/InfiniteTerrainShader"
{
	Properties
	{
		_Color ("Color", Color) = (1,1,1,1)
		_OceanColor ("Color", Color) = (0,0,1,1)
        _Cutoff ("Alpha Cutoff", Range (0, 1)) = 0
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			float4 _Color;
			float4 _OceanColor;
            float _Lerp;

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
				float4 color : COLOR;

			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.color = v.vertex.y < 0.2 ? _OceanColor : _Color;
				//o.color  = -v.vertex.y * _Color;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;

			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv * i.color);
				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);
				return i.color;
			}
			ENDCG
		}
	}
}
