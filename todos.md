# TODOS

## Continue next time

- wenn item type ausgewählt aber dann dialog mit cancel abgebrochen, bleibt der item type stehen
- alte settings in screen item detail ui laden, wenn man bereits konfiguriertes erneut öffnet
- add map
- add cam
- add presentation mode
- modify module with radio button options (allow diffent screen item types)
- add multiplayer compatibility

## Nomenklatur

Eine "Entity" hat ein oder mehrere "Screens". Ein Screen is einer "Hidden Selection" zugewiesen. Eine "Hidden Selection" als Nummer ist nicht identisch mit dem "Screen Index", der stets mit
1 beginnt. Die "Textur" des "Screens" wird mit setObjectTexture gesetzt. Ein "Display" ist das UI eines "Screens", dass aus einem oder mehreren "Screen Items" besteht. "Screens" können einzeln
über die ACE3 Interactions gesteuert werden. Daher werden sie im Menüpunkt "War Room" zusammengefasst.

## ACE3 Interactions

Interaction --> War Room --> Screen 1
                         --> Screen 2
                         --> Screen 3 --> enable/disable (Toggle)
                                      --> configure
                                      --> start presentation mode

## Screen Item Types

- static image (paa file in the "war-room" folder inside mission file)
- static map (define map center and zoom level)
- follow map (define object to follow and zoom level)
- static cam (define cam object and view mode, like nightvision, normal, thermal and so on)
- surveillance cam (define cam object, hor. & vert. angle, speed, movement direction)
- friedly forces cam (define friedly unit)
- drone cam (define drone)

## Todos

- Dragon wegen der Extension mit bei den Autoren nennen
- find a way to add all 8 strean items to screen config ui, instead of only 7
- in UI trennen zwischen localEffect (Auflösung und FPS) und globalEffekt (Layout und Screen Items)
- in GRAD Mod umwandeln?
- set color of WarRoom Head and Subhead to Background Color of ScreenItem and Dummy Display
- initDevice funktion anstatt in der module funktion für z.B. Variablen und Texturen setzen
- was passiert mit setObjectTextureGlobal anstatt setObjectTexture?
- Sicherstellen, dass allgemeine Update-Funktionen auf dem Server laufen
- add CBA and ACE to the mod dependencies
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

- möglicherweise stotterndes Bild wenn man sich um aktive Screens herum bewegt
- the UIonTexture displays are not closeable, but if the texture changes, the resulting display is also changing and is not identical with the first display
- but I also can't overwrite the existing one, because with changed layout the event handler for updating the content wont work
- only 40x25 Displays are possible; Can't react to different aspect ratios; everything outside of this will be cut off; everything smaller will be left blank
- can't place UI elements on Top of RscMapControl
- perhaps map does not show all textures; Workaround is to open the map manually and completely zoom out; This will fix the issue with the map on war room display
