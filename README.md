# FovAlways120 (Cyberpunk 2077)

Cyber Engine Tweaks mod that pins the first-person camera FOV at 120 whenever you're in gameplay — and automatically releases the lock while any menu is open, so the world map's 3D camera pans correctly.

## Why

The popular alternative (FovLock120) enforces FOV every second by force-locking the FOV pipeline with FovControl. The world map renders through its own camera and needs to set its FOV while open, so a standing global FOV lock makes the map's 3D layer and its 2D legend/waypoint layer pan at mismatched speeds until a lock window happens to let the map's update land.

This mod solves that by reading the game's own `UI_System.IsInMenu` blackboard flag (same signal the vanilla HUD code uses) and only locking FOV when no menu is active.

## Requirements

- [Cyber Engine Tweaks](https://github.com/maximegmd/CyberEngineTweaks)
- [FovControl](https://www.nexusmods.com/cyberpunk2077/mods/25677) (provides the FOV lock API)

Do not run this alongside FovLock120 — they fight over the same lock.

## Install

Copy the `FovAlways120` folder into `bin/x64/plugins/cyber_engine_tweaks/mods/`.

```
bin/x64/plugins/cyber_engine_tweaks/mods/FovAlways120/init.lua
```

## Behavior

- FOV enforced at 120 every 0.5s while in gameplay
- FOV lock released whenever a menu (world map included) is open
- FOV re-locks within 0.5s of leaving the menu
- Releases the patch cleanly on game shutdown

Tweak `TARGET` at the top of `init.lua` if you want a different value.

## License

GPL-3.0 — see [LICENSE](LICENSE).