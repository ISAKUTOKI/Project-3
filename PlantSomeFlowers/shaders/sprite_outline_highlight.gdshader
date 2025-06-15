shader_type spatial;
render_mode unshaded, depth_draw_opaque;

uniform vec4 outline_color : source_color = vec4(1.0, 0.8, 0.0, 1.0);
uniform float outline_width : hint_range(0.0, 0.1) = 0.01;
uniform sampler2D albedo_texture : source_color;

void fragment() {
    // 获取纹理尺寸
    vec2 tex_size = vec2(textureSize(albedo_texture, 0));
    vec2 pixel_size = 1.0 / tex_size;
    
    // 计算描边偏移量
    vec2 offsets[8] = vec2[](
        vec2(-1, -1), vec2(0, -1), vec2(1, -1),
        vec2(-1,  0),              vec2(1,  0),
        vec2(-1,  1), vec2(0,  1), vec2(1,  1)
    );
    
    // 当前像素的透明度
    float alpha = texture(albedo_texture, UV).a;
    
    // 检查周围像素
    float outline_alpha = 0.0;
    for(int i = 0; i < 8; i++) {
        vec2 offset = offsets[i] * pixel_size * outline_width * 10.0;
        outline_alpha += texture(albedo_texture, UV + offset).a;
    }
    
    // 如果当前像素透明但周围不透明，则绘制描边
    if(alpha < 0.5 && outline_alpha > 0.1) {
        ALBEDO = outline_color.rgb;
        ALPHA = outline_color.a;
    } else {
        vec4 tex_color = texture(albedo_texture, UV);
        ALBEDO = tex_color.rgb;
        ALPHA = tex_color.a;
    }
}