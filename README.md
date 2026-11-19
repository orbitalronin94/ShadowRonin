# ShadowRonin

A dark-fantasy action game built around ten consecutive demon duels. The story is delivered through short, pre-written lore passages; combat is the core experience.

## Current milestone: Kuro vertical slice

The first encounter is **Kuro, the Hound of the Threshold**. This prototype uses procedural placeholder geometry so combat timing, readability, camera, feedback and Android constraints can be tested before selecting final character and environment assets.

### Implemented scaffold
- Third-person movement, attack and dodge.
- Dodge grants a short invulnerability window.
- Kuro approaches, telegraphs an area strike, attacks and recovers.
- Health bars, victory/defeat states and retry.
- Procedural arena, dark lighting, fog, emissive eyes and hit flash.
- Keyboard controls and basic on-screen touch buttons.

### Controls
| Action | Keyboard |
|---|---|
| Move | WASD |
| Attack | J |
| Dodge | Space |
| Retry after encounter | R |

Open the project root in **Godot 4.3+** and run the main scene. The first boot target is Compatibility; Mobile/Vulkan must be profiled on physical Android devices before choosing a release renderer.

This is an early playable scaffold, not a finished visual slice. Character models, animation-driven hit windows, proper virtual joystick, audio, final VFX and physical-device performance tests remain outstanding. No Android performance claim is made until APK testing on real devices.

See [LICENSE](LICENSE). Third-party art, audio, fonts and other assets will be tracked separately.
