shader_type spatial;
render_mode cull_disabled, unshaded;

void vertex() {
	//float wave = cos(PI * TIME * 0.2)/VERTEX.x;
	//VERTEX.y = sin(TIME) * (VERTEX.y + 0.2) - 0.2;
}

void fragment() {
	ALBEDO = vec3(0.0,0.8,0.2);
	ALPHA = 0.1 - VERTEX.y;
}
