# DOCUMENTATION

## High Prio Todos

- show content in presentation mode
- Überschrift größer
- modify module with radio button options (allow diffent screen item types)
- platz in den screen item ui's besser ausnutzen (links unten)
- allow setting up different camera modes for Uavs
- fps werden nicht gesynct zw. ui und tatsächlichen einstellungen (load der settings) --> nur in MP?
- add WarRoom 6 (Wie War Room 4, nur dass 0 und 1 zusammen das erste element bilden)
- wenn item type ausgewählt aber dann dialog mit cancel abgebrochen, bleibt der item type stehen
- alte settings in screen item detail ui laden, wenn man bereits konfiguriertes erneut öffnet
- uiclass Auswahl auch über separate UI --> Platz für alle 8 Placeholder
- Eine FPS Einstellung für "Keine Updates" hinzufügen, quasi 0 FPS
- Automatische Einstellung von 0 FPS, wenn keine Screen Items gesetzt sind oder nur Text und Images
- adjustable text and background color for text item (in ui config)
- allow text files (structured text)
- add buttons to modify current text selection (text size for example) --> show text as structured text (simple text editor)
- Script Screen Item mit Custom Output
- Fraktionslogo in Titelleiste
- kann man bei UIonTexture die AspectRatio verändern?
- Alternativtexte als Überschriften anstatt auto-Beschriftung (Optional per zusätzlichem Config-Feld)
- Während Presentation mode bewegbar?

## Low Prio Todos

- support all screens
- support additional Uavs
- Dragon wegen der Extension mit bei den Autoren nennen
- find a way to add all 8 strean items to screen config ui, instead of only 7
- in UI trennen zwischen localEffect (Auflösung und FPS) und globalEffekt (uiClass und Screen Items)
- in GRAD Mod umwandeln?
- set color of WarRoom Head and Subhead to Background Color of ScreenItem and Dummy Display
- initDevice funktion anstatt in der module funktion für z.B. Variablen und Texturen setzen
- change mod name (see asset browser; not @wr but real mod name)
- distinguish between:
  - players/units that are allowed to use War Room
  - assets (Monitors and so on) that provide War Room
  - targets (drones, players, maps) that are loadable into the assets
- Schriftgröße etc. für die Map anpassen oder allgemein bei dem Jets Screen
- Auto Populate _supportedClasses From Config
- icon für mod und module
- command: getTextureInfo --> Zusatzinfos über Bilder
- command: screenshot --> vielleicht live aufnehmen und auf dem Screen zeigen?
- Video Screen Item

## Later Enhancements

- configure screen, indem der originalscreen angezeigt wird und man auf die einzelnen placeholder klickt
- hin- und herschwenkende Überwachungskamera aus Tutorial
- enable module for placing and manipulation in Zeus (Changing settings and syncing live)
- localization
- set interaction points to the center of each screen

## Nomenklatur

Eine "Entity" hat ein oder mehrere "Screens". Ein Screen is einer "Hidden Selection" zugewiesen. Eine "Hidden Selection" als Nummer ist nicht identisch mit dem "Screen Index", der stets mit
1 beginnt. Die "Textur" des "Screens" wird mit setObjectTexture gesetzt. Ein "Display" ist das UI eines "Screens", dass aus einem oder mehreren "Screen Items" besteht. "Screens" können einzeln
über die ACE3 Interactions gesteuert werden. Daher werden sie im Menüpunkt "War Room" zusammengefasst.

## ACE3 Interactions

Entity Interaction --> War Room --> Screen 1
                                --> Screen 2
                                --> Screen 3 --> enable/disable (Toggle)
                                             --> configure
                                             --> start presentation mode

## Screen Item Types

- static image (paa file in the "war-room" folder inside mission file) --> done
- static map (define map center and zoom level) --> done
- follow map (define object to follow and zoom level)
- static cam (define cam object and view mode, like nightvision, normal, thermal and so on)
- surveillance cam (define cam object, hor. & vert. angle, speed, movement direction)
- friedly forces cam (define friedly unit)
- drone cam (define drone) --> in progress
- structured text --> done
- video

## Links

- <https://community.bistudio.com/wiki/CT_MAP_MAIN>
- <https://community.bistudio.com/wiki/Camera_Tutorial>
- <https://community.bistudio.com/wiki/Procedural_Textures#Render_To_Texture>
- <https://community.bistudio.com/wiki/Arma_3:_Custom_Info>
- <https://www.youtube.com/watch?v=1R561BtbeVo>
- <http://killzonekid.com/arma-scripting-tutorials-uav-r2t-and-pip/>
- <https://community.bistudio.com/wiki/Arma_3:_Mission_Event_Handlers>

## Annotations / known bugs

- presentation mode does not word with JIP (can't see the pointer) but on normal startup;
  - It's not that big problem, because if the presentator stops presentation and starts it again, everybody can see the pointer
- No entry 'bin\config.bin/CfgVehicles/CLASSNAME'. for some classes. Don't know why.
- die Extension für die Bilder funktioniert nur, wenn die Mission lokal ungepackt vorliegt, also vermutlich nur, wenn der Server die Mission ungepackt hat oder in einem Hosted Multiplayer ungepackt aus dem Editor heraus
  - vielleicht kann ich etwas bauen, dass die Extension nur während des Missionsbaus verwendet, und dann einfach die Daten irgendwie in die Mission schreibt, die dann später z.B. als config ausgelesen werden kann
- möglicherweise stotterndes Bild wenn man sich um aktive Screens herum bewegt
- the UIonTexture displays are not closeable, but if the texture changes, the resulting display is also changing and is not identical with the first display
  - but I also can't overwrite the existing one, because with changed uiclass the event handler for updating the content wont work
- only 40x25 Displays are possible; Can't react to different aspect ratios; everything outside of this will be cut off; everything smaller will be left blank
- perhaps map does not show all textures; Workaround is to open the map manually and completely zoom out; This will fix the issue with the map on war room display
- bei r2t (für z.B. dronen) kann auch aspect ratio angegeben werden; Könnte das Seitenverhältnis des Placeholders übergeben
  - das führt leider auch, wie bei anderen versuchen dazu, dass ein ein paar r2t funktioneren, und dann dass system keine neuen mehr darstellt
