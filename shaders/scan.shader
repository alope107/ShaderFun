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

//######################_==_YOYO_SHADER_MARKER_==_######################@~varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D prev;
void main()
{
    vec2 xy = v_vTexcoord.xy;
    
    //float step_size = .005;
    float step_size = .2;
    vec4 red = vec4(1.0, 0.0, 0.0, 1.0);
    vec4 white = vec4(1.0, 1.0, 1.0, 1.0);
    if (xy.x < step_size) {
        vec4 last = texture2D(prev, vec2(1.0, 1.0));
        if(last == red) {
            gl_FragColor = white;
        } else {
            gl_FragColor = red;
        }
    } else {
        vec4 prev = texture2D(prev, vec2(xy.x - step_size, xy.y));
        if (prev == red) {
            gl_FragColor = red;
        } else {
            gl_FragColor = white;
        }
    }
}
