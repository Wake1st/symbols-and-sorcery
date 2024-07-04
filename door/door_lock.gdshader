shader_type spatial;

const vec3 base_color = vec3(.302,.173,.129);

uniform float speed = 14.0;
uniform sampler2D flare_texture;

uniform bool hit = false;
uniform vec2 hit_point = vec2(0.5);
uniform float hit_time_ratio = 0.0; 
uniform vec3 color = vec3(.302,.173,.129);


vec2 polar_coordinates(vec2 uv, vec2 center, float zoom, float repeat)
{
	vec2 dir = uv - center;
	highp float radius = length(dir) * 2.0;
	highp float angle = atan(dir.y, dir.x) / TAU;
	return mod(vec2(radius * zoom, angle * repeat), 1.0);
}


void fragment() {
	if (hit) {
		ALBEDO = color;
		
		highp vec2 polar_uv = polar_coordinates(UV, hit_point, 0.3, 1.0);
		float delta_time = hit_time_ratio * 2.0; // sin(TIME * speed);
		ALPHA = (1.0 - polar_uv.x) * delta_time;
	} else {
		ALPHA = 0.0;
	}
}
