# Terminator Resistance VR
6DOF Motion Controller UEVR Profile + VR Fix Mod
## Requires UEVR 1.05 (or Nightly)
https://github.com/praydog/UEVR

<!-- 
## For Terminator Resistance v1028 ONLY

To downgrade from the latest version, here is a great guide posted by Markmon:
<details>

<summary>How to downgrade to v1028 </summary>

1)  load steam console by clicking this link or pasting it into start, run box: 
```
steam://nav/console
```
2)  In the steam client on the console tab, paste this command in the console line at the bottom and hit enter: 
```
download_depot 954740 954741 6319668420982262798
```
3)  There's no progress bar, but it will say it's downloading and also tell you when it's done and where it put the files. Will look like this: 

    > download_depot 954740 954741 6319668420982262798
    
    > Downloading depot 954741 (10808 MB) ...
    
    > Depot download complete : "C:\Program Files (x86)\Steam\steamapps\content\app_954740\depot_954741" (43 files, manifest 6319668420982262798) 

5)  Go to your game files by finding your game, right click and hover on manage, then "browse local files" 

6)  This puts you somewhere like SteamLibrary\steamapps\common\Terminator Resistance 

7)  Delete all these files and copy the downloaded files from the location the console gave you "C:\Program Files (x86)\Steam\steamapps\content\app_954740\depot_954741" into the now empty folder. 

8)  When you're done, steam wont even know you downgraded. Play the game normally.
</details>
(Source - https://discord.com/channels/747967102895390741/1095016511103569951/1225089854094704751)

---
-->

# Installation
### IMPORTANT - If you used the older v1028 profile/mods, you NEED to remove them first
(This includes the optional VR Menu mod and Aiming Crosshair mod)
<details>

<summary>How to remove the previous v1028 profile and mods</summary>

1)  [Profile] Delete/Rename the folder "Terminator-Win64-Shipping" in your UEVR "Global Dir"

2)  [Crosshair mod] Delete the following files/folder in "Terminator\Binaries\Win64": 
```
(Folder) -> Mods
(File)   -> UE4SS-settings.ini
(File)   -> xinput1_3.dll
```
3)  [Crosshair mod] Delete the following folder in "Terminator\Content\Paks": 
```
(Folder) -> LogicMods
```
5)  [VR Menu mod] Delete the following file in "Terminator\Content\Paks":
```
(File) -> CusLogo_P.pak
```
</details>

----

Thank you AcknowledgedPawn for your valuable feedback and testing :pray: 

----

# IMPORTANT
## The following UEVR settings are controlled by the Mod
- Aim Method
- D-Pad Shifting Method
- DecoupledPitchUIAdjust
- UI Distance
- UI Size
- CameraUpOffset
- CameraForwardOffset
- CameraRightOffset
----



## Controls
- No change to game controls
- If using the Crosshair mod, will appear when you aim
- Left Thumb-Stick switches to D-Pad for menu's/Inventory
- Optional plugin for Index Controllers by Markmon

    (Below is for folks who don't want to click their Thumb-Sticks) 

- Sprint mapped to Right Thumb-Stick ↑ 
- Ultra-Vision/Camera mapped to Right Thumb-Stick ↓
----



## Weapon Wheel
1. Hold your Left Grip to open the Weapon Wheel
2. Select weapon with Right Stick

    While the Weapon Wheel is open, ..  

    Left Thumb-Stick switches to a D-Pad, allowing you to select: 

- ↓ Flashlight (hold for 1 second)
- ↑ Inventory
- Change ← Offensive | Defensive →

    This also works when at the Shelter and Hideout (when the weapon wheel does NOT show) so you can enable flashlight or open inventory. 
----



## Camera Control (NOT UltraVision)
1. Hold Right Stick ↑ While the Camera is Enabled

    While holding Right Stick ↑, Use: 

- Left Stick ←  = Decrease zoom
- Left Stick →  = Increase zoom

    (View will NOT change, you will hear a Click to signify zoom was clicked)
  
    Once you let go of the Right Stick, you can move around normally. 
----



## Melee Gesture
- Swing your Right Controller in ANY direction
- Stop your Right Controller pointing at the object/enemy you wish to hit
- Melee will trigger
####  (In game Melee (Y button) still works as intended)
----



## Recenter/Re-calibrate (standing or sitting)
- Quickly press Left+Right Trigger during menus/cut-scenes/interactions
- Also resets standing height and position
- If Inventory/Pause screen is not centered, press Left+Right Trigger
----


## Other Features
- Weapon scale fixed
- Character scale fixed
- Bullet spread reduced when not aiming
- Weapon sway and magnetism removed
- Aiming walk speed increased
- Movement orientation set to HMD (feel free to change)
- Free head/controller movement in main menu/pause menu/inventory/cut-scenes/Interactions
- Picking up items attached to Right Motion controller
- Original *In-Game* crosshair removed (scopes remain)
- All dialogues have free head/controller movement
- All mid-game mini-cut cams detached from controller
- Camera fully use-able
- Scale fixes included so no need for extra "scale-fix" pak mods
- Crouching heights fixed (mainly for in Vents)
- Fog/Mist/Smoke appearance now looks same in both eyes
- Fixed LOD/Draw distance issues (some ground leveling still visible)
- Fixed LOD/Draw distance changes when aiming
- Some cvar tweaks
- _Much more, .. Too many to list_
----


## Important Notes / FAQ's
:question: _SteamVR keeps launching when I start the game_

:bulb: Add "-nohmd" to the game's Launch Properties

---

:question: _Game is crashing and/or won't launch_

:bulb: If you used the older v1028 mod REMOVE "-nohmd" from the game's Launch Properties

---

:question: _Some cut-scenes have no subtitles_

:bulb: The UI has been removed to remove black bars from cut-scenes, this means that the subtitles for those parts are also invisible

---

:question: _Smoke/Fog only appearing in 1 eye_

:bulb: Set "Effects" to "Epic" in the Game's settings, the user_script file will take care of the rest

---

:question: _Locks/Hacking device may appear at odd angle_

:bulb: For best result, point your controller straight ahead.

---

:question: _In the Metro scene where you shoot a Terminator on the floor you lose aiming_

:bulb: Simply walk forwards until you hear Jennifer/Baron talk, aiming will return.

---

:question: _Performance_

:bulb:  Here are some graphic and performance tweaks, ..

https://gameplay.tips/guides/5903-terminator-resistance.html

Simply add the cvars you want to use to the end of the "user_script.txt" file in the profile.

(Be sure to replace "=" with a space, see below for examples)

###     These are the ones I personally use.</ins>

    r.Shadow.DistanceScale 5.0 

    foliage.LODDistanceScale 6 

    r.ShadowQuality 5 

    r.Shadow.RadiusThreshold 0.01 

    r.Shadow.SpotLightTransitionScale 2048 

    r.Shadow.CSM.MaxCascades 16 

    r.StaticMeshLODDistanceScale 0.1 

    r.MipMapLodBias -1 

    r.Streaming.MipBias -1 

    r.Streaming.HiddenPrimitiveScale 1 

    r.Streaming.UseAllMips 1 

    r.Streaming.FullyLoadUsedTextures 1 

    r.Streaming.HLODStrategy 2 

    r.Streaming.PoolSize 6144 



