params ["_event", "_params"];

/* ================================================================================ */

if (_event isEqualTo "onInitDialog") exitWith
{
    _params params ["_entity", "_screenIndex"];

    /* ---------------------------------------- */

    private _dialog = createDialog ["ConfigureScreenDialog"];

    _dialog setVariable ["WR_entity", _entity];
    _dialog setVariable ["WR_screenIndex", _screenIndex];

    /* ---------------------------------------- */

    private _warRoomName = _entity getVariable [format ["WR_warRoomName%1", _screenIndex], "Operation Unknown"];

    private _warRoomNameCtrl = _dialog displayCtrl 4000;

    _warRoomNameCtrl ctrlSetText _warRoomName;

    /* ---------------------------------------- */


    private _horizontalResolution = _entity getVariable [format ["WR_horizontalResolutionScreen%1", _screenIndex], WR_defaultScreenResolution];
    private _verticalResolution = _entity getVariable [format ["WR_verticalResolutionScreen%1", _screenIndex], WR_defaultScreenResolution];
    private _resolutionToIndex = createHashMapFromArray [["256", 0], ["512", 1], ["1024", 2], ["2048", 3], ["4096", 4]];
    private _horiResIndex = _resolutionToIndex get (str _horizontalResolution);
    private _vertResIndex = _resolutionToIndex get (str _verticalResolution);

    private _horiResCtrl = _dialog displayCtrl 4001;
    private _vertResCtrl = _dialog displayCtrl 4002;

    _horiResCtrl lbSetCurSel _horiResIndex;
    _vertResCtrl lbSetCurSel _vertResIndex;

    /* ---------------------------------------- */

    private _fps = _entity getVariable [format ["WR_fpsScreen%1", _screenIndex], WR_defaultScreenFps];
    private _fpsToIndex = createHashMapFromArray [["1", 0], ["2", 1], ["3", 2], ["4", 3], ["5", 4], ["10", 5], ["20", 6], ["30", 7], ["45", 8], ["60", 9]];
    private _fpsIndex = _fpsToIndex get (str _fps);

    private _fpsCtrl = _dialog displayCtrl 4003;

    _fpsCtrl lbSetCurSel _fpsIndex;

    /* ---------------------------------------- */

    private _screens = _entity getVariable ["WR_screens", []];
    private _screen = _screens select _screenIndex;
    private _allowedUiClasses = _screen select 1; // [_hiddenSelection, _allowedUiClasses, _defaultUiClass, _uiScreenItemCount];
    private _defaultUiClass = _screen select 2;

    private _layoutCtrl = _dialog displayCtrl 4004;

    private _layoutToIndexArray = [];
    private _indexToLayoutArray = [];
    {
        private _index = _layoutCtrl lbAdd _x;
        _layoutToIndexArray pushBack [_x, _index];
        _indexToLayoutArray pushBack [str _index, _x];
    } forEach _allowedUiClasses;

    private _layoutToIndex = createHashMapFromArray _layoutToIndexArray;
    private _indexToLayout = createHashMapFromArray _indexToLayoutArray;

    _layoutCtrl setVariable ["WR_indexToLayout", _indexToLayout];

    private _layout = _entity getVariable [format ["WR_uiClassScreen%1", _screenIndex], _defaultUiClass];
    private _layoutIndex = _layoutToIndex get _layout;

    _layoutCtrl setVariable ["WR_ctrlInitialised", true];

    _layoutCtrl lbSetCurSel _layoutIndex;

    /* ---------------------------------------- */

    private _uiClassCfg = configFile >> _layout;
    private _uiScreenItemCount = (_uiClassCfg >> "WR_uiScreenItemCount") call BIS_fnc_getCfgData;

    for [{ private _i = 0 }, { _i < 8 }, { _i = _i + 1 }] do
    {
        private _itemLabelCtrl = _dialog displayCtrl (3005 + _i);
        private _itemCtrl = _dialog displayCtrl (4005 + _i);
        private _itemResultCtrl = _dialog displayCtrl (5005 + _i);

        private _state = false;
        if (_i < _uiScreenItemCount) then { _state = true; } else { _state = false; };

        _itemLabelCtrl ctrlShow _state;
        _itemCtrl ctrlShow _state;
        _itemResultCtrl ctrlShow _state;
    };

    /* ---------------------------------------- */

    for [{ private _i = 0 }, { _i < 8 }, { _i = _i + 1 }] do
    {
        private _screenItemType = _entity getVariable [format ["WR_screen%1Item%2Type", _screenIndex, _i], ""];
        private _screenItemContent = _entity getVariable [format ["WR_screen%1Item%2Content", _screenIndex, _i], nil];

        private _itemCtrl = _dialog displayCtrl (4005 + _i);
        private _itemResultCtrl = _dialog displayCtrl (5005 + _i);

        if (!(_screenItemType isEqualTo "")) then
        {
            if (_screenItemType isEqualTo "IMAGE") then { _itemCtrl lbSetCurSel 1; };
            if (_screenItemType isEqualTo "MAP") then { _itemCtrl lbSetCurSel 2; };

            _itemResultCtrl ctrlSetText format ["%1 - %2", _screenItemType, _screenItemContent];
        };

        _itemCtrl setVariable ["WR_ctrlInitialised", true];
    };

    /* ---------------------------------------- */

    systemChat format ["Opened Dialog to configure Screen %1", _screenIndex];
};

