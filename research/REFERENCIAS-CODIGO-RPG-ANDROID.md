# Cuaderno de investigación técnica — ShadowRonin

> Registro único de referencias de código, sistemas y decisiones técnicas que merece la pena estudiar para construir más adelante un RPG para Android. Este documento es un cuaderno de investigación, no una especificación del juego ni una decisión de motor.
>
> **Regla de trabajo:** estudiar primero implementaciones reales; distinguir siempre entre juegos completos, motores, demos y vertical slices. No copiar assets ni asumir que la licencia del código cubre arte, música, fuentes o narrativa.

## Criterios de lectura

Para cada proyecto buscamos, en este orden:

1. **Combate:** estados de ataque, ventanas de impacto, combos, cancelaciones, esquiva, bloqueo, stagger, hitstop, jefes y telegráficos.
2. **Sensación audiovisual:** animación, cámara, partículas, shaders, iluminación, sonido sincronizado y feedback de impacto.
3. **Arquitectura:** entidades, componentes, escenas, eventos, máquinas de estados, datos configurables y separación entre lógica y presentación.
4. **Android:** renderer móvil, entrada táctil, memoria, carga de recursos, compresión de texturas, resolución dinámica, rendimiento sostenido y consumo térmico.
5. **Producción:** herramientas, pipeline de assets, pruebas, estructura de datos, licencias y documentación.

No damos por probado el rendimiento móvil porque un proyecto tenga un preset Android o compile para Android: hace falta una prueba en dispositivo físico.

---

## 1. Combate, entidades y efectos

### OpenRA — arquitectura de actores y componentes

