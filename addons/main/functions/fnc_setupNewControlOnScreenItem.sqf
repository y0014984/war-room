params ["_entity", "_screenIndex", "_ScreenItemIndex"];

/* ================================================================================ */

// get the display for the ui on texture feature
private _uiOnTextureDisplay = _entity getVariable [format ["WR_uiOnTextureDisplayScreen%1", _screenIndex], displayNull];
if (isNull _uiOnTextureDisplay) exitWith {};

// all screen items have an id in the 3000 range; 1st screnn item is always 3000, 2nd is 3001 and so on
private _screenItemCtrl = _uiOnTextureDisplay displayCtrl (3000 + _screenItemIndex);

// get the position of the screen item control
private _ctrlPos = ctrlPosition _screenItemCtrl;

private _screenItemType = _entity getVariable [format ["WR_screen%1Item%2Type", _screenIndex, _screenItemIndex], ""];
private _screenItemContent = _entity getVariable [format ["WR_screen%1Item%2Content", _screenIndex, _screenItemIndex], nil];

if (_screenItemType isEqualTo "") exitWith {};

/* ================================================================================ */

if (_screenItemType isEqualTo "IMAGE") exitWith
{
	// add a new control
	// all new controls will be placed on top of the screen items and will be in the 4000 range, which is always free
	private _imageCtrl = _uiOnTextureDisplay ctrlCreate ["RscPicture", (4000 + _screenItemIndex)];

	// set position of new control to screen items position
	// ctrlSetPosition for all ctrl except maps
	_imageCtrl ctrlSetPosition _ctrlPos;
	_imageCtrl ctrlCommit 0;

	// set control text to relative image path
	_imageCtrl ctrlSetText _screenItemContent;
};

/* ================================================================================ */

if (_screenItemType isEqualTo "MAP") exitWith
{
	// add a new control
	// all new controls will be placed on top of the screen items and will be in the 4000 range, which is always free
	private _mapCtrl = _uiOnTextureDisplay ctrlCreate ["RscMapControl", (4000 + _screenItemIndex)];

	// set position of new control to screen items position
	// ctrlSetPosition for all ctrl except maps
	_mapCtrl ctrlMapSetPosition _ctrlPos;
	_mapCtrl ctrlCommit 0;
	_mapCtrl ctrlMapSetPosition []; // sync

	_screenItemContent params ["_mapCenterWorldPos", "_mapScale"];

	_mapCtrl ctrlMapAnimAdd [0, _mapScale, _mapCenterWorldPos];
	ctrlMapAnimCommit _mapCtrl;
};

/* ================================================================================ */

true;

/*
        _uav1Target, _uav2Target

        private _uav1HeadlineCtrl = _uiOnTextureDisplay displayCtrl 5002;
        private _uav2HeadlineCtrl = _uiOnTextureDisplay displayCtrl 5003;

		private _uav1Pos = getPosAsL _uav1Target;
		private _uav2Pos = getPosAsL _uav2Target;
		
		_uav1HeadlineCtrl ctrlSetText format ["UAV 1 (Pos: %1)", mapGridPosition _uav1Pos];
		_uav2HeadlineCtrl ctrlSetText format ["UAV 2 (Pos: %1)", mapGridPosition _uav2Pos];
*/