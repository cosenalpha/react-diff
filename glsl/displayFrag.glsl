varying vec2 v_uv;
uniform sampler2D textureToDisplay;
uniform sampler2D previousIterationTexture;
uniform float time;

uniform int renderingStyle;

uniform vec4 colorStop1;
uniform vec4 colorStop2;
uniform vec4 colorStop3;
uniform vec4 colorStop4;
uniform vec4 colorStop5;

uniform vec2 hslFrom;
uniform vec2 hslTo;
uniform float hslSaturation;
uniform float hslLuminosity;

// http://theorangeduck.com/page/avoiding-shader-conditionals
float when_eq(float x, float y)  { return 1.0 - abs(sign(x - y)); }
float when_neq(float x, float y) { return abs(sign(x - y)); }
float when_gt(float x, float y)  { return max(sign(x - y), 0.0); }
float when_lt(float x, float y)  { return max(sign(y - x), 0.0); }
float when_le(float x, float y)  { return 1.0 - max(sign(x - y), 0.0); }
float when_ge(float x, float y)  { return 1.0 - max(sign(y - x), 0.0); }

float map(float value, float min1, float max1, float min2, float max2) {
  return min2 + (value - min1) * (max2 - min2) / (max1 - min1);
}


void main() {
  vec4 previousPixel = texture2D(previousIterationTexture, v_uv);
  vec4 pixel = texture2D(textureToDisplay, v_uv);
  float A = pixel[0];
  float B = pixel[1];
  vec4 outputColor;

  // HSL mapping ==================================================================================
    if(renderingStyle == 6) {
    float grayValue = pixel.r - pixel.g;  // black for B, white for A
    // float grayValue = 1.0 - pixel.r - pixel.g;  // white for B, black for A
    outputColor = vec4(grayValue, grayValue, grayValue, 1.0);

  // Black and white (sharp) ======================================================================
  } else if(renderingStyle == 7) {
    float grayValue = pixel.r - pixel.g;

    if(grayValue > .3) {
      outputColor = vec4(1.0, 1.0, 1.0, 1.0);
    } else {
      outputColor = vec4(0.0, 0.0, 0.0, 1.0);
    }

  // No processing - red for chemical A, green for chemical B =====================================
  } 

  gl_FragColor = outputColor;
}