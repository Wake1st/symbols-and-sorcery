shader_type spatial;
render_mode cull_disabled;

const float RADIUS = 0.8;
const float rotationalSpeed = 0.2;


float get_closest_dot(float current, float compared) {
	if (compared > current) { return compared; } 
	else { return current; }
}


void vertex() {
	if (VERTEX.y > 0.0) {
		float closest_dot = -1.0;
		float theta = TIME * rotationalSpeed;
		vec2 vertex_radial = normalize(vec2(VERTEX.x, VERTEX.z));
		
		vec2 moving_radial = vec2(
			RADIUS * cos(theta), 
			RADIUS * sin(theta)
		);
		float dot_compare = dot(vertex_radial, normalize(moving_radial));
		closest_dot = get_closest_dot(closest_dot, dot_compare);
		
		moving_radial = vec2(
			RADIUS * cos(theta + PI*2./3.), 
			RADIUS * sin(theta + PI*2./3.)
		);
		dot_compare = dot(vertex_radial, normalize(moving_radial));
		closest_dot = get_closest_dot(closest_dot, dot_compare);
		
		moving_radial = vec2(
			RADIUS * cos(theta + PI*4./3.), 
			RADIUS * sin(theta + PI*4./3.)
		);
		dot_compare = dot(vertex_radial, normalize(moving_radial));
		closest_dot = get_closest_dot(closest_dot, dot_compare);
		
		VERTEX.y *= closest_dot;
	}
}


void fragment() {
	ALBEDO = vec3(0.0,0.8,0.2);
	ALPHA = 0.4;
}