/* ================================================================================ */

if (_event isEqualTo "onUnloadDialog") exitWith
{
    _params params ["_dialog", "_exitCode"];
    // ok = 1, cancel = 2

    private _messageFnc = { params ["_screenIndex", "_exitCode"]; systemChat format ["Closed Dialog to configure Screen %1 with exit code %2", _screenIndex, _exitCode]; };

    if (_exitCode == 2) exitWith { [_screenIndex, _exitCode] call _messageFnc; };

    private _entity = _dialog getVariable ["WR_entity", objNull];
    private _screenIndex = _dialog getVariable ["WR_screenIndex", 0];

    /* ---------------------------------------- */

    private _warRoomNameCtrl = _dialog displayCtrl 4000;

    private _warRoomName = ctrlText _warRoomNameCtrl;

    _entity setVariable [format ["WR_warRoomName%1", _screenIndex], _warRoomName, true];

    /* ---------------------------------------- */

    private _horiResCtrl = _dialog displayCtrl 4001;
    private _vertResCtrl = _dialog displayCtrl 4002;

    private _horiResIndex = lbCurSel _horiResCtrl;
    private _vertResIndex = lbCurSel _vertResCtrl;

    private _indexToResolution = createHashMapFromArray [["0", 256], ["1", 512], ["2", 1024], ["3", 2048], ["4", 4096]];
    private _horizontalResolution = _indexToResolution get (str _horiResIndex);
    private _verticalResolution = _indexToResolution get (str _vertResIndex);
    _entity setVariable [format ["WR_horizontalResolutionScreen%1", _screenIndex], _horizontalResolution];
    _entity setVariable [format ["WR_verticalResolutionScreen%1", _screenIndex], _verticalResolution];

    /* ---------------------------------------- */

    private _fpsCtrl = _dialog displayCtrl 4003;

    private _fpsIndex = lbCurSel _fpsCtrl;

    private _indexToFps = createHashMapFromArray [["0", 1], ["1", 2], ["2", 3], ["3", 4], ["4", 5], ["5", 10], ["6", 20], ["7", 30], ["8", 45], ["9", 60]];
    private _fps = _indexToFps get (str _fpsIndex);
    _entity setVariable [format ["WR_fpsScreen%1", _screenIndex], _fps];

    /* ---------------------------------------- */

    private _layoutCtrl = _dialog displayCtrl 4004;

    private _layoutIndex = lbCurSel _layoutCtrl;

    private _indexToLayout = _layoutCtrl getVariable ["WR_indexToLayout", createHashMap];
    private _layout = _indexToLayout get (str _layoutIndex);
    _entity setVariable [format ["WR_uiClassScreen%1", _screenIndex], _layout, true];

    /* ---------------------------------------- */

    // needs to be 0 (everywhere) instead of -2 (all clients, not server), because of hosted multiplayer
    // host also needs to be able to use the interactions
    [_entity, _screenIndex, _horizontalResolution, _verticalResolution, _fps, _layout] remoteExec ["WR_main_fnc_updateScreen", 0, true];

    [_screenIndex, _exitCode] call _messageFnc;
};

