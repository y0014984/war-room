#include "script_component.hpp"
#include "XEH_PREP.hpp"

/* ================================================================================ */

[
	"WR_defaultScreenResolution",
	"LIST",
	["Default Screen Resolution", "This is the default resolution, that will be used when activating war room screens for the first time."],
	"War Room",
	[
		[256, 512, 1024, 2048, 4096],
		[["256x256px", "256x256px"], ["512x512px", "512x512px"], ["1024x1024px", "1024x1024px"], ["2048x2048px", "2048x2048px"], ["4096x4096px", "4096x4096px"]],
		2
	],
    nil, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
    }, // function that will be executed once on mission start and every time the setting is changed.
    false // Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;

/* ================================================================================ */

[
	"WR_defaultScreenFps",
	"LIST",
	["Default Screen FPS", "This is the default FPS rate, that will be used when activating war room screens for the first time."],
	"War Room",
	[
		[1, 2, 3, 4, 5, 10, 20, 30, 45, 60],
		[
            ["1 FPS", "1 FPS"], ["2 FPS", "2 FPS"], ["3 FPS", "3 FPS"], ["4 FPS", "4 FPS"], ["5 FPS", "5 FPS"], 
            ["10 FPS", "10 FPS"], ["20 FPS", "20 FPS"], ["30 FPS", "30 FPS"], ["45 FPS", "45 FPS"], ["60 FPS", "60 FPS"]
        ],
		5
	],
    nil, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
    }, // function that will be executed once on mission start and every time the setting is changed.
    false // Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;

/* ================================================================================ */