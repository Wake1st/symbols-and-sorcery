shader_type spatial;
render_mode unshaded;

const float a = 0.02;
const float n = 12.0;

const vec2 origin = vec2(.5,.5);
const float speed = 0.6;
const float lines = 3.0;
const float line_radial_diff = 0.016;
const float wave_incrementor = 3.0;

uniform bool running = false;
uniform float delta_T;
uniform vec3 color;


void fragment() {
	if (running) {
		bool has_passed = false;
		float wave_count = n;
		
		for (float i=0.; i<lines; i++) {
			float thickness = mix(0.011, 0.0, delta_T);
			float amp = mix(0.008,0.02,delta_T);
			float N = wave_count + i*wave_incrementor;
			float psi = (2.2 + i*PI)/delta_T;
			float phase = i/lines*(2.*PI/N);
			
			float r = delta_T * speed - i*line_radial_diff;
			float r_min = r - thickness;
			float r_max = r + thickness;
			
			float theta = atan(UV.y - origin.y, UV.x - origin.x);
			 
			float x_min = (r_min + amp * sin(N * (theta + psi + phase))) * cos(theta) + origin.x;
			float x_max = (r_max + amp * sin(N * (theta + psi + phase))) * cos(theta) + origin.x;
			float y_min = (r_min + amp * sin(N * (theta + psi + phase))) * sin(theta) + origin.y;
			float y_max = (r_max + amp * sin(N * (theta + psi + phase))) * sin(theta) + origin.y;
			
			if (
				 (UV.x < x_max && UV.x > x_min && UV.y < y_max && UV.y > y_min)
			|| (UV.x > x_max && UV.x < x_min && UV.y < y_max && UV.y > y_min) 
			|| (UV.x < x_max && UV.x > x_min && UV.y > y_max && UV.y < y_min)
			|| (UV.x > x_max && UV.x < x_min && UV.y > y_max && UV.y < y_min)
			) {
				ALPHA = 1.0;
				break;
			} else {
				ALPHA = 0.0;
			}
		}
		
		
		EMISSION = color;
		ALBEDO = color;
	} else {
		ALPHA = 0.0;
	}
}
