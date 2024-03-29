// runs on init of entity

params ["_hiddenSelection", "_screenIndex"];

/* ---------------------------------------- */

private _statement =
{
    params ["_entity", "_player", "_params"];
    _params params ["_hiddenSelection", "_screenIndex"];

    private _screenMutex = _entity getVariable [format ["WR_screen%1Mutex", _screenIndex], false];

    if (_screenMutex) then
    {
        // true means, display is currently enabled, so the display will be disabled
        [_entity, _hiddenSelection, _screenIndex] spawn WR_main_fnc_terminateUiOnTex;
        _entity setVariable [format ["WR_screen%1Mutex", _screenIndex], false, true];

        systemChat format ["Screen %1 disabled", _screenIndex];
    }
    else 
    {
        // false means, display is currently disabled, so the display will be enabled
        private _horizontalResolution = _entity getVariable [format ["WR_horizontalResolutionScreen%1", _screenIndex], WR_defaultScreenResolution];
        private _verticalResolution = _entity getVariable [format ["WR_verticalResolutionScreen%1", _screenIndex], WR_defaultScreenResolution];
        private _fps = _entity getVariable [format ["WR_fpsScreen%1", _screenIndex], WR_defaultScreenFps];
        private _uiClass = _entity getVariable [format ["WR_uiClassScreen%1", _screenIndex], ""];
        if (_uiClass isEqualTo "") then
        {
            private _screens = _entity getVariable ["WR_screens", []];
            private _allowedUiClasses = (_screens select _screenIndex) select 1;
            private _defaultUiClass = (_screens select _screenIndex) select 2;
            _uiClass = _allowedUiClasses select _defaultUiClass;
        };
        // needs to be 0 (everywhere) instead of -2 (all clients, not server), because of hosted multiplayer
        // host also needs to be able to use the interactions
        [_entity, _hiddenSelection, _screenIndex, _horizontalResolution, _verticalResolution, _fps, _uiClass] remoteExec ["WR_main_fnc_initUiOnTex", 0, true];
        _entity setVariable [format ["WR_screen%1Mutex", _screenIndex], true, true];

        systemChat format ["Screen %1 enabled", _screenIndex];
    };
};

/* ---------------------------------------- */

private _modifier =
{
    params ["_entity", "_player", "_params", "_actionData"];
    _params params ["_hiddenSelection", "_screenIndex"];

    private _screenMutex = _entity getVariable [format ["WR_screen%1Mutex", _screenIndex], false];
    // Modify the action - index 1 is the display name, 2 is the icon...
    if (_screenMutex) then { _actionData set [1, "disable"]; } else { _actionData set [1, "enable"]; };
};

/* ---------------------------------------- */

private _screenToggleAction = 
[
    format ["Screen%1Toggle", _screenIndex], // Action name <STRING>
    format ["Screen %1 Toggle", _screenIndex], // Name of the action shown in the menu <STRING>
    "", // Icon <STRING>
    _statement, // Statement <CODE>
    { true; }, // Condition <CODE>
    nil, // Insert children code <CODE> (Optional)
    [_hiddenSelection, _screenIndex], // Action parameters <ANY> (Optional)
    nil, // Position (Position array, Position code or Selection Name) <ARRAY>, <CODE> or <STRING> (Optional)
    nil, // Distance <NUMBER> (Optional)
    nil, // Other parameters [showDisabled,enableInside,canCollapse,runOnHover,doNotCheckLOS] <ARRAY> (Optional)
    _modifier // Modifier function <CODE> (Optional)
] call ace_interact_menu_fnc_createAction;

/* ---------------------------------------- */

_screenToggleAction;