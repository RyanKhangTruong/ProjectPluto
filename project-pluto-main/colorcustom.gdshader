shader_type canvas_item;

uniform vec4 red : hint_color;
uniform vec4 green : hint_color;
uniform vec4 blue : hint_color;
uniform vec4 black : hint_color;

void fragment() {
	vec4 rgba_in = texture(TEXTURE, UV);
	
	// color defaults to the black replacement color
	vec3 rgb_out = black.rgb;
	
	// mix in other colors based on the red, green and blue components of the source image
	rgb_out = mix(rgb_out, red.rgb, rgba_in.r);
	rgb_out = mix(rgb_out, green.rgb, rgba_in.g);
	rgb_out = mix(rgb_out, blue.rgb, rgba_in.b);
	
	if (rgb_out == black.rgb){
		COLOR = rgba_in
	}
	else
	{
	// Assign final color for the pixel, and preserve transparency
	COLOR = vec4(rgb_out.rgb, rgba_in.a);	
	}
}
