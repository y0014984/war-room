params ["_event", "_params"];

/* ================================================================================ */

if (_event isEqualTo "onInitDialog") exitWith
{
    _params params ["_target", "_screenIndex", "_screenItemIndex", "_resultCtrl"];

    private _dialog = createDialog ["ConfigureScreenCamItemDialog", true];

    _dialog setVariable ["WR_target", _target];
    _dialog setVariable ["WR_screenIndex", _screenIndex];
    _dialog setVariable ["WR_screenItemIndex", _screenItemIndex];
    _dialog setVariable ["WR_resultCtrl", _resultCtrl];

    // get all available cams (testing with drones)
 	private _allUavs = allUnitsUAV;
	private _filteredUavs = [];
	{
		private _allowedUavClasses = ["B_UAV_01_F"];
		if ((typeOf _x) in _allowedUavClasses) then { _filteredUavs pushBack _x; };
	} forEach _allUavs;

    private _camObjects = _filteredUavs;

    private _camSelectCtrl = _dialog displayCtrl 4001;

    {
        private _displayName = [configFile >> "CfgVehicles" >> typeOf _x] call BIS_fnc_displayName;
        private _varName = vehicleVarName _x;
        _camSelectCtrl lbAdd format ["%1 (%2)", _displayName, _varName];
    } forEach _camObjects;

    _dialog setVariable ["WR_camObjects", _camObjects];

    _camSelectCtrl setVariable ["WR_ctrlInitialised", true];

    _camSelectCtrl lbSetCurSel 0;

    systemChat format ["_camObjects: %1", _camObjects];
};

/* ================================================================================ */

if (_event isEqualTo "onUnloadDialog") exitWith
{
    _params params ["_dialog", "_exitCode"];
    // ok = 1, cancel = 2

    if (_exitCode == 2) exitWith {};

    private _target = _dialog getVariable ["WR_target", objNull];

    private _screenIndex = _dialog getVariable ["WR_screenIndex", -1];
    private _screenItemIndex = _dialog getVariable ["WR_screenItemIndex", -1];
    private _resultCtrl = _dialog getVariable ["WR_resultCtrl", controlNull];
    private _screenItemType = _dialog getVariable ["WR_screenItemType", ""];
    private _screenItemContent = _dialog getVariable ["WR_screenItemContent", nil];

    if (_screenItemType isEqualTo "") exitWith { _resultCtrl ctrlSetText ""; };

    _target setVariable [format ["WR_screen%1Item%2Type", _screenIndex, _screenItemIndex], _screenItemType, true];
    _target setVariable [format ["WR_screen%1Item%2Content", _screenIndex, _screenItemIndex], _screenItemContent, true];

    // remove previously event handler
    private _uavDirAdjustHandle = _camObject getVariable ["WR_uavDirAdjustHandle", -1];
    if (_uavDirAdjustHandle != -1) then { removeMissionEventHandler ["Draw3D", _uavDirAdjustHandle]; };

    // destroy previously cam
    private _cam = _camObject getVariable ["WR_cam", objNull];
    camDestroy _cam;

    _resultCtrl ctrlSetText format ["%1 - %2", _screenItemType, _screenItemContent];
};

/* ================================================================================ */

if (_event isEqualTo "onLBSelChangedCam") exitWith
{
    _params params ["_control", "_lbCurSel", "_lbSelection"];

    private _ctrlInitialised = _control getVariable ["WR_ctrlInitialised", false];

    if (!_ctrlInitialised) exitWith {};

    private _dialog = ctrlParent _control;

    private _camObjects = _dialog getVariable ["WR_camObjects", []];
    private _camObject = _camObjects select _lbCurSel;

    systemChat format ["_camObjects: %1\n_lbCurSel: %2\n_camObject: %3", _camObjects, _lbCurSel, _camObject];

    private _camCtrl = _dialog displayCtrl 5001;

    [_camObject, _camCtrl] call WR_main_fnc_addUavCamToControl;

    _dialog setVariable ["WR_screenItemType", "CAM"];
    _dialog setVariable ["WR_screenItemContent", _camObject];

    systemChat format ["cam added to cam object: %1", _camObject];
};

/* ================================================================================ */
