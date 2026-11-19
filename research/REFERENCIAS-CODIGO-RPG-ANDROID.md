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
