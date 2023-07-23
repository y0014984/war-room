params ["_entity", "_screenIndex", "_ScreenItemIndex"];

/* ================================================================================ */

// get the display for the ui on texture feature
private _uiOnTextureDisplay = _entity getVariable [format ["WR_uiOnTextureDisplayScreen%1", _screenIndex], displayNull];
if (isNull _uiOnTextureDisplay) exitWith {};

// all screen items have an id in the 3000 range; 1st screnn item is always 3000, 2nd is 3001 and so on
private _screenItemCtrl = _uiOnTextureDisplay displayCtrl (3000 + _screenItemIndex);

// all screen item info boxes have an id in the 5000 range; 1st screnn item info box is always 5000, 2nd is 5001 and so on
private _screenItemInfoboxCtrl = _uiOnTextureDisplay displayCtrl (5000 + _screenItemIndex);

// get the position of the screen item control and screen item infobox control
private _screenItemCtrlPos = ctrlPosition _screenItemCtrl;
private _screenItemInfoboxCtrlPos = ctrlPosition _screenItemInfoboxCtrl;

private _screenItemType = _entity getVariable [format ["WR_screen%1Item%2Type", _screenIndex, _screenItemIndex], ""];
private _screenItemContent = _entity getVariable [format ["WR_screen%1Item%2Content", _screenIndex, _screenItemIndex], nil];

if (_screenItemType isEqualTo "") exitWith {};

/* ================================================================================ */

if (_screenItemType isEqualTo "IMAGE") exitWith
{
	// add a new control
	// all new controls will be placed on top of the screen items and will be in the 4000 range, which is always free
	private _imageCtrl = _uiOnTextureDisplay ctrlCreate ["RscPicture", (4000 + _screenItemIndex)];
	private _imageInfoboxCtrl = _uiOnTextureDisplay ctrlCreate ["RscText", (6000 + _screenItemIndex)];

	_imageInfoboxCtrl ctrlSetBackgroundColor [0.2, 0.2, 0.2, 0.5]; // translucent grey

	// set position of new control to screen items position
	// ctrlSetPosition for all ctrl except maps
	_imageCtrl ctrlSetPosition _screenItemCtrlPos;
	_imageCtrl ctrlCommit 0;

	_imageInfoboxCtrl ctrlSetPosition _screenItemInfoboxCtrlPos;
	_imageInfoboxCtrl ctrlCommit 0;

	_screenItemContent params ["_imageName", "_path"];

	// set control text to relative image path
	_imageCtrl ctrlSetText _path;

	private _imageNameWithoutExtension = [_imageName] call WR_main_fnc_removeFilenameExtension;
	
	_imageInfoboxCtrl ctrlSetText format ["%1", _imageNameWithoutExtension];
};

/* ================================================================================ */

if (_screenItemType isEqualTo "MAP") exitWith
{
	// add a new control
	// all new controls will be placed on top of the screen items and will be in the 4000 range, which is always free
	private _mapCtrl = _uiOnTextureDisplay ctrlCreate ["RscMapControl", (4000 + _screenItemIndex)];
	private _mapInfoboxCtrl = _uiOnTextureDisplay ctrlCreate ["RscText", (6000 + _screenItemIndex)];

	_mapInfoboxCtrl ctrlSetBackgroundColor [0.2, 0.2, 0.2, 0.5]; // translucent grey

	// set position of new control to screen items position
	// ctrlSetPosition for all ctrl except maps
	_mapCtrl ctrlMapSetPosition _screenItemCtrlPos;
	_mapCtrl ctrlCommit 0;
	_mapCtrl ctrlMapSetPosition []; // sync

	_mapInfoboxCtrl ctrlSetPosition _screenItemInfoboxCtrlPos;
	_mapInfoboxCtrl ctrlCommit 0;

	_screenItemContent params ["_mapCenterWorldPos", "_mapScale"];

	_mapCtrl ctrlMapAnimAdd [0, _mapScale, _mapCenterWorldPos];
	ctrlMapAnimCommit _mapCtrl;

	_mapInfoboxCtrl ctrlSetText format ["%1 (Pos: %2)", worldName, mapGridPosition _mapCenterWorldPos];
};

/* ================================================================================ */

if (_screenItemType isEqualTo "CAM") exitWith
{
	// add a new control
	// all new controls will be placed on top of the screen items and will be in the 4000 range, which is always free
	private _camCtrl = _uiOnTextureDisplay ctrlCreate ["RscPicture", (4000 + _screenItemIndex)];
	private _camInfoboxCtrl = _uiOnTextureDisplay ctrlCreate ["RscText", (6000 + _screenItemIndex)];

	_camInfoboxCtrl ctrlSetBackgroundColor [0.2, 0.2, 0.2, 0.5]; // translucent grey

	// set position of new control to screen items position
	// ctrlSetPosition for all ctrl except maps
	_camCtrl ctrlSetPosition _screenItemCtrlPos;
	_camCtrl ctrlCommit 0;

	_camInfoboxCtrl ctrlSetPosition _screenItemInfoboxCtrlPos;
	_camInfoboxCtrl ctrlCommit 0;

	private _camObject = _screenItemContent;

	[_camObject, _camCtrl] call WR_main_fnc_addUavCamToControl;

	_camInfoboxCtrl ctrlSetText format ["%1 (Pos: %2)", _camObject, mapGridPosition _camObject];
};

/* ================================================================================ */

if (_screenItemType isEqualTo "TEXT") exitWith
{
	// add a new control
	// all new controls will be placed on top of the screen items and will be in the 4000 range, which is always free
	private _textCtrl = _uiOnTextureDisplay ctrlCreate ["RscStructuredText", (4000 + _screenItemIndex)];
	private _textInfoboxCtrl = _uiOnTextureDisplay ctrlCreate ["RscText", (6000 + _screenItemIndex)];

	_textInfoboxCtrl ctrlSetBackgroundColor [0.2, 0.2, 0.2, 0.5]; // translucent grey

	// set position of new control to screen items position
	// ctrlSetPosition for all ctrl except maps
	_textCtrl ctrlSetPosition _screenItemCtrlPos;
	_textCtrl ctrlSetBackgroundColor [0.3, 0.3, 0.3, 1]; // opaque dark grey
	_textCtrl ctrlCommit 0;

	_textInfoboxCtrl ctrlSetPosition _screenItemInfoboxCtrlPos;
	_textInfoboxCtrl ctrlCommit 0;

	_screenItemContent params ["_headline", "_text"];

	// convert new lines into <br/>
	_text = _text splitString endl; // "\n";
	// add leading 2 empty lines to the beginning of the text, so the headline won't interfere with the text
	_text = ["", ""] + _text;
	_text = _text joinString "<br/>";

	// set control text to text
	_textCtrl ctrlSetStructuredText (parseText _text);
	
	_textInfoboxCtrl ctrlSetText format ["%1", _headline];
};

/* ================================================================================ */

true;