# TODO

Embeds a sys_overlay loader in a game's EBOOT, which then looks for overlay files, loading them and calling their entry point function, where they can do one-time initialization and specify hooks at certain points, which are managed and created by the loader. Overlays can probably also just create a thread instead of relying on hooks if they so desire.

Organizational improvement ideas are welcome.

Put addresses in `linker.ld`.

Stack corruption can happen, especially calling variadic functions like `printf`.
