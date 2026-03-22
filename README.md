# Klipper Printer Configurations

> **Disclaimer:** These configurations are shared freely for personal use and as a reference for the community. Everything here is provided **as-is, without any warranty**. Use at your own risk — I take no responsibility for any damage to hardware, prints, or anything else that may result from using or adapting these files. Always review and test configurations carefully before running them on your own machine.

---

## Contents

- [Core Features](#core-features)
- [Printers](#printers)
  - [Doron](#doron)
  - [SaladFork](#saladfork)
  - [V-Minion](#v-minion)
  - [Voron 0](#voron-0)
  - [Voron 2.4](#voron-24)
- [Slicer Configuration Guide](#slicer-configuration-guide)
  - [Orca Slicer, PrusaSlicer & SuperSlicer](#orca-slicer-prusaslicer--superslicer)
  - [Ultimaker Cura](#ultimaker-cura)
- [Macro Reference](#macro-reference)
  - [Print Lifecycle & State](#print-lifecycle--state)
  - [Extruder & Filament](#extruder--filament)
  - [Movement & Homing](#movement--homing)
  - [Calibration & Tuning](#calibration--tuning)
  - [Variables, Boot & Safety Loops](#variables-boot--safety-loops)
  - [System Helpers](#system-helpers)
  - [Compatibility Aliases & Dummies](#compatibility-aliases--dummies)

---

## Core Features

All configurations in this repository share a common macro framework built around the following principles:

**Centralized Variable Management**
All relevant speeds, positions, and parameters are defined in a single master macro (`_MY_VARS`) and calculated at system boot based on the global printer limits.

**Safe Sensorless Homing** *(where applicable)*
Automatically reduces motor current and acceleration before triggering the physical endstops to protect the hardware and avoid false StallGuard triggers.

**Smart Filament Management**
Load and unload routines check the current thermal state. They maintain an existing hotend temperature or heat up to a fallback threshold if the hotend is cold.

**Nevermore Filter Integration** *(where applicable)*
The Nevermore filter activates automatically based on bed temperature thresholds (e.g., for ABS/ASA) and runs a 10-minute cooldown cycle after the print finishes.

**Dynamic Prime Blob**
Calculates the extrusion volume for the prime blob based on the configured nozzle diameter, so nozzle changes require no manual adjustment.

---

## Printers

### Doron

[printer.cfg](./Doron/printer.cfg) · **Delta · ⌀ 150 mm**

| | |
|---|---|
| Mainboard | BTT SKRat V1.0 |
| Probe | Membrane pressure leveling adapter |
| Extruder | Orbiter V2.5 |
| Hotend | Phaetus Dragon High-Flow |
| Filament Sensor | — |
| Extensions | [TMC Autotune](https://github.com/andrewmcgr/klipper_tmc_autotune) · [G-Code Shell Command](https://github.com/dw-0/kiauh/blob/master/docs/gcode_shell_command.md) |

A community-built delta printer inspired by Voron aesthetics, originally started as an April Fool's prank. It uses a compact delta geometry with a ~156 mm round print diameter.

Project: [Doron-Velta](https://github.com/rogerlz/Doron-Velta)

---

### SaladFork

[printer.cfg](./SaladFork/printer.cfg) · **CoreXY · 180 × 180 × 180 mm**

| | |
|---|---|
| Mainboard | BTT Manta M8P V2.0 + BTT EBB36 CAN V1.2 |
| Probe | Cartographer V4 |
| Extruder | WristWatch-G2 |
| Hotend | Phaetus Rapido 2F UHF Plus |
| Filament Sensor | BTT SFS 2.0 |
| Extensions | [TMC Autotune](https://github.com/andrewmcgr/klipper_tmc_autotune) · [Shake&Tune](https://github.com/Frix-x/klippain-shaketune) |

A Trident scaled down to 1515 aluminium extrusions, designed by PrintersForAnts for build volumes from 120 mm to 180 mm. Fully enclosed and compatible with a variety of toolhead options.

Project: [Salad Fork](https://github.com/PrintersForAnts/Salad_Fork)

---

### V-Minion

[V-Minion-Orange](./V-Minion-Orange/printer.cfg) · [V-Minion-Yellow](./V-Minion-Yellow/printer.cfg) · **Cartesian · 180 × 180 × 180 mm**

| | Orange | Yellow |
|---|---|---|
| Mainboard | BTT SKR 2 + LDO NiteHawk-36 | BTT SKRat V1.0 + Orbitool O2 |
| Probe | Super Pinda | Super Pinda |
| Extruder | Bondtech LGX Lite | Orbiter V2 |
| Hotend | E3D Revo | Phaetus Rapido UHF |
| Filament Sensor | — | Orbiter 2 Smart Sensor |
| Extensions | [TMC Autotune](https://github.com/andrewmcgr/klipper_tmc_autotune) · [G-Code Shell Command](https://github.com/dw-0/kiauh/blob/master/docs/gcode_shell_command.md) | [TMC Autotune](https://github.com/andrewmcgr/klipper_tmc_autotune) · [G-Code Shell Command](https://github.com/dw-0/kiauh/blob/master/docs/gcode_shell_command.md) |

A compact open-frame cartesian printer from Rat Rig with a 180 mm³ build volume. Two units in the fleet — Orange and Yellow — each with different electronics but sharing the same mechanical platform and sensorless homing setup.

Project: [Rat Rig V-Minion](https://github.com/Rat-Rig/V-Minion)

---

### Voron 0

[printer.cfg](./Voron0/printer.cfg) · **CoreXY · 120 × 120 × 120 mm**

| | |
|---|---|
| Mainboard | BTT SKR Pico V1.0 + LDO Picobilical |
| Probe | — |
| Extruder | Galileo 2 |
| Hotend | E3D Revo |
| Filament Sensor | DIY microswitch |
| Extensions | [TMC Autotune](https://github.com/andrewmcgr/klipper_tmc_autotune) · [Shake&Tune](https://github.com/Frix-x/klippain-shaketune) |

The smallest printer in the fleet — a fully enclosed CoreXY intended for ABS and other engineering filaments in a compact footprint. The 120 mm bed is sufficient to print single mechanical parts for larger Voron builds.

Project: [Voron 0](https://github.com/VoronDesign/Voron-0)

---

### Voron 2.4

[Voron 300](./Voron/printer.cfg) · [Voron 350](./Voron-2-350/printer.cfg) · **CoreXY**

| | Voron 300 | Voron 350 |
|---|---|---|
| Build Volume | 300 × 300 × 300 mm | 350 × 350 × 350 mm |
| Mainboard | BTT Octopus V1.0 + BTT EBB SB2209 + BTT U2C | LDO Leviathan V1.2 + LDO NiteHawk-SB |
| Probe | Voron Tap | Voron Tap |
| Extruder | Galileo 2 | Galileo 2 |
| Hotend | Phaetus Rapido HF | Phaetus Rapido 2 HF |
| Filament Sensor | BTT SFS 1.0 | BTT SFS 1.0 |
| Extensions | [TMC Autotune](https://github.com/andrewmcgr/klipper_tmc_autotune) · [Shake&Tune](https://github.com/Frix-x/klippain-shaketune) | [TMC Autotune](https://github.com/andrewmcgr/klipper_tmc_autotune) · [Shake&Tune](https://github.com/Frix-x/klippain-shaketune) |

The Voron V2.4 uses a flying gantry with 4-point leveling (QGL) and a static print bed. Two builds: a 300 mm and a 350 mm variant — both fully enclosed with Nevermore filtration.

Project: [Voron 2.4](https://github.com/VoronDesign/Voron-2)

---

## Slicer Configuration Guide

To ensure the macros work correctly, parameters must be passed exactly as shown below. No manual temperature commands are needed in the start G-code.

### Orca Slicer, PrusaSlicer & SuperSlicer

**Machine Start G-Code**
```gcode
; Prevents slicer hardcoded heating sequences
M190 S0
M109 S0
; Send total layer count to Mainsail UI
SET_PRINT_STATS_INFO TOTAL_LAYER=[total_layer_count]
; Pass parameters to Klipper and let the macro handle everything
PRINT_START BED_TEMP=[first_layer_bed_temperature] EXTRUDER_TEMP=[first_layer_temperature] CHAMBER=[chamber_temperature]
```

**Machine End G-Code**
```gcode
PRINT_END
```

**Before Layer Change G-Code**
```gcode
; Reset extruder position at every layer change
G92 E0
; Safely enable filament sensor at layer 2
{if layer_num == 2}_TOGGLE_FILAMENT_SENSORS ENABLE=1{endif}
```

**After Layer Change G-Code**
```gcode
; Update current layer count in Mainsail UI and push message to display
SET_PRINT_STATS_INFO CURRENT_LAYER={layer_num + 1}
SET_DISPLAY_TEXT MSG="Layer {layer_num + 1}/[total_layer_count]"
```

---

### Ultimaker Cura

**Start G-Code**
```gcode
PRINT_START BED_TEMP={material_bed_temperature_layer_0} EXTRUDER_TEMP={material_print_temperature_layer_0} CHAMBER={build_volume_temperature}
```

**End G-Code**
```gcode
PRINT_END
```

**Layer Change Handling**

Cura does not have a native "Before Layer Change" field in Machine Settings. To reset the extruder and enable filament sensors at layer 2, use the Post Processing plugin:

1. Go to `Extensions` > `Post Processing` > `Modify G-Code`.
2. Add the script `Insert at layer change`.
3. Set **When to insert** to `Before`.
4. Set **G-code to insert** to:
   ```gcode
   G92 E0
   ```
5. Add a `Search and Replace` script to enable the sensor at layer 2:
   - **Search:** `;LAYER:1` *(Cura starts counting at 0)*
   - **Replace:** `;LAYER:1\n_TOGGLE_FILAMENT_SENSORS ENABLE=1`

---

## Macro Reference

### Print Lifecycle & State

| Macro | Description |
|---|---|
| `PRINT_START` | Main orchestration macro. Handles heat-soaking, homing, nozzle cleaning, Z-tilt/quad_gantry_level, adaptive meshing, and the prime blob. Requires slicer parameters. |
| `PRINT_END` | Safely terminates the print. Retracts filament, disables heaters, parks the toolhead, and triggers the Nevermore cooldown timer. |
| `_PRINT_STATE` | Hidden variable macro that stores extruder temperatures across pauses and filament swaps. |
| `_HOOK_ON_PAUSE` | System hook that triggers notifications when a print is paused. |
| `_HOOK_ON_RESUME` | System hook that resets the printer state when resuming. |
| `_HOOK_ON_CANCEL` | System hook that resets background loops and starts the filter cooldown on cancel. |

### Extruder & Filament

| Macro | Description |
|---|---|
| `LOAD_FILAMENT` | Loads filament with predefined speeds, preserving the current hotend target temperature. |
| `UNLOAD_FILAMENT` | Ejects filament and includes a tip-shaping sequence to prevent stringing inside the extruder. |
| `M600` | Filament change routine. Pauses the print, stores the temperature, unloads the filament, and turns off the heater for safe extended idle. |
| `PRIME_BLOB` | Purges the nozzle on the edge of the bed and snaps the filament tail before the print starts. |
| `CLEAN_NOZZLE` | Executes a wiping pattern across a silicone brush to clean the nozzle before probing. |
| `_TOGGLE_FILAMENT_SENSORS` | Globally enables or disables the runout and motion sensors to prevent false triggers during purges or macros. |

### Movement & Homing

| Macro | Description |
|---|---|
| `homing_override` | Replaces the standard `G28` with a custom sequence where needed. |
| `_CONDITIONAL_HOME` | Checks whether the printer is already homed. Skips homing if so, otherwise triggers `G28`. |
| `_HOME_AXIS` | Helper macro that temporarily lowers motor currents and kinematic limits for safe sensorless homing. |
| `CENTER` | Moves the toolhead to the center of the build volume with a Z-hop beforehand. |

### Calibration & Tuning

| Macro | Description |
|---|---|
| `Z_TILT_ADJUST/QUAD_GANTRY_LEVEL` | Wrapper for the standard Klipper command with added status notifications. |
| `BED_MESH_CALIBRATE` | Wrapper for the standard Klipper command with added status notifications. |
| `PID_BED` | Convenience macro for PID tuning the heated bed. Homes and centers the toolhead automatically. |
| `PID_HOTEND` | Convenience macro for PID tuning the extruder. Homes, centers, and activates the part cooling fan for a realistic thermal load. |

### Variables, Boot & Safety Loops

| Macro | Description |
|---|---|
| `_CLIENT_VARIABLE` | Configuration variables for the Mainsail web interface (e.g., custom park positions and idle timeouts). |
| `_MY_VARS` | Central configuration dictionary storing factors, hop heights, temperatures, and physical coordinates. |
| `_INIT_MY_VARS` *(delayed_gcode)* | Boot script executed 2 seconds after startup. Calculates dynamic speeds and center coordinates based on the hardware limits reported by Klipper. |
| `_STOP_NEVERMORE` *(delayed_gcode)* | Timed macro that shuts down the VOC filter after a defined cooldown period. |

### System Helpers

| Macro | Description |
|---|---|
| `_NOTIFY` | Sends formatted messages to both the Mainsail UI and the Klipper console. |
| `_RESET_STATE` | Clears speed factors, extrusion multipliers, bed meshes, and background loops to return the printer to a clean state. |

### Compatibility Aliases & Dummies

| Macro | Description |
|---|---|
| `G27` | Parks the toolhead *(Marlin)*. |
| `G29` | Executes `BED_MESH_CALIBRATE` *(Marlin)*. |
| `G32` | Homes the printer and runs leveling *(RepRap)*. |
| `M108` | Dummy — suppresses console output for "Cancel Heating" *(Marlin)*. |
| `M116` | Dummy — suppresses console output for "Wait for all temperatures" *(RepRap)*. |
| `M201` | Dummy — suppresses console output for "Set Max Acceleration" *(Marlin)*. |
| `M203` | Dummy — suppresses console output for "Set Max Feedrate" *(Marlin)*. |
| `M205` | Dummy — suppresses console output for "Set Advanced Settings/Jerk" *(Marlin)*. |
| `M300` | Placeholder to intercept beep/tone commands *(Marlin/RepRap)*. |
| `M572` | Sets Pressure Advance *(RepRap)*. |
| `M900` | Sets Pressure Advance, routed to `M572` *(Marlin/Cura)*. |
| `M601` | Pauses the print *(PrusaSlicer/Marlin)*. |
| `M701` | Triggers `LOAD_FILAMENT` *(Marlin)*. |
| `M702` | Triggers `UNLOAD_FILAMENT` *(Marlin)*. |