/* ================================================================================ */

if (_event isEqualTo "onLBSelChangedLayout") exitWith
{
    _params params ["_control", "_lbCurSel", "_lbSelection"];

    private _ctrlInitialised = _control getVariable ["WR_ctrlInitialised", false];
    if (!_ctrlInitialised) exitWith {};

    private _layout = _control lbText _lbCurSel;

    private _imagePath = format ["\y\wr\addons\main\ui\WarRoom_Layouts_%1_1024x1024.paa", _layout];

    private _dialog = ctrlParent _control;

    private _layoutImageCtrl = _dialog displayCtrl 5001;

    _layoutImageCtrl ctrlSetText _imagePath;

    private _uiClassCfg = configFile >> _layout;
    private _uiScreenItemCount = (_uiClassCfg >> "WR_uiScreenItemCount") call BIS_fnc_getCfgData;

    for [{ private _i = 0 }, { _i < 8 }, { _i = _i + 1 }] do
    {
        private _itemLabelCtrl = _dialog displayCtrl (3005 + _i);
        private _itemCtrl = _dialog displayCtrl (4005 + _i);
        private _itemResultCtrl = _dialog displayCtrl (5005 + _i);

        private _state = false;
        if (_i < _uiScreenItemCount) then { _state = true; } else { _state = false; };

        _itemLabelCtrl ctrlShow _state;
        _itemCtrl ctrlShow _state;
        _itemResultCtrl ctrlShow _state;
    };

    systemChat format ["Changed Layout to image path: %1", _imagePath];
};

/* ================================================================================ */

if (_event isEqualTo "onLBSelChangedItem") exitWith
{
    _params params ["_control", "_lbCurSel", "_lbSelection"];

    private _ctrlInitialised = _control getVariable ["WR_ctrlInitialised", false];
    if (!_ctrlInitialised) exitWith {};

    private _screenItemCfg = configFile >> "ConfigureScreenDialog" >> "controls" >> ctrlClassName _control;
    if (!isClass _screenItemCfg) exitWith {};

    private _dialog = ctrlParent _control;

    private _entity = _dialog getVariable ["WR_entity", objNull];
    private _screenIndex = _dialog getVariable ["WR_screenIndex", 0];

    private _screenItemIndex = (_screenItemCfg >> "WR_screenItemIndex") call BIS_fnc_getCfgData;

    private _resultCtrl = _dialog displayCtrl ((ctrlIDC _control) + 1000);

    if (_lbCurSel == 0) then 
    {
        _entity setVariable [format ["WR_screen%1Item%2Type", _screenIndex, _screenItemIndex], nil, true];
        _entity setVariable [format ["WR_screen%1Item%2Content", _screenIndex, _screenItemIndex], nil, true];
        _resultCtrl ctrlSetText "";
    };

    // 1 == image
    if (_lbCurSel == 1) then { ["onInitDialog", [_entity, _screenIndex, _screenItemIndex, _resultCtrl]] call WR_main_fnc_ui_configureScreenImageItem; };
    // 2 == map
    if (_lbCurSel == 2) then { ["onInitDialog", [_entity, _screenIndex, _screenItemIndex, _resultCtrl]] call WR_main_fnc_ui_configureScreenMapItem; };
    // 3 == drone cam
    if (_lbCurSel == 3) then { ["onInitDialog", [_entity, _screenIndex, _screenItemIndex, _resultCtrl]] call WR_main_fnc_ui_configureScreenCamItem; };

    systemChat format ["Changed item %1 to item type: %2", _screenItemIndex, _lbCurSel];
};

/* ================================================================================ */