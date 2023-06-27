params ["_entity", "_uav"];

// create camera and stream to render surface
private _cam = "camera" camCreate [0,0,0];
_cam cameraEffect ["Internal", "Back", "uavrtt"];

// attach cam to gunner cam position
_cam attachTo [_uav, [0,0,0], "PiP0_pos"];

// make it zoom in a little
_cam camSetFov 0.1;

// switch cam to thermal
"uavrtt" setPiPEffect [0];

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

private _uiOnTextureDisplay = _entity getVariable ["WR_uiOnTextureDisplay", displayNull];
private _uavFeedCtrl = _uiOnTextureDisplay displayCtrl 3002;
_uavFeedCtrl ctrlSetText "#(argb,512,512,1)r2t(uavrtt,1.0)";
_uavFeedCtrl ctrlCommit 0;

// adjust cam orientation
private _uavDirAdjustHandle = addMissionEventHandler
[
	"Draw3D",
	{
		_thisArgs params ["_uav", "_cam"];

		private _dir = 
			(_uav selectionPosition "PiP0_pos") 
				vectorFromTo 
			(_uav selectionPosition "PiP0_dir");
		_cam setVectorDirAndUp
		[
			_dir, 
			_dir vectorCrossProduct [-(_dir select 1), _dir select 0, 0]
		];
	},
	[_uav, _cam]
];

_uav setVariable ["WR_uavDirAdjustHandle", _uavDirAdjustHandle];

true;