shader_type spatial;
render_mode world_vertex_coords;

const float TURN_POINT = -5.0;

void fragment() {
	if (VERTEX.z < TURN_POINT) {
		ALPHA = 0.0;
	} else {
		ALPHA = 1.0;
	}
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
