#ifndef HOOK_H
#define HOOK_H

enum hook_target {
    HOOK_INPUT = 0,
    HOOK_DRAW = 1,
};

enum hook_priority {
    PRIO_EARLY = 1,
    PRIO_NORMAL = 2,
    PRIO_LATE = 3,
};

struct hook_info {
    void(*local_func)();
    enum hook_target target;
    enum hook_priority priority;
};

extern void hook(struct hook_info* info);
extern void unhook(struct hook_info* info);

#endif // HOOK_H
