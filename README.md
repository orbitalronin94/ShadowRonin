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

Open the project root in **Godot 4.3+** and run the main scene. The initial target is Godot Mobile. Compatibility remains a fallback to benchmark on lower-end devices; the final renderer decision depends on physical Android tests.

This is an early playable scaffold, not a finished visual slice. Character models, animation-driven hit windows, proper virtual joystick, audio, final VFX and physical-device performance tests remain outstanding. No Android performance claim is made until APK testing on real devices.

See [LICENSE](LICENSE). Third-party art, audio, fonts and other assets will be tracked separately.


## Ten-seal encounter lineup

1. **Kuro, the Hound of the Threshold** — telegraphed lunges and punish windows.
2. **The Lady of a Hundred Needles** — projectile fans and approach timing.
3. **Gorazan, the Gaoler** — heavy grabs, arena pressure and stagger.
4. **Shigure, the Hollow Monk** — chained attacks and parry tests.
5. **The Crimson Widow** — vertical movement and camera tracking.
6. **Baal-Tor, the Ashen Bull** — charges and environmental hazards.
7. **The Faceless King** — adaptive patterns and feints.
8. **Mizuchi, the Flood Serpent** — area attacks and multi-phase movement.
9. **The General of a Thousand Dead** — boss plus adds and actor-count stress.
10. **The Emperor of the Tenth Gate** — combined mechanics and final phase escalation.

The campaign should preserve short transitions and minimal dialogue. Each duel introduces one new combat or presentation test while reusing the same core systems.
