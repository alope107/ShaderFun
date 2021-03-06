//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.	
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec2 xy = v_vTexcoord.xy;
    float div = 10.0;
    float base = .7;
    vec4 col = vec4(xy.x * xy.y, xy.x + xy.y, xy.y, 1.0);
    col /= div;
    col += base;
    col.a = 1.0;
    gl_FragColor = col;
    /*vec4 red = vec4(1.0, 0.0, 0.0, 1.0);
    vec4 white = vec4(1.0, 1.0, 1.0, 1.0);
    
    if (xy.x > .5 && xy.x < .6 && xy.y > .5 && xy.y < .6) {
        gl_FragColor = red;
    } else {
        gl_FragColor = white;
    }*/
    
    //gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}

