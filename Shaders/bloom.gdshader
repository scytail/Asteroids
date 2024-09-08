shader_type canvas_item;

uniform float bloomIntensity = 1.0;
uniform float bloomDetail = 1.0;
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	vec4 col = texture(screen_texture, UV);
	vec4 bloom = texture(screen_texture, UV, bloomDetail);
	col.rgba += bloom * bloomIntensity;
	COLOR = col;
}