#ifndef GAME_H
#define GAME_H

struct vec4 {
    float x;
    float y;
    float z;
    float w;
};

struct color {
    char a;
    char b;
    char g;
    char r;
};

struct moby {
    // The moby position for collision purposes. Usually should not be touched.
    struct vec4 coll_pos;
    // The moby position.
    struct vec4 pos;
    // The moby state.
    char state;
    // The texture mode.
    char texture_mode;
    // The moby opacity.
    unsigned short opacity;
    // The moby model.
    void* model;
    // The parent moby, if existing.
    struct moby* parent;
    // The 3D scaling applied to the model.
    float scale;
    // Unknown, 0x30
    char unk_30;
    // Whether or not the moby is visible (readonly).
    char visible;
    // The distance at which the moby will start fading out.
    short render_distance;
    // Unknown, 0x34
    void* unk_34;
    // Controls the coloring of the moby.
    struct color color;
    // Controls the shading of the moby, through mechanisms unknown.
    unsigned int shading;
    // The moby rotation in radians. Typically only Z needs to be changed.
    struct vec4 rot;
    // The previous frame number of the current animation.
    char prev_anim_frame;
    // The current frame number of the current animation.
    char curr_anim_frame;
    // asdf
    char asdf[0x26];
    // The moby's pVars.
    void* pvars;
    // asdf2
    char asdf2[0x2A];
    // The type of moby it is.
    unsigned short type;
    // asdf3
    char asdf3[0x58];
};

extern struct moby* player_moby;
extern int player_bolts;
extern int current_planet;

extern unsigned should_load;
extern int level_frame_count;

extern struct moby* spawn_moby(unsigned short class);
extern void memcpy(void* dst, void* src, unsigned int length);
extern int printf(char* msg, ...);

#endif // GAME_H