- Repositorio: https://github.com/OpenRA/OpenRA
- [World.cs — mundo y ciclo de simulación](https://github.com/OpenRA/OpenRA/blob/bleed/OpenRA.Game/World.cs)
- [Actor.cs — entidad/actor y composición](https://github.com/OpenRA/OpenRA/blob/bleed/OpenRA.Game/Actor.cs)
- **Qué extraer:** cómo se organizan las entidades, cómo se componen mediante Traits y cómo se separan las reglas del mundo de los objetos individuales.
- **Aplicación posible:** arquitectura de personajes, enemigos, objetos interactivos y componentes de combate.
- **Tipo de referencia:** motor/juego RTS maduro; no es un RPG de acción.

### Mindustry — unidades y efectos visuales

- Repositorio: https://github.com/Anuken/Mindustry
- [Units.java — lógica de unidades](https://github.com/Anuken/Mindustry/blob/master/core/src/mindustry/entities/Units.java)
- [Effect.java — sistema de efectos](https://github.com/Anuken/Mindustry/blob/master/core/src/mindustry/entities/Effect.java)
- **Qué extraer:** consultas y operaciones sobre unidades, ciclo de vida de entidades y efectos temporales desacoplados.
- **Aplicación posible:** impactos, explosiones, polvo, estelas, avisos visuales y efectos reutilizables.
- **Tipo de referencia:** juego completo multiplataforma; no es un RPG.

### Battle for Wesnoth — resolución de ataques

- Repositorio: https://github.com/wesnoth/wesnoth
- [attack.cpp — resolución de ataques](https://github.com/wesnoth/wesnoth/blob/master/src/actions/attack.cpp)
- **Qué extraer:** resolución de intercambios, reglas de ataque y separación entre acción y resultado.
- **Aplicación posible:** lógica determinista de golpes, daño, estados y combate por turnos; comparar con el combate en tiempo real que buscamos.
- **Tipo de referencia:** juego táctico completo; no es un ARPG.

---

## 2. RPG completos y sistemas de juego

### OpenMW — arquitectura de RPG 3D de mundo abierto

- Repositorio: https://github.com/OpenMW/openmw
- **Qué estudiar:** mundo, referencias/objetos, scripts, quests, inventario, diálogos, persistencia, recursos y separación entre motor y contenido.
- **Punto de partida:** [código fuente](https://github.com/OpenMW/openmw/tree/master) y [documentación del proyecto](https://openmw.org).
- **Aplicación posible:** sistemas de mundo, misiones, objetos, interacción y persistencia.
- **Límite:** proyecto de escritorio; requiere los datos originales de Morrowind para jugar. No es una base Android directa.

### Valyria Tear — JRPG 2D con combate activo

- Repositorio: https://github.com/ValyriaTear/ValyriaTear
- **Qué estudiar:** estructura de un JRPG, personajes, enemigos, progresión, inventario, escenas, narrativa y batallas laterales activas.
- **Aplicación posible:** organización de contenido y sistemas clásicos de RPG.
- **Límite:** su estética y tecnología son una referencia 2D, no el objetivo visual final.
- **Licencias:** comprobar por separado código, gráficos, música, fuentes y narrativa antes de reutilizar cualquier recurso.

### Shattered Pixel Dungeon — juego Android publicado

- Repositorio: https://github.com/00-Evan/shattered-pixel-dungeon
- [Guía de compilación Android](https://github.com/00-Evan/shattered-pixel-dungeon/blob/master/docs/getting-started-android.md)
- **Qué estudiar:** estructura de un juego Android real, ciclo de juego, inventario, objetos, generación de niveles, enemigos, guardado y adaptación a dispositivos.
- **Aplicación posible:** referencia de integración Android y ciclo completo de producto.
- **Límite:** roguelike de pixel art; útil por sus sistemas y su trayectoria móvil, no como patrón de gráficos de lujo.

### Veloren — mundo RPG 3D y sistemas de juego

- Repositorio: https://github.com/veloren/veloren
- **Qué estudiar:** mundo 3D, entidades, criaturas, animación, multijugador y organización de un RPG de fantasía.
- **Aplicación posible:** explorar soluciones de mundo y sistemas 3D.
- **Límite:** desarrollo activo; no tratarlo como juego terminado ni asumir que sus sistemas están estabilizados. Revisar la licencia de cada recurso.

---

## 3. Combate de acción y presentación visual

> Los siguientes proyectos son especialmente útiles para estudiar una escena de combate espectacular. Algunos son demos o vertical slices: sirven para analizar una mecánica concreta, pero no prueban que exista un juego completo ni que toda la arquitectura esté lista para producción.

### Mistpaw — action RPG HD-2D y jefe por fases

- Repositorio: https://github.com/Chuanyin1202/mistpaw
- **Qué estudiar:** combos de tres golpes, ataques pesados y giratorios, esquivas, salto doble, botín, reliquias y jefe con varias fases.
- **Sistemas visuales a inspeccionar:** capas 2D sobre entorno 3D, iluminación, sombras, reflejos, partículas y audio posicional.
- **Aplicación posible:** ritmo del combate, transiciones de animación, lectura de ataques y composición de una arena.
- **Estado:** vertical slice de un nivel, no juego completo. Las capturas Forward+ de escritorio no demuestran rendimiento Android.
- **Licencias:** código MIT según el proyecto; verificar por separado arte, audio y fuentes.

### Cairnfall — combate 3D contra jefes

- Repositorio: https://github.com/euuuuuuan/cairnfall-public
- **Qué estudiar:** jefes de varias fases, ataques telegrafiados, ventanas de castigo y lectura espacial del combate.
- **Aplicación posible:** diseñar encuentros memorables y hacer que el jugador entienda el peligro antes del impacto.
- **Estado:** vertical slice centrada en boss raids, no RPG completo.
- **Licencias:** el código declara Apache-2.0; comprobar individualmente modelos, texturas, audio y otros assets.

### Ashfall — restricciones de renderizado móvil en Godot

- Repositorio: https://github.com/GPTmadeit/ashfall
- [TECH.md — decisiones técnicas y límites del renderer](https://github.com/GPTmadeit/ashfall/blob/main/docs/TECH.md)
- **Qué estudiar:** Mobile Renderer, materiales PBR, packed ORM, normal detail, rim lighting, hit flash, dissolve, resolución dinámica y compresión ASTC/ETC2.
- **Aplicación posible:** conseguir riqueza visual mediante técnicas compatibles con GPU móvil, sin depender de efectos de escritorio costosos.
- **Límite importante:** la documentación describe objetivos y decisiones técnicas; no equivale a una validación de FPS, temperatura o consumo en un teléfono físico. El proyecto no debe citarse como benchmark Android probado.

### Godot Open RPG — demo de combate y estructura

- Repositorio: https://github.com/gdquest-demos/godot-open-rpg
- **Qué estudiar:** organización de un RPG por turnos, escenas, datos y lógica de combate en Godot.
- **Aplicación posible:** referencia didáctica para estructura de proyecto y separación de responsabilidades.
- **Límite:** demo educativa; no es un juego completo ni una referencia de gráficos de alta gama.

### Tactical Slash — RPG táctico 3D con Android

- Repositorio: https://github.com/sion-rgb/tactical-slash
- **Qué estudiar:** escenas 3D, animaciones, IA y flujo táctico con destino Android.
- **Aplicación posible:** revisar controles, adaptación de interfaz y empaquetado móvil.
- **Límite:** proyecto de alcance reducido; verificar estado actual, dispositivo probado y calidad real antes de tomar decisiones.

---

## 4. Referencias complementarias de diseño y contenido

### OpenTTD — mapas, tiles y vehículos

- Repositorio: https://github.com/OpenTTD/OpenTTD
- [vehicle.cpp](https://github.com/OpenTTD/OpenTTD/blob/master/src/vehicle.cpp)
- [tile_type.h](https://github.com/OpenTTD/OpenTTD/blob/master/src/tile_type.h)
- **Qué extraer:** sistemas de objetos móviles, tipos de terreno y datos del mundo.
- **Aplicación posible:** ideas de modelado de mundo y simulación; referencia indirecta, no de combate.

---

## 5. Preguntas que deben resolverse leyendo código

- ¿El combate se implementa con una máquina de estados por personaje, un sistema de habilidades basado en datos o una combinación?
- ¿Cómo se sincronizan los fotogramas de animación con hitboxes y ventanas de daño?
- ¿Cómo se implementan hitstop, retroceso, stagger, invulnerabilidad y cancelación de combos?
- ¿Cómo se coordinan cámara, partículas, sonido, iluminación y vibración en el instante del impacto?
- ¿Cómo se diseñan ataques de jefe que sean espectaculares pero legibles?
- ¿Qué efectos se calculan en shader y cuáles se resuelven con geometría, partículas o sprites?
- ¿Qué coste tienen sombras, transparencias, materiales y luces dinámicas en GPU móvil?
- ¿Qué se carga de forma asíncrona y cómo se evita bloquear el hilo principal?
- ¿Cómo se controla el consumo de memoria y el calentamiento en sesiones largas?
- ¿Qué controles táctiles permiten precisión sin tapar la escena?

## 6. Protocolo para añadir nuevas referencias

Cada nueva entrada debe incluir:

- **Proyecto y URL** del repositorio.
- **Archivos concretos** (no solo la portada del repositorio).
- **Sistema observado** y qué hace realmente el código.
- **Lección reutilizable** para ShadowRonin.
- **Estado del proyecto:** juego completo, motor, demo, prototipo o vertical slice.
- **Plataformas probadas** y evidencia disponible; separar “compila” de “funciona bien en dispositivo”.
- **Licencia del código** y advertencia sobre licencias independientes de assets.
- **Pendiente de verificar**, si todavía no hemos leído el código fuente correspondiente.

No añadir una referencia solo porque el README prometa algo: localizar el archivo que implementa el sistema y anotar qué hemos comprobado. Mantener este único Markdown como índice y cuaderno central; no dispersar la investigación en documentos separados.

---

## 7. Segunda ronda: combate, sincronización y sistemas extensibles

Esta ronda se ha contrastado con archivos de código concretos, no solo con los README.

### Grim Delver — simulación de combate separada de la presentación

- Repositorio: https://github.com/blackopsrepl/grim-delver
- [README y arquitectura Godot + Rust](https://github.com/blackopsrepl/grim-delver/blob/main/README.md)
- [model/combat.rs — resolución de ataques](https://github.com/blackopsrepl/grim-delver/blob/main/rust/src/model/combat.rs)
- [game/combat.rs — efectos, audio y cámara](https://github.com/blackopsrepl/grim-delver/blob/main/rust/src/game/combat.rs)
- [model/tests/combos.rs — pruebas de combos](https://github.com/blackopsrepl/grim-delver/blob/main/rust/src/model/tests/combos.rs)
- [animation.rs — clips y animación](https://github.com/blackopsrepl/grim-delver/blob/main/rust/src/animation.rs)
- **Observación:** el estado del juego conserva ataques pendientes. El momento de impacto se calcula usando la duración del clip y el fotograma de impacto definido por el perfil del arma. Cuando el tiempo cruza ese umbral, se resuelve el golpe. El informe resultante se convierte después en arco visual, sonido, destello, sacudida de cámara y avisos.
- **Ideas aprovechables:** simulación independiente de efectos; perfil de ataque por arma; combos con multiplicadores propios; informe estructurado de combate; ataques de área con límite de objetivos y orden por distancia; pruebas deterministas de daño y progresión del combo.
- **Diseño propio posible:** definir AttackDefinition, AttackRuntime y CombatEvent propios. La definición describe el movimiento; el runtime controla su ejecución temporal; el evento informa de un resultado ya resuelto.
- **Estado:** demo ARPG compacta con bucle jugable para su alcance, no RPG de campaña extenso. Usa Godot para entrada/render/audio y Rust mediante GDExtension para la simulación. El renderer móvil documentado no demuestra por sí solo rendimiento en teléfonos.
- **Licencia:** código MIT. Los assets de terceros tienen atribuciones y licencias separadas; consultar [ASSETS.md](https://github.com/blackopsrepl/grim-delver/blob/main/ASSETS.md).

### Epoch — habilidades configurables y reglas extensibles

- Repositorio: https://github.com/TimTmi/epoch
- [README — descripción de arquitectura](https://github.com/TimTmi/epoch/blob/main/README.md)
- [ability_system.gd — slots, activación y pasivas](https://github.com/TimTmi/epoch/blob/main/abilities/core/ability_system.gd)
- [ability.gd — definición de habilidad](https://github.com/TimTmi/epoch/blob/main/abilities/core/ability.gd)
- [ability_instance.gd — estado runtime](https://github.com/TimTmi/epoch/blob/main/abilities/core/ability_instance.gd)
- [ability_context.gd — contexto de activación](https://github.com/TimTmi/epoch/blob/main/abilities/core/ability_context.gd)
- [danger_sensor.gd — percepción de proyectiles](https://github.com/TimTmi/epoch/blob/main/character/input/ai/danger_sensor.gd)
- [combat/ — reglas, contextos y efectos](https://github.com/TimTmi/epoch/tree/main/combat)
- **Observación:** la configuración de una habilidad se separa de su instancia en ejecución. Cada personaje mantiene instancias propias con cooldown, carga, pasos y estado de pulsación. Las habilidades reciben un contexto que contiene usuario, intención, mundo y estado de instancia.
- **Ideas aprovechables:** separar definición, instancia, intención y objetivo; admitir pulsación, mantener, cargar y soltar; usar contextos tipados para daño/curación/empuje/muerte; IA que evalúa la trayectoria de un proyectil y no solo su distancia.
- **Diseño propio posible:** catálogo de habilidades declarativas, instancia aislada por actor, resolución de objetivos explícita y tubería de efectos con fases previas y posteriores.
- **Estado:** sandbox de sistemas de combate en arena, no RPG de campaña. Renderiza con geometría y partículas en un viewport reducido.
- **Licencia:** MIT según [LICENSE](https://github.com/TimTmi/epoch/blob/main/LICENSE). Los iconos externos conservan sus atribuciones.

### Mistpaw — telegráficos, jefes y pruebas de legibilidad

- Repositorio: https://github.com/Chuanyin1202/mistpaw
- [boss_combat.gd — patrones, fases, guard break y recuperación](https://github.com/Chuanyin1202/mistpaw/blob/main/scripts/boss_combat.gd)
- [enemy_telegraph.gd — zona y dirección anunciadas](https://github.com/Chuanyin1202/mistpaw/blob/main/scripts/enemy_telegraph.gd)
- [combat_feedback.gd — audio, bloqueo, curación y cámara](https://github.com/Chuanyin1202/mistpaw/blob/main/scripts/combat_feedback.gd)
- [touch_controls.gd — traducción multitáctil](https://github.com/Chuanyin1202/mistpaw/blob/main/scripts/touch_controls.gd)
- [sword_arc.gdshader — estela de espada](https://github.com/Chuanyin1202/mistpaw/blob/main/shaders/sword_arc.gdshader)
- [tests/combo.gd — sincronización de combos](https://github.com/Chuanyin1202/mistpaw/blob/main/tests/combo.gd)
- [tests/boss_moves.gd — patrones del jefe](https://github.com/Chuanyin1202/mistpaw/blob/main/tests/boss_moves.gd)
- [tests/combat_readability.gd — oclusión y legibilidad](https://github.com/Chuanyin1202/mistpaw/blob/main/tests/combat_readability.gd)
- **Observación:** los ataques del jefe tienen preparación, zona anunciada, desplazamiento, impacto y recuperación. Las pruebas verifican que el aviso no daña, que el carril queda fijado, que la esquiva evita el ataque, que el golpe no se repite y que la segunda fase añade una onda que se puede saltar.
- **Ideas aprovechables:** el telegráfico comparte geometría con el ataque real; patrones alternos evitan repetición; la recuperación crea una ventana de castigo; el feedback audiovisual tiene límites para no saturar; el input táctil traduce gestos a las mismas acciones abstractas; la silueta del jugador puede reforzarse si un enemigo lo tapa.
- **Diseño propio posible:** director de encuentros por fases y patrones, telegráficos derivados de la misma definición que resuelve la colisión, y un canal audiovisual que escucha eventos de combate.
- **Estado:** vertical slice de una arena/nivel, excelente laboratorio de combate pero no juego de campaña completo.
- **Licencia:** código MIT; medios y assets con condiciones separadas. Consultar [ASSET_LICENSES.md](https://github.com/Chuanyin1202/mistpaw/blob/main/ASSET_LICENSES.md).

### Emberpath — catálogo de contenido, progresión y validación

- Repositorio: https://github.com/Cui-kolento/emberpath-idle-godot
- [data_catalog.gd — héroes, equipo y habilidades](https://github.com/Cui-kolento/emberpath-idle-godot/blob/main/autoload/data_catalog.gd)
- [skill_manager.gd — coste, alcance y cooldown](https://github.com/Cui-kolento/emberpath-idle-godot/blob/main/scripts/skill/skill_manager.gd)
- [hit_box.gd](https://github.com/Cui-kolento/emberpath-idle-godot/blob/main/scripts/combat/hit_box.gd) y [hurt_box.gd](https://github.com/Cui-kolento/emberpath-idle-godot/blob/main/scripts/combat/hurt_box.gd)
- [TEST_REPORT.md — 44 comprobaciones automatizadas](https://github.com/Cui-kolento/emberpath-idle-godot/blob/main/TEST_REPORT.md)
- [tools/asset_pipeline — herramientas de recursos](https://github.com/Cui-kolento/emberpath-idle-godot/tree/main/tools/asset_pipeline)
- **Observación:** héroes, equipo y habilidades están agrupados en un catálogo; el gestor valida nivel, distancia, maná y cooldown antes de emitir el lanzamiento. Hitbox y hurtbox son nodos distintos. El informe registra 44 comprobaciones sin fallos en Godot headless, incluyendo animaciones, daño, proyectiles, inventario y guardado/carga.
- **Ideas aprovechables:** catálogo de contenido separado de la lógica; datos de equipo centralizados; pruebas de humo; validación de assets; normalización de anclajes de animación.
- **Diseño propio posible:** esquema de datos validable para armas, enemigos, habilidades, equipo, botín y progresión, más herramientas que detecten referencias rotas y animaciones incompletas.
- **Límite:** idle RPG de pixel art; su combate no representa el estilo de acción espectacular buscado. Los tests no demuestran rendimiento móvil.
- **Licencias:** comprobar [LICENSE](https://github.com/Cui-kolento/emberpath-idle-godot/blob/main/LICENSE) y [ASSET_LICENSES.md](https://github.com/Cui-kolento/emberpath-idle-godot/blob/main/ASSET_LICENSES.md) antes de reutilizar nada.

### Sentinel's Spire — FSM, solo como contraste

- Repositorio: https://github.com/DaebenDev/Sentinels-Spire
- [FiniteStateMachine.gd](https://github.com/DaebenDev/Sentinels-Spire/blob/main/scenes/enemies/Boss/FiniteStateMachine.gd)
- [GolemBoss.gd](https://github.com/DaebenDev/Sentinels-Spire/blob/main/scenes/enemies/Boss/GolemBoss.gd)
- **Qué aporta:** ejemplo pequeño de estados Idle, Follow, Attack, Hurt y Death, con rangos y estadísticas editables.
- **Qué evitaríamos:** búsqueda del jugador por nombres/rutas alternativas, referencias manuales a estados y lógica demasiado acoplada al script del jefe.
- **Estado técnico:** código de estilo Godot 3 (KinematicBody2D, yield y export), no base moderna Godot 4.
- **Licencia:** no he encontrado un archivo LICENSE en la raíz consultada. Solo referencia de lectura; no copiar código ni assets hasta aclarar permisos.

---

## 8. Síntesis: arquitectura propia que empieza a emerger

Esto no es una decisión de motor ni una selección definitiva. Es un mapa de módulos que aparece al comparar los proyectos:

1. **World / Simulation:** estado del mundo y reglas deterministas; no dibuja ni reproduce audio.
2. **Actor:** atributos, movimiento, equipo, salud y componentes especializados.
3. **State machine:** locomoción, ataque, defensa, daño, aturdimiento y muerte; transiciones explícitas y comprobables.
4. **Combat definitions:** perfiles de arma, combos, tiempos, alcance, forma del golpe, coste y ventanas de cancelación como datos.
5. **Combat runtime:** instancia temporal que determina cuándo se abre y cierra la ventana de impacto.
6. **Hit detection:** hitboxes/hurtboxes o consultas geométricas; filtros por equipo, altura, línea de visión e invulnerabilidad.
7. **Combat events:** resultados estructurados como AttackStarted, HitConfirmed, Blocked, GuardBroken, ActorStaggered y ActorDefeated.
8. **Presentation:** animación, partículas, shaders, sonido, cámara, vibración y UI escuchan eventos sin modificar reglas.
9. **Encounter director:** fases, patrones, telegráficos y ventanas de castigo de jefes.
10. **Ability system:** habilidades activas/pasivas con configuración separada del estado de ejecución.
11. **Content catalog:** datos validados de armas, enemigos, botín, habilidades, equipo y progresión.
12. **Input adapters:** teclado, mando y pantalla táctil producen las mismas acciones abstractas.
13. **Verification:** pruebas de simulación, integración de escenas y capturas automatizadas de legibilidad audiovisual.

### Principios que parecen sólidos

- **Una sola fuente de verdad para el impacto:** animación, hitbox y sonido deben sincronizarse con el mismo evento o definición temporal, no con temporizadores independientes.
- **La presentación no decide el daño:** el efecto visual comunica un resultado ya resuelto; no aplica daño por su cuenta.
- **El jefe anuncia lo que realmente golpeará:** telegráfico y colisión comparten origen, dirección, alcance y duración.
- **Ataques = datos + runtime:** el arma describe el ataque; el runtime ejecuta esa definición en el tiempo.
- **Pruebas para la sensación:** además de HP, validar que no hay impacto prematuro, que la amenaza se entiende y que existe una ventana real de respuesta.
- **Mobile-first:** luces, transparencias, partículas, memoria y resolución se consideran desde el principio, no al final.

### Crear desde cero con código propio

La meta no es ensamblar fragmentos ajenos. Vamos a extraer patrones, comparar alternativas y redactar especificaciones independientes. Cuando llegue el momento, implementaremos módulos propios con contratos, nombres, pruebas y estructura nuestros. Una licencia permisiva permite ciertos usos bajo condiciones, pero no hace recomendable copiar un sistema entero sin comprenderlo; y la licencia del código no autoriza automáticamente los assets.

---

## 9. Próxima tanda de investigación

- Animación y combate 3D: rigs, root motion, blending, cancel windows, IK y sincronización de armas.
- Cámara de acción: seguimiento, lock-on, encuadre de jefe, oclusión, sacudida limitada y recuperación suave.
- Efectos móviles: shaders de impacto, trails, transparencias, sombras y partículas en renderer móvil.
- IA: percepción, navegación, selección de ataques y coordinación de grupos.
- Android real: builds reproducibles y pruebas en dispositivos físicos de distintas gamas.
- Producción visual: pipeline de personajes, retargeting, importación de animaciones, LOD, atlas y compresión.

La siguiente actualización debe seguir incorporando archivos concretos y hallazgos contrastados a este único documento. No abrir todavía carpetas de código, elegir motor ni iniciar un prototipo.

---

## 10. Tercera ronda: acción 3D, locomoción, cámara y Android

### Breadbin Engine — framework 3D de combate y movesets

- Repositorio: https://github.com/CornflakeWoof/BreadbinEngine
- [PlayerBase.gd — movimiento, root motion y estados de acción](https://github.com/CornflakeWoof/BreadbinEngine/blob/main/Scripts/Actors/PlayerBase.gd)
- [ActorBase.gd — base común de actores](https://github.com/CornflakeWoof/BreadbinEngine/blob/main/Scripts/Actors/ActorBase.gd)
- [Weapon_Base.gd — movesets, audio y perfiles de arma](https://github.com/CornflakeWoof/BreadbinEngine/blob/main/Scripts/Combat/Weapon_Base.gd)
- [Hitbox_Damage.gd — colisión de daño y equipos](https://github.com/CornflakeWoof/BreadbinEngine/blob/main/Scripts/Combat/Hitbox_Damage.gd)
- [PlayerCamera.gd — cámara relativa al personaje](https://github.com/CornflakeWoof/BreadbinEngine/blob/main/Scripts/Actors/PlayerCamera.gd)
- **Observación:** cada arma expone listas de animaciones para cadenas de ataques ligeros/pesados, ataques en carrera o caída, y variantes críticas. También define sonidos, tipos de daño y hitboxes. El controlador del jugador suma el desplazamiento de root motion al movimiento horizontal.
- **Ideas aprovechables:** movesets configurables por arma; separación actor/arma/hitbox; ataques contextuales; root motion como parte de la locomoción; cámara que sigue la orientación del personaje.
- **Qué revisar críticamente:** el proyecto acredita que parte de su controlador procede de otro trabajo; hay código antiguo y algunos patrones de referencias por jerarquía que conviene modernizar. No asumir que todas las funciones están completas o libres de errores.
- **Estado:** framework/prototipo de acción 3D, no RPG terminado.
- **Licencia:** MIT en [LICENSE](https://github.com/CornflakeWoof/BreadbinEngine/blob/main/LICENSE). Respetar también créditos y licencias de dependencias/assets.

### Locomotion Godot — root motion, blending e IK de pies

- Repositorio: https://github.com/Johnz86/locomotion-godot
- [README — objetivos y límites de la demo](https://github.com/Johnz86/locomotion-godot/blob/main/README.md)
- [player_root_motion.gd — locomoción, combos y acciones completas](https://github.com/Johnz86/locomotion-godot/blob/main/src/character/player_root_motion.gd)
- [foot_placement_ik.gd — IK de pies y adaptación al terreno](https://github.com/Johnz86/locomotion-godot/blob/main/src/character/foot_placement_ik.gd)
- [gait_profiles.gd — perfiles de marcha y fase de zancada](https://github.com/Johnz86/locomotion-godot/blob/main/src/character/gait_profiles.gd)
- [educational_guide.md — guía matemática y decisiones](https://github.com/Johnz86/locomotion-godot/blob/main/docs/educational_guide.md)
- [tests/run.gd — runner de validación](https://github.com/Johnz86/locomotion-godot/blob/main/tests/run.gd)
- **Observación:** combina locomoción por root motion, estados de movimiento libre/strafe/herido, ataques de cuerpo completo, combos almacenados, guardia, esquivas y knockback. El modificador IK adapta pies y pelvis a pendientes y escalones, con límites para no arrastrar el pie plantado.
- **Ideas aprovechables:** locomoción y acciones animadas coordinadas; transiciones de ataque con buffer; separar gait profiles e IK del controlador; pruebas para velocidad, frenada, roll y comportamiento en escaleras.
- **Límite esencial:** el README declara expresamente que es una demo educativa, no un juego de combate completo: no implementa daño de armas ni lock-on. Es una referencia de animación/locomoción, no una solución de combate.
- **Licencia:** no encontré LICENSE en la raíz consultada. No copiar código ni assets hasta aclarar permisos. Los assets de animación tienen atribución específica en el README.

### Dungeon Raid — juego 3D de acción y sigilo con niveles

- Repositorio: https://github.com/parthoghosh24/Dungeon-Raid
- [skelly_boss.gd — jefe, ataques y fases por salud](https://github.com/parthoghosh24/Dungeon-Raid/blob/main/Scripts/Monsters/skelly_boss.gd)
- [skelly_minion.gd — patrulla, percepción y persecución](https://github.com/parthoghosh24/Dungeon-Raid/blob/main/Scripts/Monsters/skelly_minion.gd)
- [CameraOrigin.gd — cámara de ratón y mando](https://github.com/parthoghosh24/Dungeon-Raid/blob/main/Scripts/CameraOrigin.gd)
- [Scenes/Levels — cinco niveles](https://github.com/parthoghosh24/Dungeon-Raid/tree/main/Scenes/Levels)
- **Observación:** juego 3D de acción/sigilo con varios niveles, enemigos, jefe, escenas y objetos. El jefe usa AnimationTree y timers; los minions combinan estados de patrulla/persecución/ataque, NavigationAgent3D, áreas de detección y raycast de visión.
- **Ideas aprovechables:** mezcla de sigilo y combate abierto; navegación de enemigos; raycast de línea de visión; estructura de niveles; uso de AnimationTree para enemigos y jefe.
- **Qué rediseñaríamos:** la lógica del jefe mezcla timers, animación y aplicación de daño; los estados de enemigos tienen esperas y condiciones difíciles de razonar. Nos sirve como inventario de sistemas y juego terminado, pero no copiaríamos su organización tal cual.
- **Estado:** juego de acción/sigilo publicado y código abierto, no RPG profundo ni referencia visual de gama alta.
- **Licencia:** MIT en [LICENSE](https://github.com/parthoghosh24/Dungeon-Raid/blob/main/LICENSE). Sus assets se describen como procedentes de packs abiertos; verificar la licencia concreta de cada recurso.

### Tactical Slash — adaptación 3D y flujo táctil Android

- Repositorio: https://github.com/sion-rgb/tactical-slash
- [README — APK Android y renderer Compatibility](https://github.com/sion-rgb/tactical-slash)
- [architecture.md — sistemas desacoplados y estado autoritativo](https://github.com/sion-rgb/tactical-slash/blob/main/docs/architecture.md)
- [camera_controller.gd — foco, zoom, giro y vibración](https://github.com/sion-rgb/tactical-slash/blob/main/scripts/camera/camera_controller.gd)
- [battle_manager.gd — coordinación por señales](https://github.com/sion-rgb/tactical-slash/blob/main/scripts/battle/battle_manager.gd)
- [hit_effect.gd — chispas de impacto](https://github.com/sion-rgb/tactical-slash/blob/main/scripts/effects/hit_effect.gd)
- [THIRD_PARTY_ASSETS.md — auditoría de recursos](https://github.com/sion-rgb/tactical-slash/blob/main/THIRD_PARTY_ASSETS.md)
- **Observación:** el README ofrece APK Android y usa Godot 4.7 con renderer Compatibility. La arquitectura mantiene una fuente de verdad lógica para las unidades y delega cámara, movimiento, acciones, IA y UI a sistemas especializados. El controlador de cámara admite foco, zoom, paneo, rotación y vibración; los gestos táctiles forman parte de la interfaz.
- **Ideas aprovechables:** comprobar un pipeline 3D con destino Android; separar estado lógico de transformaciones visuales; cámara controlable por gestos; coordinación mediante señales; auditoría explícita de assets.
- **Límite:** es un RPG táctico por turnos sobre cuadrícula, no un action RPG. Que exista APK no prueba FPS, temperatura o estabilidad en una gama amplia de dispositivos.
- **Licencia:** código MIT; modelos, entorno y audio tienen licencias propias descritas en THIRD_PARTY_ASSETS.md.

### Breadbin + Locomotion + Grim Delver: combinación conceptual

Estas tres referencias cubren capas distintas que no debemos confundir:

- **Breadbin:** configuración de movesets y relación entre arma, animación y hitboxes.
- **Locomotion Godot:** calidad de movimiento corporal, root motion, mezcla de animaciones e IK.
- **Grim Delver:** determinismo del combate y separación entre simulación y feedback.

Una arquitectura propia podría estudiar las tres sin adoptar su implementación literal. El resultado tendría que ser una única definición de ataque que coordine animación, desplazamiento, hitbox, cancelaciones y eventos audiovisuales.

