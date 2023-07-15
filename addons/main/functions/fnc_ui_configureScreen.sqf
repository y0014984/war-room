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

    private _fps = _target getVariable [format ["WR_fpsScreen%1", _screenIndex], WR_defaultScreenFps];
    private _fpsToIndex = createHashMapFromArray [["1", 0], ["2", 1], ["3", 2], ["4", 3], ["5", 4], ["10", 5], ["20", 6], ["30", 7], ["45", 8], ["60", 9]];
    private _fpsIndex = _fpsToIndex get (str _fps);

    private _fpsCtrl = _dialog displayCtrl 4003;

    _fpsCtrl lbSetCurSel _fpsIndex;

    private _layout = _target getVariable [format ["WR_uiClassScreen%1", _screenIndex], 1];
    private _layoutToIndex = createHashMapFromArray [["WarRoom1", 0], ["WarRoom5", 1]];
    private _layoutIndex = _layoutToIndex get _layout;

    private _layoutCtrl = _dialog displayCtrl 4004;

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

    private _fpsCtrl = _dialog displayCtrl 4003;

    private _fpsIndex = lbCurSel _fpsCtrl;

    private _indexToFps = createHashMapFromArray [["0", 1], ["1", 2], ["2", 3], ["3", 4], ["4", 5], ["5", 10], ["6", 20], ["7", 30], ["8", 45], ["9", 60]];
    private _fps = _indexToFps get (str _fpsIndex);
    _target setVariable [format ["WR_fpsScreen%1", _screenIndex], _fps];

    private _layoutCtrl = _dialog displayCtrl 4004;

    private _layoutIndex = lbCurSel _layoutCtrl;

    private _indexToLayout = createHashMapFromArray [["0", "WarRoom1"], ["1", "WarRoom5"]];
    private _layout = _indexToLayout get (str _layoutIndex);
    _target setVariable [format ["WR_uiClassScreen%1", _screenIndex], _layout];

    [_target, _screenIndex, _horizontalResolution, _verticalResolution, _fps, _layout] spawn WR_main_fnc_updateScreen;

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

if (_event isEqualTo "onLBSelChangedItem") exitWith
{
    _params params ["_control", "_lbCurSel", "_lbSelection"];

    private _itemCfg = configFile >> "ConfigureScreenDialog" >> "controls" >> ctrlClassName _control;
    if (!isClass _itemCfg) exitWith {};

    private _itemIndex = (_itemCfg >> "WR_itemIndex") call BIS_fnc_getCfgData;

    systemChat format ["Changed item %1 to item type: %2", _itemIndex, _lbCurSel];
};

/* ================================================================================ */