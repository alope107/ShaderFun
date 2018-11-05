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
//uniform float inertia;

void main()
{
    float inertia = .001;
    float room_width = 1024.0;
    vec2 xy = v_vTexcoord.xy;
    
    float step_size = 1.0 / room_width;
    
    vec2 steps[4];
    steps[0] = vec2(0, step_size); 
    steps[1] = vec2(0, -1.0 * step_size);
    steps[2] = vec2(step_size, 0);
    steps[3] = vec2(-1.0 * step_size, 0);
    
    float neighbors = 0.0;
    vec4 neighbor_sum = vec4(0.0, 0.0, 0.0, 0.0);
    
    for(int i = 0; i < 4; i++) {
        vec2 neighbor_coord = xy + steps[i];
        if (neighbor_coord.x > 0.0 && 
            neighbor_coord.y > 0.0 && 
            neighbor_coord.x < 1.0 &&
            neighbor_coord.y < 1.0) {
            vec4 neighbor = texture2D(prev, neighbor_coord);
            neighbor_sum += neighbor;
            neighbors += 1.0;
        }
    }
    
    vec4 neighbor_avg = neighbor_sum / vec4(neighbors, neighbors, neighbors, neighbors);
    
    vec4 new = (inertia * texture2D(prev, xy)) + ((1.0-inertia) * neighbor_avg);
    new.a = 1.0;
    
    gl_FragColor = new;
    
    /*if (xy.y < inertia) {
        gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
    }*/
}
