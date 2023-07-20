params ["_event", "_params"];

/* ================================================================================ */

private _updateMapValuesFnc =
{
    params ["_dialog"];

    private _posCtrl = _dialog displayCtrl 4001;
    private _zoomCtrl = _dialog displayCtrl 4002;
    private _mapCtrl = _dialog displayCtrl 5001;

    private _mapSize = ctrlMapPosition _mapCtrl;
    private _mapCenterScreenPos = [(_mapSize select 0) + ((_mapSize select 2) / 2), (_mapSize select 1) + ((_mapSize select 3) / 2)];
    private _mapCenterWorldPos = _mapCtrl ctrlMapScreenToWorld _mapCenterScreenPos;
    private _mapScale = ctrlMapScale _mapCtrl;

    _posCtrl ctrlSetText format ["%1", _mapCenterWorldPos];
    _zoomCtrl sliderSetPosition _mapScale;

    _dialog setVariable ["WR_screenItemType", "MAP"];
    _dialog setVariable ["WR_screenItemContent", [_mapCenterWorldPos, _mapScale]];

    systemChat format ["Changed map item to pos: %1 and scale: %2", _mapCenterWorldPos, _mapScale];
};


/* ================================================================================ */

if (_event isEqualTo "onInitDialog") exitWith
{
    _params params ["_target", "_screenIndex", "_screenItemIndex", "_selectCtrl", "_resultCtrl"];

    private _dialog = createDialog ["ConfigureScreenMapItemDialog", true];

    _dialog setVariable ["WR_target", _target];
    _dialog setVariable ["WR_screenIndex", _screenIndex];
    _dialog setVariable ["WR_screenItemIndex", _screenItemIndex];
    _dialog setVariable ["WR_selectCtrl", _selectCtrl];
    _dialog setVariable ["WR_resultCtrl", _resultCtrl];

    [_dialog] call _updateMapValuesFnc;
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

    _resultCtrl ctrlSetText format ["%1: %2", _screenItemType, _screenItemContent];
};

/* ================================================================================ */

if (_event isEqualTo "onSliderPosChangedMapZoom") exitWith
{
    _params params ["_control", "_newValue"];

    private _dialog = ctrlParent _control;

    private _mapCtrl = _dialog displayCtrl 5001;

    private _screenItemContent = _dialog getVariable ["WR_screenItemContent", []];
    _screenItemContent params ["_mapCenterWorldPos", "_mapScale"];

    _mapScale = _newValue;

    _mapCtrl ctrlMapAnimAdd [0, _mapScale, _mapCenterWorldPos];
    ctrlMapAnimCommit _mapCtrl;

    hintSilent format ["_mapCtrl: %1\n_mapScale: %2\n_mapCenterWorldPos: %3", _mapCtrl, _mapScale, _mapCenterWorldPos];
};

/* ================================================================================ */

if (_event isEqualTo "onMouseButtonUpMap") exitWith
{
    _params params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

    private _dialog = ctrlParent _control;

    [_dialog] call _updateMapValuesFnc;
};

/* ================================================================================ */

if (_event isEqualTo "onMouseZChangedMap") exitWith
{
    _params params ["_control", "_scroll"];
    
    private _dialog = ctrlParent _control;

    [_dialog] call _updateMapValuesFnc;
};

/* ================================================================================ */