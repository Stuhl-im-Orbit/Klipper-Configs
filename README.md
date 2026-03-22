# 🖨️ Klipper Printer Configurations

> **Disclaimer:** These configurations are shared freely for personal use and as a reference for the community. Everything here is provided **as-is, without any warranty**. Use at your own risk — I take no responsibility for any damage to hardware, prints, or anything else that may result from using or adapting these files. Always review and test configurations carefully before running them on your own machine.

---

## ✨ Core Features

All configurations in this repository share a common macro framework built around the following principles:

- **Centralized Variable Management:** All crucial speeds, positions, and parameters are defined in a single master macro (`_MY_VARS`) and dynamically calculated at system boot based on global printer limits.
- **Safe Sensorless Homing** *(where applicable)*: Automatically reduces motor current and acceleration before tapping the physical limits to protect the hardware and prevent false StallGuard triggers.
- **Smart Filament Management:** Load and unload routines evaluate current thermal states. They maintain existing hotend temperatures or safely heat up to a fallback threshold if the hotend is cold.
- **Nevermore Filter Integration** *(where applicable)*: The Nevermore filter automatically kicks in based on bed temperature thresholds (e.g., for ABS/ASA) and runs a 10-minute cooldown cycle after the print finishes.
- **Dynamic Prime Blob:** Calculates the extrusion volume for the prime blob based on the configured nozzle diameter, making nozzle swaps hassle-free.

---

## 📖 Macro Reference Guide

### 🎬 Print Lifecycle & State

| Macro | Description |
|---|---|
| `PRINT_START` | The main orchestration macro. Handles heat-soaking, homing, nozzle cleaning, Z-tilt, adaptive meshing, and the prime blob. Requires slicer parameters. |
| `PRINT_END` | Safely terminates the print. Retracts filament, disables heaters, parks the toolhead, and triggers the Nevermore cooldown timer. |
| `_PRINT_STATE` | A hidden variable macro that memorizes extruder temperatures across pauses and filament swaps. |
| `_HOOK_ON_PAUSE` | System hook that triggers LED states and notifications when a print is paused. |
| `_HOOK_ON_RESUME` | System hook that resets LED states to printing when resuming. |
| `_HOOK_ON_CANCEL` | System hook that ensures background loops are reset and the filter cooldown begins on cancel. |

---

### 🧵 Extruder & Filament

| Macro | Description |
|---|---|
| `LOAD_FILAMENT` | Safely loads filament with predefined speeds, preserving the current hotend target temperature. |
| `UNLOAD_FILAMENT` | Ejects filament and includes a tip-shaping sequence to prevent stringing inside the extruder. |
| `M600` | Standard filament change routine. Pauses the print, memorizes the temperature, unloads the filament, and turns off the heater for safe extended idle times. |
| `PRIME_BLOB` | Purges the nozzle on the edge of the bed and cleanly snaps the filament tail before starting the print. |
| `CLEAN_NOZZLE` | Executes a precise wiping pattern across a fixed silicone brush to clean the nozzle before physical probing. |
| `_TOGGLE_FILAMENT_SENSORS` | Globally enables or disables the runout and motion sensors to prevent false triggers during purges or macros. |

---

### 🧭 Movement & Homing

| Macro | Description |
|---|---|
| `homing_override` | Replaces the standard `G28` command with a safe sequence. Performs Z-hops and ensures X and Y are homed sensorless before centering and homing Z with the Cartographer. |
| `_CONDITIONAL_HOME` | Checks if the printer is already homed. If yes, it skips homing to save time; if no, it triggers `G28`. |
| `_HOME_AXIS` | The helper macro that temporarily lowers motor currents and kinematic limits for safe sensorless homing. |
| `CENTER` | Moves the toolhead to the exact center of the build volume, ensuring a safe Z-hop is performed first. |

---

### 📐 Calibration & Tuning

| Macro | Description |
|---|---|
| `Z_TILT_ADJUST` | Wrapper for the standard Klipper command that adds LED state changes (yellow) and notifications. |
| `BED_MESH_CALIBRATE` | Wrapper for the standard Klipper command that adds LED state changes (green) and notifications. |
| `PID_BED` | Convenience macro for PID tuning the heated bed. Automatically homes and centers the toolhead. |
| `PID_HOTEND` | Convenience macro for PID tuning the extruder. Automatically homes, centers, and activates the part cooling fan for realistic thermal simulation. |

---

### ⚙️ Variables, Boot & Safety Loops

| Macro | Description |
|---|---|
| `_CLIENT_VARIABLE` | Defines specific configuration variables utilized by the Mainsail web interface (e.g., custom park positions and idle timeouts). |
| `_MY_VARS` | Central user-defined configuration dictionary storing factors, hop heights, temperatures, and physical coordinates. |
| `_INIT_MY_VARS` *(delayed_gcode)* | Boot script executed 2 seconds after startup. Calculates dynamic speeds and center coordinates based on Klipper's hardware limits. |
| `_STOP_NEVERMORE` *(delayed_gcode)* | Timed macro to cleanly shut down the VOC filter after a defined cooldown period. |

