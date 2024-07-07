shader_type spatial;
render_mode unshaded;

const float a = 5.;
const float n = 20.;

const float speed = 0.1;
const float thickness = 0.1;

uniform bool running = false;
uniform float start_time;
uniform vec3 color = vec3(0.1,0.0,0.9);


void fragment() {
	if (running) {
		float delta_T = TIME - start_time;
		
		float r = sin(delta_T * speed);
		float r_min = r - thickness;
		float r_max = r + thickness;
		
		float x_min = (r_min + a * sin(n * delta_T)) * cos(delta_T);
		float x_max = (r_max + a * sin(n * delta_T)) * cos(delta_T);
		float y_min = (r_min + a * sin(n * delta_T)) * sin(delta_T);
		float y_max = (r_max + a * sin(n * delta_T)) * sin(delta_T);
		
		if ((VERTEX.x < x_max && VERTEX.x > x_min && VERTEX.y < y_max && VERTEX.y > y_min) 
		|| (VERTEX.x > -x_max && VERTEX.x < -x_min && VERTEX.y > -y_max && VERTEX.y < -y_min)) {
			ALPHA = 1.0;
		} else {
			ALPHA = 0.0;
		}
		
		EMISSION = color;
		ALBEDO = color;
	} else {
		ALPHA = 0.0;
	}
}


//shader_type spatial;
//
//const vec3 base_color = vec3(.302,.173,.129);
//
//uniform float speed = 14.0;
//uniform sampler2D flare_texture;
//
//uniform bool hit = false;
//uniform vec2 hit_point = vec2(0.5);
//uniform float hit_time_ratio = 0.0; 
//uniform vec3 color = vec3(.302,.173,.129);
//
//
//vec2 polar_coordinates(vec2 uv, vec2 center, float zoom, float repeat)
//{
	//vec2 dir = uv - center;
	//highp float radius = length(dir) * 2.0;
	//highp float angle = atan(dir.y, dir.x) / TAU;
	//return mod(vec2(radius * zoom, angle * repeat), 1.0);
//}
//
//
//void fragment() {
	//if (hit) {
		//ALBEDO = color;
		//
		//highp vec2 polar_uv = polar_coordinates(UV, hit_point, 0.3, 1.0);
		//float delta_time = hit_time_ratio * 2.0; // sin(TIME * speed);
		//ALPHA = (1.0 - polar_uv.x) * delta_time;
	//} else {
		//ALPHA = 0.0;
	//}
//}
