params ["_event", "_params"];

/* ================================================================================ */

if (_event isEqualTo "onInitDialog") exitWith
{
    _params params ["_target", "_screenIndex", "_screenItemIndex", "_selectCtrl", "_resultCtrl"];

    private _dialog = createDialog ["ConfigureScreenMapItemDialog", true];
};

/* ================================================================================ */

if (_event isEqualTo "onSliderPosChangedMapZoom") exitWith
{
    _params params ["_control", "_newValue"];

    private _dialog = ctrlParent _control;

    private _posCtrl = _dialog displayCtrl 4001;
    private _mapCtrl = _dialog displayCtrl 5001;

    private _mapZoom = _newValue;

    private _mapPos = ctrlText _posCtrl;
    if (_mapPos isEqualTo "") then
    {
        _mapPos = getPos player;
    }
    else
    {
        _mapPos = ((ctrlText _control) call BIS_fnc_gridToPos) select 0;
    };

    _mapCtrl ctrlMapAnimAdd [0, _mapZoom, _mapPos];
    ctrlMapAnimCommit _mapCtrl;
};

/* ================================================================================ */

if (_event isEqualTo "onButtonClickMapPos") exitWith
{
    _params params ["_control"];

    private _dialog = ctrlParent _control;

    private _zoomCtrl = _dialog displayCtrl 4002;
    private _mapCtrl = _dialog displayCtrl 5001;

    private _mapZoom = sliderPosition _zoomCtrl;

    private _mapPos = ctrlText _control;
    if (_mapPos isEqualTo "") then
    {
        _mapPos = getPos player;
    }
    else
    {
        _mapPos = ((ctrlText _control) call BIS_fnc_gridToPos) select 0;
    }; 

    _mapCtrl ctrlMapAnimAdd [0, _mapZoom, _mapPos];
    ctrlMapAnimCommit _mapCtrl;
};

/* ================================================================================ */