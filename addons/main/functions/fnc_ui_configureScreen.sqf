params ["_event", "_params"];

/* ================================================================================ */

if (_event isEqualTo "onInitDisplay") exitWith
{
    _params params ["_target", "_screenIndex"];

    private _dialog = createDialog ["ConfigureScreenDialog"];

    _dialog setVariable ["WR_target", _target];
    _dialog setVariable ["WR_screenIndex", _screenIndex];

    private _horiResIndex = _target getVariable ["WR_horiResScreen%1", 2]; // 2 = 1024
    private _vertResIndex = _target getVariable ["WR_vertResScreen%1", 2]; // 2 = 1024

    private _horiResCtrl = _dialog displayCtrl 4001;
    private _vertResCtrl = _dialog displayCtrl 4002;

    _horiResCtrl lbSetCurSel _horiResIndex;
    _vertResCtrl lbSetCurSel _vertResIndex;

    private _layoutIndex = _target getVariable ["WR_layoutScreen%1", 0];

    private _layoutCtrl = _dialog displayCtrl 4003;

    _layoutCtrl lbSetCurSel _layoutIndex;

    systemChat format ["Opened Dialog to configure Screen %1", _screenIndex];
};

/* ================================================================================ */

if (_event isEqualTo "onUnloadDisplay") exitWith
{
    _params params ["_dialog", "_exitCode"];
    // ok = 1, cancel = 2

    private _messageFnc = { params ["_screenIndex", "_exitCode"]; systemChat format ["Closed Dialog to configure Screen %1 with exit code %2", _screenIndex, _exitCode]; };

    if (_exitCode == 2) exitWith { [_screenIndex, _exitCode] call _messageFnc; };

    private _target = _dialog getVariable ["WR_target", objNull];
    private _screenIndex = _dialog getVariable ["WR_screenIndex", 0];

    private _horiResCtrl = _dialog displayCtrl 4001;
    private _vertResCtrl = _dialog displayCtrl 4002;

    private _horiResIndex = lbCurSel _horiResCtrl;
    private _vertResIndex = lbCurSel _vertResCtrl;

    _target setVariable ["WR_horiResScreen%1", _horiResIndex];
    _target setVariable ["WR_vertResScreen%1", _vertResIndex];

    private _horizontalResolution = _horiResCtrl lbValue _horiResIndex;
    private _verticalResolution = _vertResCtrl lbValue _vertResIndex;

    private _layoutCtrl = _dialog displayCtrl 4003;

    private _layoutIndex = lbCurSel _layoutCtrl;

    _target setVariable ["WR_layoutScreen%1", _layoutIndex];

    private _layout = _layoutCtrl lbData _layoutIndex;

    [_target, _screenIndex, _horizontalResolution, _verticalResolution, _layout] spawn WR_main_fnc_updateScreen;

    [_screenIndex, _exitCode] call _messageFnc;
};

/* ================================================================================ */

if (_event isEqualTo "onLBSelChangedLayout") exitWith
{
    _params params ["_control", "_lbCurSel", "_lbSelection"];

    private _layout = _control lbData _lbCurSel;

    private _imagePath = format ["\y\wr\addons\main\ui\WarRoom_Layouts_%1_1024x1024.paa", _layout];

    private _dialog = ctrlParent _control;

    private _layoutImageCtrl = _dialog displayCtrl 5001;

    _layoutImageCtrl ctrlSetText _imagePath;

    systemChat format ["Changed Layout to image path: %1", _imagePath];
};

/* ================================================================================ */
