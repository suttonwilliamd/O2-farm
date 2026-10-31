# O²-farm

## Running the current prototype

The runnable game is an **orbital scene prototype**: a procedurally generated
starfield with rotating Earth and Mars. Farming, oxygen production, trading,
pirate raids and the campaign described in the design document below are **not
implemented gameplay**. The standalone plant/world/pirate modules are not
connected to the scene.

Install [LÖVE 11.5](https://love2d.org/) and run either the source directory or
the packaged release:

```powershell
love .
love game.love
```

If LÖVE is not on PATH, use its full executable path (for example,
`& 'C:\Program Files\LOVE\love.exe' .`). No additional Lua packages are needed.

### Controls

| Control | Action |
| --- | --- |
| Space | Pause/resume planetary rotation |
| F11 | Toggle desktop fullscreen |
| Esc | Leave fullscreen without quitting |
| H | Hide/show the on-screen controls |
| Window close button | Quit |

Rotation also pauses when the window loses focus. Returning to the window
resumes rotation unless it was manually paused. Resizing and maximizing keep the
entire 1280×720 scene visible, using black bars rather than stretching or cropping.

### Packaging and regression checks

After changing runtime Lua files, rebuild the checked-in release:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\package.ps1
```

The packager explicitly includes the seven active Lua runtime files. It excludes
the dormant gameplay modules, unused font, Git history, tests, documentation and nested release archives.
Commit the updated `game.love` alongside its source changes.

Run the native regression suite from this repository (use `lovec.exe` on Windows
to see console output):

```powershell
lovec tests "$PWD"
```

The checks cover pause/resume, held-key repeat, focus loss, minimum/square/ultrawide
viewport geometry, preserved textures after a real display resize, and help
rendering. For interactive smoke coverage, launch the game, maximize/restore,
toggle fullscreen with F11/Esc, and exercise Space and H.

### Prototype fixes

- Replaced resize-triggered window recreation with a uniform, centered viewport;
  maximizing no longer blanks the starfield and planets or disables resizing.
- Baked procedural artwork into persistent images so display-mode transitions
  preserve it instead of losing Canvas contents.
- Added pause, fullscreen, focus-aware animation, and visible keyboard help.
- Rebuilt `game.love` from runtime files only, removing bundled Git metadata and
  stale/nested release content.

## Design document (planned gameplay)

---

### **Table of Contents**  
1. **Overview**  
2. **Core Gameplay Loop**  
3. **Setting & Story**  
4. **Gameplay Mechanics**  
5. **Progression System**  
6. **Art & Audio Direction**  
7. **UI/UX Design**  
8. **Endgame & Post-Game Content**  
9. **Monetization (Optional)**  
10. **Development Roadmap**  

---

## **1. Overview**  
**Genre**: Survival/Management Sim with Strategy Elements  
**Platforms**: PC, Consoles (TBD)  
**Target Audience**: Fans of *Terra Nil*, *RimWorld*, and *Oxygen Not Included*  
**Key Themes**: Environmental restoration, moral choices, hidden conspiracy.  

**Elevator Pitch**:  
You are a colonist tasked with reviving a dying planet’s atmosphere by farming oxygen. But as you expand, you uncover a galactic conspiracy: Earth’s governments lied about their survival, and your work is being exploited by a hidden elite. Balance sustainability, defense, and ethics to decide humanity’s future.  

---

## **2. Core Gameplay Loop**  
1. **Terraform** barren land into fertile soil or aquatic zones.  
2. **Plant** oxygen-producing flora (trees, algae, hybrids).  
3. **Defend** O² stores from pirates, disasters, and sabotage.  
4. **Trade** resources to upgrade tech and unlock secrets.  
5. **Expand** operations while unraveling the fate of Earth.  

---

## **3. Setting & Story**  
### **Hidden Setting: Mars**  
- **Environmental Clues**:  
  - Rust-red soil, skeletal ruins of old rovers, and abandoned "Ares Corp" mining rigs.  
  - Low-gravity animations (subtle jumps, floating debris).  
  - Skybox slowly transitions from hazy pink to blue as O² levels rise.  
- **Plot Summary**:  
  - **Act 1**: Players believe they’re on a remote planet. Cheery Earth transmissions urge efficiency.  
  - **Act 2**: Discover logs hinting at Mars’ terraforming history and Earth’s collapse.  
  - **Act 3**: Learn that Earth’s elite siphon Mars’ O² to survive in orbital stations.  

### **Key Narrative Hooks**  
- **The Earth Deception**: Early traders sell “Earth-certified” gear, but later quests reveal the certifications are forged.  
- **Corporate Sabotage**: Competing factions (e.g., *Ares Corp* vs. *NeoGaia Collective*) manipulate the player’s progress.  
- **Ancient Martian Life**: Unearth fossilized lichen with unique O² properties, hinting at Mars’ lost ecosystems.  

---

## **4. Gameplay Mechanics**  
### **Terraforming Subsystem**  
- **Tools**:  
  - **Basic Terraformer**: Converts small patches of land (barren → fertile/aquatic).  
  - **Ice Melters**: Unlocks mid-game; creates water sources from polar ice caps.  
  - **Regolith Converters**: Late-game tech to enrich Martian soil.  
- **Hazards**:  
  - **Dust Storms**: Temporarily disable terraforming and damage crops.  
  - **Radiation Spikes**: Force players to build shielded domes.  

### **Oxygen Production**  
- **Crops**:  
  - **Solar Saplings**: Starter trees, slow but reliable.  
  - **Cryo-Algae**: Grow in melted ice water, faster but fragile.  
  - **Symbiotic Lichen**: Late-game organism found in caves; produces O² *and* filters toxins.  
- **Storage**:  
  - Surface Tanks (80% piracy risk) → Reinforced Silos (40%) → Underground Vaults (0%).  

### **Threats**  
- **Pirates**:  
  - **Earth Remnants**: Desperate raiders with scavenged tech.  
  - **Corporate Privateers**: Disable defenses but steal blueprints.  
- **Environmental Disasters**:  
  - **Solar Flares**: Shut down electronics for 24 in-game hours.  
  - **Permafrost Quakes**: Crack open terrain, destroying crops.  

### **Economy & Trading**  
- **Currency**: SpaceCash (°) earned from O² sales or quests.  
- **Factions**:  
  - **Nomadic Traders**: Sell seeds and terraforming parts.  
  - **Black Market**: Offers stolen tech (e.g., pirate-grade weapons) but risks attracting law enforcement.  
  - **Orbital “Benefactors”**: Mysterious buyers who pay premium for O² (later revealed to be Earth’s elite).  

---

## **5. Progression System**  
### **Tech Tree**  
- **Terraforming**: Ice Melters → Regolith Converters → Atmospheric Processors.  
- **Crops**: Algae → Hybrid Plants → Bioengineered “O² Hyperblooms”.  
- **Combat**: Watchtowers → Laser Turrets → AI-Driven Combat Drones.  

### **Quests**  
- **Main Campaign**:  
  1. **“First Breath”**: Plant 10 trees and survive the first pirate raid.  
  2. **“The Silent Signal”**: Investigate a crashed satellite broadcasting Earth’s SOS.  
  3. **“The Last Harvest”**: Decide whether to send O² to Earth or sabotage orbital stations.  
- **Side Quests**:  
  - **“Worms of War”**: Neutralize invasive pests released by a rival corp.  
  - **“The Price of Air”**: Negotiate with pirates to protect your vaults.  

### **Milestones**  
- **Oxygen Thresholds**:  
  - 25%: Rain begins, reducing terraforming costs.  
  - 75%: Breathable atmosphere; humans can walk outside without suits.  
  - 100%: Mars’ sky turns blue, triggering the endgame choice.  

---

## **6. Art & Audio Direction**  
### **Visual Style**  
- **Environment**: Desolate Martian plains with cracked soil, shifting to lush greens/blues as O² rises.  
- **Structures**: Rustic, jury-rigged tech (e.g., solar panels patched with scrap metal).  
- **Creatures**: Alien insects attracted to O²-rich zones (e.g., glowing "Luminoth" moths).  

### **Sound Design**  
- **Ambience**: Howling winds, creaking metal, and distant machinery hum.  
- **Music**: Evolving soundtrack—lonely synths early, hopeful orchestral swells post-50% O².  
- **Voice Acting**: Traders speak with garbled radio effects to hide their origins.  

---

## **7. UI/UX Design**  
- **HUD Elements**:  
  - Global O² meter (top-right).  
  - Threat radar (bottom-left) blips red during raids.  
  - Subtle “sol” counter (Martian days) replaces a traditional clock.  
- **Menu Screens**:  
  - **Tech Tree**: Presented as a holographic projection from an in-game tablet.  
  - **Quest Log**: Designed like a colonist’s handwritten journal.  

---

## **8. Endgame & Post-Game Content**  
### **Final Choice**  
- **Sacrifice Mars**: Redirect O² to Earth, dooming your colony but saving remnants of humanity.  
- **Sever Earth**: Cut off orbital stations, saving Mars but triggering a war with corporate fleets.  

### **Post-Game**  
- **New Game+**: Restart with harder conditions (e.g., “Venus Mode” with acid rain).  
- **DLC Concepts**:  
  - *Earthfall*: Lead a rebellion on orbital stations.  
  - *Ancient Skies*: Revive Martian ecosystems using unearthed alien tech.  

---

## **9. Monetization (Optional)**  
- **Cosmetics**: Terraformer skins (e.g., “Retro Apollo” style), alien plant packs.  
- **Story DLC**: Expand faction questlines or add new planets.  

---

## **10. Development Roadmap**  
1. **Phase 1 (Prototype)**: Core terraforming/O² mechanics + basic pirate raids.  
2. **Phase 2 (Vertical Slice)**: Implement Mars landmarks, 1 faction questline, and UI.  
3. **Phase 3 (Polish)**: Balance economy, finalize environmental storytelling.  

---

**Next Steps**:  
- Finalize the Mars reveal sequence (buried rover logs/voice lines).  
- Prototype low-gravity physics for crops/characters.