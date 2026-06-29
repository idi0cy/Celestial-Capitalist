shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

uniform sampler2D mask_texture;

void fragment() {
	vec4 original_color = texture(TEXTURE, UV);
    vec4 mask = texture(mask_texture, UV);

    original_color.a *= mask.a;
    COLOR = original_color;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
