shader_type spatial;
render_mode unshaded, cull_disabled;

uniform vec4 color: source_color = vec4(1.0,0.0,0.0,1.0);

float mid_line(vec2 uv, float thickness)
{
	return float(uv.y < 0.5 + thickness/2.0 && uv.y > 0.5 - thickness/2.0);
}

float fresnel(float amount, vec3 normal, vec3 view)
{
	return pow((1.0 - clamp(dot(normalize(normal),normalize(view)),0.0,1.0)), amount);
}
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float mid_line = mid_line(UV,0.02);
	float rim_fresnel = fresnel(1.5,NORMAL,VIEW);
	float glow = pow(rim_fresnel + 0.2, 1.25);
	ALBEDO = color.rgb * (glow + mid_line) * 3.0;
	ALPHA = glow + mid_line;
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
