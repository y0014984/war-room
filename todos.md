# TODOS

## Continue next time

Zudem sollte ich die spawns aus init und terminate rausnehmen und dafür eine prüfung einbauen, dass die function canSuspend hat. Dann muss halt von außen
in einem spawn scope ausgeführt werden.

## Nomenklatur

Eine "Entity" hat ein oder mehrere "Screens". Ein Screen is einer "Hidden Selection" zugewiesen. Eine "Hidden Selection" als Nummer ist nicht identisch mit dem "Screen Index", der stets mit
1 beginnt. Die "Textur" des "Screens" wird mit setObjectTexture gesetzt. Ein "Display" ist das UI eines "Screens", dass aus einem oder mehreren "Placeholdern" besteht. "Screens" können einzeln
über die ACE3 Interactions gesteuert werden. Daher werden sie im Menüpunkt "War Room" zusammengefasst.

## ACE3 Interactions

Interaction --> War Room --> Screen 1
                         --> Screen 2
                         --> Screen 3 --> enable/disable (Toggle)
                                      --> configure
                                      --> start presentation mode

## Todos

- add fps to the configure dialog
- in UI trennen zwischen localEffect (Auflösung und FPS) und globalEffekt (Layout und Placeholders/Slots)
- read uiClasses from config before populating the ui
- introduce "supportedUIClasses" config instead of defined ui classes per screen; 1st supported is the default one
- in GRAD Mod umwandeln?
- set color of WarRoom Head and Subhead to Background Color of Placeholder and Dummy Display
- initDevice funktion anstatt in der module funktion für z.B. Variablen und Texturen setzen
- was passiert mit setObjectTextureGlobal anstatt setObjectTexture?
- Sicherstellen, dass allgemeine Update-Funktionen auf dem Server laufen
- set every supported display to a default screen, saying "Please interact with me"
- add function to disable screen (oposite of init function), see ACE3 toggle interaction
- add CBA and ACE to the mod dependencies
- define _supportedAssetClasses only once and global (perhaps parsing all assets and filling in an array)
- change mod name (see asset browser; not @wr but real mod name)
- distinguish between:
  - players/units that are allowed to use War Room
  - assets (Monitors and so on) that provide War Room
  - targets (drones, players, maps) that are loadable into the assets
- add ACE3 dynamic interactions for manipulating the screens content
- add dialog templetes for all resolutions
  - 16:9
  - 16:10
  - 4:3
  - portrait modes?
- model fixes
  - evtl. bei den Whiteboards
- Schriftgröße etc. für die Map anpassen

## Later Enhancements

- add virtual pointer (real device in inventory) showing with mouse on a separate display
- hin- und herschwenkende Überwachungskamera aus Tutorial
- enable module for placing and manipulation in Zeus (Changing settings and syncing live)
- localization
- icon für mod und module
- mission creator can use a folder in it's mission called 'images' for example, that is scanned; Found images can be used in this mod
- set interaction points to the center of each screen

## Links

- <https://community.bistudio.com/wiki/CT_MAP_MAIN>
- <https://community.bistudio.com/wiki/Camera_Tutorial>
- <https://community.bistudio.com/wiki/Procedural_Textures#Render_To_Texture>
- <https://community.bistudio.com/wiki/Arma_3:_Custom_Info>
- <https://www.youtube.com/watch?v=1R561BtbeVo>
- <http://killzonekid.com/arma-scripting-tutorials-uav-r2t-and-pip/>
- <https://community.bistudio.com/wiki/Arma_3:_Mission_Event_Handlers>

## Annotations

- the UIonTexture displays are not closeable, but if the texture changes, the resulting display is also changing and is not identical with the first display
- but I also can't overwrite the existing one, because with changed layout the event handler for updating the content wont work
- only 40x25 Displays are possible; Can't react to different aspect ratios; everything outside of this will be cut off; everything smaller will be left blank
- can't place UI elements on Top of RscMapControl
- perhaps map does not show all textures; Workaround is to open the map manually and completely zoom out; This will fix the issue with the map on war room display
