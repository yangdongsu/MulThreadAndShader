//-----------------------
//抓取屏幕
//-----------------------

Shader "TS/TSGrab"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	    _Color ("InitColor", Color) = (1, 1, 1, 1)
	}
	SubShader
	{
		Tags { "RenderType"="Transparent"  "Queue" = "Transparent" }
		LOD 100

		GrabPass
		{
		}

		Pass
		{
			ZTest LEqual
			Blend SrcAlpha OneMinusSrcAlpha
			

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			fixed4 _Color;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				col = _Color;
				return col;
			}
			ENDCG
		}


		Pass
		{
		    ZTest Greater
			ZWrite Off

			CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

			struct appdata
		    {
			     float4 vertex : POSITION;
			     float2 uv : TEXCOORD0;
		     };

		     struct v2f
		     {
			     float2 uv : TEXCOORD0;
			     float4 vertex : SV_POSITION;
				 float4 screenuv : TEXCOORD1;
		     };

		     sampler2D _MainTex;
		     float4 _MainTex_ST;
			 sampler2D _GrabTexture;
			 float _GrabTexture_ST;
		     fixed4 _Color;

		     v2f vert(appdata v)
		     {
			      v2f o;
			      o.vertex = UnityObjectToClipPos(v.vertex);
			      o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				  o.screenuv = ComputeGrabScreenPos(o.vertex);
			      return o;
		     }

		     fixed4 frag(v2f i) : SV_Target
		     {
				  fixed4 dst = tex2D(_GrabTexture, float2(i.screenuv.x / i.screenuv.w, i.screenuv.y / i.screenuv.w));
			      fixed4 col = tex2D(_MainTex, i.uv);
				  fixed4 src = _Color;
		          //col = _Color;
				  //col = fixed4(1, 1, 1, 1);
				  fixed3 colo = fixed3(0, 0, 0);
				  fixed al = 0;

				  if (src.a == 0 || dst.a == 1)
				  {
					  colo = dst.rgb;
					  al = dst.a;

					 /* colo = fixed3(1, 1, 1);
					  al = 1;*/
				  }
				  else
				  {
					  colo = dst.rgb *  dst.a + (1.0 - dst.a)  * src.a * src.rgb;
					  al = dst.a * dst.a + (1 - dst.a) * src.a;

					  /*colo = fixed3(0, 0, 0);
					  al = 1;*/
				  }


				  col = fixed4(colo, al);
		          return col;
		      }
			  ENDCG
		}
	}
}
