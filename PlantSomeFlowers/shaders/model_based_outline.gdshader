shader_type spatial;
render_mode blend_mix, cull_front, unshaded, depth_draw_always, fog_disabled;

uniform vec4 color : source_color = vec4(1,1,1,1);
uniform float thickness : hint_range(1.0, 2.0) = 1.05;

void vertex() {
    VERTEX *= thickness;
}

void fragment() {
    ALBEDO = color.rgb;
    ALPHA = color.a;
}
