Shader "Platogo/Curved" {
	Properties {
  	_MainTex ("Base (RGB)", 2D) = "white" {}
  	_QOffset ("Offset", Vector) = (0,0,0,0)
  	_Dist ("Distance", Float) = 100.0
  }
	SubShader {
		Tags { "RenderType"="Opaque" }
		Pass
		{
			Lighting Off

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			float4 _QOffset;
			float _Dist;
			uniform float4 _MainTex_ST;
			
			struct v2f {
        float4 pos : SV_POSITION;
        float2 uv : TEXCOORD0;
			};

			v2f vert (appdata_base v)
			{
        v2f o;
        float4 vPos = mul (UNITY_MATRIX_MV, v.vertex);
        float zOff = vPos.z/_Dist;
        vPos += _QOffset*zOff*zOff;
        o.pos = mul (UNITY_MATRIX_P, vPos);
        o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
        return o;
			}

			half4 frag (v2f i) : COLOR
			{
			  return tex2D(_MainTex, i.uv);
			}
			ENDCG
		}
	}
	FallBack "Mobil/Unlit"
}
