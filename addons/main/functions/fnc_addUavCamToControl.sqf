params ["_camObject", "_camCtrl", "_screenItemIndex"];

/* ================================================================================ */

// destroy previously cam
private _cam = _camObject getVariable ["WR_cam", objNull];
camDestroy _cam;

// render to texture name needs to be unique every time
// therefore adding timestamp
private _r2tName = format ["rtt-%1-%2", _screenItemIndex, time];

// create camera and stream to render surface
_cam = "camera" camCreate [0,0,0];
_cam cameraEffect ["Internal", "Back", _r2tName];

// attach cam to gunner cam position
_cam attachTo [_camObject, [0,0,0], "PiP0_pos"];

// make it zoom in a little
_cam camSetFov 0.1;

// switch cam to thermal
_r2tName setPiPEffect [0];

/*
Mode	Description							Parameters
0		Normal								[0]
1		Night Vision						[1]
2		Thermal Imaging						[2]
3		Color Correction					[3, enabled, brightness, contrast, offset, blend [r,g,b,a], lerp [r,g,b,a], rgb [r,g,b,a]]
7		Alt. Thermal Imaging 1 (Inverted)	[7]
8		Alt. Thermal Imaging 2 (Green)		[8]
9..70	Alt. Thermal Imaging 3..64			[n]
*/

_camObject setVariable ["WR_cam", _cam];

/* ================================================================================ */

// add texture to control
_camCtrl ctrlSetText format ["#(argb,512,512,1)r2t(%1,1.0)", _r2tName];
_camCtrl ctrlCommit 0;

/* ================================================================================ */

// remove previously event handler
private _uavDirAdjustHandle = _camObject getVariable ["WR_uavDirAdjustHandle", -1];
if (_uavDirAdjustHandle != -1) then { removeMissionEventHandler ["Draw3D", _uavDirAdjustHandle]; };

// adjust cam orientation
_uavDirAdjustHandle = addMissionEventHandler
[
    "Draw3D",
    {
        _thisArgs params ["_camObject", "_cam"];

        private _dir = 
            (_camObject selectionPosition "PiP0_pos") 
                vectorFromTo 
            (_camObject selectionPosition "PiP0_dir");
        _cam setVectorDirAndUp
        [
            _dir, 
            _dir vectorCrossProduct [-(_dir select 1), _dir select 0, 0]
        ];
    },
    [_camObject, _cam]
];

_camObject setVariable ["WR_uavDirAdjustHandle", _uavDirAdjustHandle];

/* ================================================================================ */