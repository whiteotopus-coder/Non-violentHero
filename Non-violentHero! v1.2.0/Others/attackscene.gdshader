shader_type canvas_item;

uniform bool shadow_enabled = false;
uniform float shadow_strength : hint_range(0.0, 1.0) = 0.5;
uniform vec4 shadow_color = vec4(0.0, 0.0, 0.0, 1.0);

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);

    if (shadow_enabled) {
        // 灰色陰影效果：讓顏色變暗 + 混合灰色
        COLOR = mix(tex_color, shadow_color, shadow_strength) * tex_color.a;
    } else {
        COLOR = tex_color;
    }
}