---

### 🔧 System Helpers

| Macro | Description |
|---|---|
| `_NOTIFY` | Pushes formatted messages to both the Mainsail UI and the Klipper console simultaneously. |
| `_RESET_STATE` | Clears speed factors, extrusion multipliers, bed meshes, and background loops to reset the printer to a clean state. |
| `_SET_LED_STATE` | Controls the Neopixel colors based on predefined logical printer states. |

---

### 🔌 Compatibility Aliases & Dummies

| Macro | Description |
|---|---|
| `G27` | Parks the toolhead *(Marlin compatibility)*. |
| `G29` | Executes `BED_MESH_CALIBRATE` *(Marlin compatibility)*. |
| `G32` | Homes the printer and executes `CARTOGRAPHER_TOUCH_HOME` *(RepRap compatibility)*. |
| `M108` | Dummy — prevents console spam for "Cancel Heating" *(Marlin compatibility)*. |
| `M116` | Dummy — prevents console spam for "Wait for all temperatures" *(RepRap compatibility)*. |
| `M201` | Dummy — prevents console spam for "Set Max Acceleration" *(Marlin compatibility)*. |
| `M203` | Dummy — prevents console spam for "Set Max Feedrate" *(Marlin compatibility)*. |
| `M205` | Dummy — prevents console spam for "Set Advanced Settings/Jerk" *(Marlin compatibility)*. |
| `M300` | Placeholder to intercept standard beep/play tone commands *(Marlin/RepRap compatibility)*. |
| `M572` | Sets Pressure Advance *(RepRap compatibility)*. |
| `M900` | Sets Pressure Advance, routing to `M572` *(Marlin/Cura compatibility)*. |
| `M601` | Pauses the print *(PrusaSlicer/Marlin compatibility)*. |
| `M701` | Triggers the `LOAD_FILAMENT` macro *(Marlin compatibility)*. |
| `M702` | Triggers the `UNLOAD_FILAMENT` macro *(Marlin compatibility)*. |

---

## 🗂️ Printers

### [Doron](./Doron/printer.cfg)

**Delta · ⌀ 150 mm**

