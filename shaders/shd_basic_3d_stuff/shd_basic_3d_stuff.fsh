varying vec2 v_vTexcoord;
varying vec4 v_vColour;

varying vec3 v_worldPosition;
varying vec3 v_worldNormal;

uniform vec3 u_ViewPosition;

void main() {
    vec4 starting_color = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    vec3 ambient_color = vec3(0, 0, 0);
    vec3 light_color = vec3(0.8, 0.8, 0.8);
    vec3 light_dir = normalize(vec3(1, 1, -1));
    
    float specular_strength = 0.5;
    float specular_shininess = 56.0;
    vec3 view_dir = normalize(u_ViewPosition - v_worldPosition);
    //vec3 reflect_dir = reflect(light_dir, v_worldNormal);
    //vec3 half_dir = normalize(-light_dir + view_dir);
    vec3 half_dir = normalize(view_dir - light_dir);
    
    //float specular_intensity = pow(max(dot(view_dir, reflect_dir), 0.0), specular_shininess);
    float specular_intensity = pow(max(dot(v_worldNormal, half_dir), 0.0), specular_shininess);
    vec3 specular_color = specular_strength * specular_intensity * light_color;
    
    float NdotL = max(0.0, -dot(v_worldNormal, light_dir));
    vec3 diffuse_color = NdotL * light_color;
    
    vec3 final_color = starting_color.rgb * (ambient_color + diffuse_color + specular_color);
    gl_FragColor = vec4(final_color, starting_color.a);
}