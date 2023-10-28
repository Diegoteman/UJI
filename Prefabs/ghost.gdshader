shader_type canvas_item;

uniform vec4 Color1: source_color;
uniform vec4 Color2: source_color;

void fragment() {
	vec4 curr_color = texture(TEXTURE,UV); // Get current color of pixel
	
	if (curr_color == Color1){
		COLOR = Color2;
	}else{
		COLOR = curr_color;
	}
}