| | |
|---|---|
| **Mainboard** | BTT SKRat V1.0 |
| **Probe** | Membrane pressure leveling adapter |
| **Extruder** | Orbiter V2.5 |
| **Hotend** | Phaetus Dragon High-Flow |
| **Extensions** | [TMC Autotune](https://github.com/andrewmcgr/klipper_tmc_autotune) · [G-Code Shell Command](https://github.com/dw-0/kiauh/blob/master/docs/gcode_shell_command.md) |

A community-built delta printer inspired by Voron aesthetics, born as an April Fool's prank that turned into a real machine. It uses a compact delta geometry with a ~156 mm round print diameter — stiff, fast, and surprisingly capable.

**Projekt:** [Doron-Velta](https://github.com/rogerlz/Doron-Velta)

---

### [SaladFork](./SaladFork/printer.cfg)

**CoreXY · 180 × 180 × 180 mm**

| | |
|---|---|
| **Mainboard** | BTT Manta M8P V2.0 + BTT EBB36 CAN V1.2 |
| **Probe** | Cartographer V4 |
| **Extruder** | WristWatch-G2 |
| **Hotend** | Phaetus Rapido 2F UHF Plus |
| **Extensions** | [TMC Autotune](https://github.com/andrewmcgr/klipper_tmc_autotune) · [Shake&Tune](https://github.com/Frix-x/klippain-shaketune) |

A Trident scaled down to 1515 aluminium extrusions, designed by PrintersForAnts for build volumes from 120 mm to 180 mm. It heats up quickly compared to full-sized printers, is fully enclosed, and supports a variety of toolhead options.

**Projekt:** [Salad Fork](https://github.com/PrintersForAnts/Salad_Fork)

---

### [V-Minion-Orange](./V-Minion-Orange/printer.cfg) · [V-Minion-Yellow](./V-Minion-Yellow/printer.cfg)

**Cartesian · 180 × 180 × 180 mm**

| | **Orange** | **Yellow** |
|---|---|---|
| **Mainboard** | BTT SKR 2 + LDO NiteHawk-36 | BTT SKRat V1.0 + Orbitool O2 |
| **Probe** | Super Pinda | Super Pinda |
| **Extruder** | Bondtech LGX Lite | Orbiter V2 |
| **Hotend** | E3D Revo | Phaetus Rapido UHF |
| **Extensions** | [TMC Autotune](https://github.com/andrewmcgr/klipper_tmc_autotune) · [G-Code Shell Command](https://github.com/dw-0/kiauh/blob/master/docs/gcode_shell_command.md) | [TMC Autotune](https://github.com/andrewmcgr/klipper_tmc_autotune) · [G-Code Shell Command](https://github.com/dw-0/kiauh/blob/master/docs/gcode_shell_command.md) |

The V-Minion is a compact open-frame cartesian printer from Rat Rig with a 180 mm³ build volume. Two units in the fleet — Orange and Yellow — each with slightly different electronics but sharing the same mechanical platform and sensorless homing setup.

**Projekt:** [Rat Rig V-Minion](https://github.com/Rat-Rig/V-Minion)

---

### [Voron0](./Voron0/printer.cfg)

**CoreXY · 120 × 120 × 120 mm**

| | |
|---|---|
| **Mainboard** | BTT SKR Pico V1.0 + LDO Picobilical |
| **Probe** | — |
| **Extruder** | Galileo 2 |
| **Hotend** | E3D Revo |
| **Extensions** | [TMC Autotune](https://github.com/andrewmcgr/klipper_tmc_autotune) · [Shake&Tune](https://github.com/Frix-x/klippain-shaketune) |

The smallest Voron in the fleet — a fully enclosed CoreXY designed to print ABS and other engineering filaments in a tiny footprint. All single mechanical parts for larger Vorons can be printed on its 120 mm bed.

**Projekt:** [Voron 0](https://github.com/VoronDesign/Voron-0)

---

### [Voron](./Voron/printer.cfg) · [Voron-2-350](./Voron-2-350/printer.cfg)

**CoreXY**

| | **Voron (300)** | **Voron-2-350** |
|---|---|---|
| **Build Volume** | 300 × 300 × 300 mm | 350 × 350 × 350 mm |
| **Mainboard** | BTT Octopus V1.0 + BTT EBB SB2209 + BTT U2C | LDO Leviathan V1.2 + LDO NiteHawk-SB |
| **Probe** | Voron Tap | Voron Tap |
| **Extruder** | Galileo 2 | Galileo 2 |
| **Hotend** | Phaetus Rapido HF | Phaetus Rapido 2 HF |
| **Extensions** | [TMC Autotune](https://github.com/andrewmcgr/klipper_tmc_autotune) · [Shake&Tune](https://github.com/Frix-x/klippain-shaketune) | [TMC Autotune](https://github.com/andrewmcgr/klipper_tmc_autotune) · [Shake&Tune](https://github.com/Frix-x/klippain-shaketune) |

The Voron V2.4 features a flying gantry with 4-point leveling (QGL) and a static print bed, making it exceptionally stable for high-temperature materials. Two builds: a 300 mm and a 350 mm variant — both fully enclosed with Nevermore filtration.

**Projekt:** [Voron 2.4](https://github.com/VoronDesign/Voron-2)

---

## 💻 Slicer Configuration Guide

To ensure the macros function correctly, parameters must be passed exactly as configured in your slicer. No manual temperature commands are required in the start G-code.

### 🔪 Orca Slicer, PrusaSlicer & SuperSlicer

**Machine Start G-Code:**
```gcode
; Prevents slicer hardcoded heating sequences
M190 S0
M109 S0
; Send total layer count to Mainsail UI
SET_PRINT_STATS_INFO TOTAL_LAYER=[total_layer_count]
; Pass parameters to Klipper and let the macro handle everything
PRINT_START BED_TEMP=[first_layer_bed_temperature] EXTRUDER_TEMP=[first_layer_temperature] CHAMBER=[chamber_temperature]
```

**Machine End G-Code:**
```gcode
; Trigger the end sequence
PRINT_END
```

**Before Layer Change G-Code:**
```gcode
; Reset extruder position at every layer change
G92 E0
; Safely enable filament sensor at layer 2
{if layer_num == 2}_TOGGLE_FILAMENT_SENSORS ENABLE=1{endif}
```

**After Layer Change G-Code:**
```gcode
; Update current layer count in Mainsail UI and push message to display
SET_PRINT_STATS_INFO CURRENT_LAYER={layer_num + 1}
SET_DISPLAY_TEXT MSG="Layer {layer_num + 1}/[total_layer_count]"
```

---

### 🔪 Ultimaker Cura

**Start G-Code:**
```gcode
; Pass parameters to Klipper and let the macro handle everything
PRINT_START BED_TEMP={material_bed_temperature_layer_0} EXTRUDER_TEMP={material_print_temperature_layer_0} CHAMBER={build_volume_temperature}
```

**End G-Code:**
```gcode
; Trigger the end sequence
PRINT_END
```

**Layer Change Handling in Cura:**

Cura does not natively feature a "Before Layer Change" text box in the standard Machine Settings. To trigger the filament sensors at layer 2 and reset the extruder, you have this option:

**Using Post Processing Scripts**

1. Go to `Extensions` > `Post Processing` > `Modify G-Code`.
2. Add the script `Insert at layer change`.
3. Set **When to insert** to `Before`.
4. Set **G-code to insert** to:
   ```gcode
   ; Reset extruder position
   G92 E0
   ```
5. Add another `Search and Replace` script to enable the sensor specifically at Layer 2:
   - **Search:** `;LAYER:1` *(Note: Cura starts counting at 0)*
   - **Replace:** `;LAYER:1\n_TOGGLE_FILAMENT_SENSORS ENABLE=1`
