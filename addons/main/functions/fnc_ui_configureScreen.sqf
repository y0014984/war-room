params ["_event", "_params"];

/* ================================================================================ */

if (_event isEqualTo "onInitDisplay") exitWith
{
    _params params ["_target", "_screenIndex"];

    private _dialog = createDialog ["ConfigureScreenDialog"];

    _dialog setVariable ["WR_target", _target];
    _dialog setVariable ["WR_screenIndex", _screenIndex];

    private _horizontalResolution = _target getVariable [format ["WR_horizontalResolutionScreen%1", _screenIndex], WR_defaultScreenResolution];
    private _verticalResolution = _target getVariable [format ["WR_verticalResolutionScreen%1", _screenIndex], WR_defaultScreenResolution];
    private _resolutionToIndex = createHashMapFromArray [["256", 0], ["512", 1], ["1024", 2], ["2048", 3], ["4096", 4]];
    private _horiResIndex = _resolutionToIndex get (str _horizontalResolution);
    private _vertResIndex = _resolutionToIndex get (str _verticalResolution);

    private _horiResCtrl = _dialog displayCtrl 4001;
    private _vertResCtrl = _dialog displayCtrl 4002;

    _horiResCtrl lbSetCurSel _horiResIndex;
    _vertResCtrl lbSetCurSel _vertResIndex;

    private _layout = _target getVariable [format ["WR_uiClassScreen%1", _screenIndex], 1];
    private _layoutToIndex = createHashMapFromArray [["WarRoom1", 0], ["WarRoom5", 1]];
    private _layoutIndex = _layoutToIndex get _layout;

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

    private _indexToResolution = createHashMapFromArray [["0", 256], ["1", 512], ["2", 1024], ["3", 2048], ["4", 4096]];
    private _horizontalResolution = _indexToResolution get (str _horiResIndex);
    private _verticalResolution = _indexToResolution get (str _vertResIndex);
    _target setVariable [format ["WR_horizontalResolutionScreen%1", _screenIndex], _horizontalResolution];
    _target setVariable [format ["WR_verticalResolutionScreen%1", _screenIndex], _verticalResolution];

    private _layoutCtrl = _dialog displayCtrl 4003;

    private _layoutIndex = lbCurSel _layoutCtrl;

    private _indexToLayout = createHashMapFromArray [["0", "WarRoom1"], ["1", "WarRoom5"]];
    private _layout = _indexToLayout get (str _layoutIndex);
    _target setVariable [format ["WR_uiClassScreen%1", _screenIndex], _layout];

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
