shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

/* MASTER CONTROL */
uniform float freeze_amount : hint_range(0.0, 1.0) = 0.0;

/* Frost shape */
uniform float frost_size : hint_range(0.0, 0.5) = 0.28;
uniform float frost_softness : hint_range(0.01, 0.3) = 0.1;

/* Ice detail */
uniform float crystal_scale = 18.0;
uniform float finger_strength : hint_range(0.0, 1.0) = 0.8;
uniform float detail_strength : hint_range(0.0, 1.0) = 0.6;

/* Color */
uniform vec3 frost_color : source_color = vec3(0.85, 0.93, 1.0);
uniform vec3 cold_tint : source_color = vec3(0.75, 0.85, 1.0);
uniform float global_cold : hint_range(0.0, 1.0) = 0.25;

uniform float opacity : hint_range(0.0, 1.0) = 1.0;

/* Noise helpers */
float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(
        mix(hash(i), hash(i + vec2(1.0, 0.0)), u.x),
        mix(hash(i + vec2(0.0, 1.0)), hash(i + vec2(1.0, 1.0)), u.x),
        u.y
    );
}

float fbm(vec2 p) {
    float v = 0.0;
    float a = 0.5;
    for (int i = 0; i < 4; i++) {
        v += noise(p) * a;
        p *= 2.0;
        a *= 0.5;
    }
    return v;
}

void fragment() {
    vec2 uv = SCREEN_UV;

    vec3 original = texture(SCREEN_TEXTURE, uv).rgb;

    float edge_dist = min(
        min(uv.x, 1.0 - uv.x),
        min(uv.y, 1.0 - uv.y)
    );

    // Frost grows inward as freeze increases
    float dynamic_size = frost_size * freeze_amount;

    float frost = smoothstep(
        dynamic_size,
        dynamic_size - frost_softness,
        edge_dist
    );

    vec2 to_center = normalize(uv - vec2(0.5));

    float fingers = fbm(
        uv * vec2(crystal_scale * 2.0, crystal_scale * 0.5)
        + to_center * 12.0
    );
    frost *= mix(1.0, fingers, finger_strength * freeze_amount);

    float detail = fbm(uv * crystal_scale * 2.5);
    frost *= mix(1.0, detail, detail_strength * freeze_amount);

    frost = clamp(frost, 0.0, 1.0);

    // Cold tint applied globally
    vec3 cold_screen = mix(original, cold_tint, global_cold * freeze_amount);

    vec3 icy = mix(cold_screen, frost_color, frost);

    icy += frost * 0.06 * freeze_amount;

    // Final blend: freeze_amount = 0 → original screen
    vec3 final_color = mix(original, icy, freeze_amount);

    COLOR = vec4(final_color, opacity);
}

