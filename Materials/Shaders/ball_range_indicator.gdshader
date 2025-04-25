shader_type spatial;
render_mode unshaded;
render_mode cull_front;

float fresnel(float amount, vec3 normal, vec3 view)
{
	return pow((1.0 - clamp(dot(normalize(normal),normalize(view)),0.0,1.0)), amount);
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// float rim_fresnel = fresnel(1.5, NORMAL, VIEW);
	// ALBEDO = vec3(rim_fresnel);
	ALPHA = 0.1;
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
