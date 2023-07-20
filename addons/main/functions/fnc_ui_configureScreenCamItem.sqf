params ["_event", "_params"];

/* ================================================================================ */

if (_event isEqualTo "onInitDialog") exitWith
{
    _params params ["_target", "_screenIndex", "_screenItemIndex", "_selectCtrl", "_resultCtrl"];

    private _dialog = createDialog ["ConfigureScreenCamItemDialog", true];

    _dialog setVariable ["WR_target", _target];
    _dialog setVariable ["WR_screenIndex", _screenIndex];
    _dialog setVariable ["WR_screenItemIndex", _screenItemIndex];
    _dialog setVariable ["WR_selectCtrl", _selectCtrl];
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
        _camSelectCtrl lbAdd _displayName;
    } forEach _camObjects;

    _camSelectCtrl lbSetCurSel 0;

    _dialog setVariable ["WR_camObjects", _camObjects];

    _camSelectCtrl setVariable ["WR_ctrlInitialised", true];

    systemChat format ["_camObjects: %1", _camObjects];
};

/* ================================================================================ */

if (_event isEqualTo "onUnloadDialog") exitWith
{
    _params params ["_dialog", "_exitCode"];
    // ok = 1, cancel = 2

    if (_exitCode == 2) exitWith {};

    private _target = _dialog getVariable ["WR_target", objNull];
    private _selectCtrl = _dialog getVariable ["WR_selectCtrl", controlNull];

    private _screenIndex = _dialog getVariable ["WR_screenIndex", -1];
    private _screenItemIndex = _dialog getVariable ["WR_screenItemIndex", -1];
    private _resultCtrl = _dialog getVariable ["WR_resultCtrl", controlNull];
    private _screenItemType = _dialog getVariable ["WR_screenItemType", ""];
    private _screenItemContent = _dialog getVariable ["WR_screenItemContent", nil];

    if (_screenItemType isEqualTo "") exitWith { _resultCtrl ctrlSetText ""; };

    _target setVariable [format ["WR_screen%1Item%2Type", _screenIndex, _screenItemIndex], _screenItemType];
    _target setVariable [format ["WR_screen%1Item%2Content", _screenIndex, _screenItemIndex], _screenItemContent];

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

    // r2t texture name
    _r2tName = format ["uavrtt%1", _lbCurSel];

    // create camera and stream to render surface
    private _cam = "camera" camCreate [0,0,0];
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


    // add texture to control
    private _camCtrl = _dialog displayCtrl 5001;
    _camCtrl ctrlSetText format ["#(argb,512,512,1)r2t(%1,1.0)", _r2tName];
    _camCtrl ctrlCommit 0;

    // remove previously event handler
    private _uavDirAdjustHandle = _camObject getVariable ["WR_uavDirAdjustHandle", -1];
    removeMissionEventHandler ["Draw3D", _uavDirAdjustHandle];

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

            hintSilent format ["_camObject: %1\n_cam: %2", _camObject, _cam];
        },
        [_camObject, _cam]
    ];

    _camObject setVariable ["WR_uavDirAdjustHandle", _uavDirAdjustHandle];

    systemChat format ["cam added to cam object: %1", _camObject];
};

/* ================================================================================ */
