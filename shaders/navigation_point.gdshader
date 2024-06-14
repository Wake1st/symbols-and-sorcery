shader_type spatial;
render_mode cull_disabled, unshaded;


void fragment() {
	ALBEDO = vec3(0.0,0.8,0.2);
	if (VERTEX.y > -10.0) {
		ALPHA = 0.2 * (sin(TIME) * VERTEX.y + 0.5);
	}
}
