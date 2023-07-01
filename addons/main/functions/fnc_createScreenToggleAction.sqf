// runs on init of entity

params ["_hiddenSelection", "_screenIndex"];

/* ---------------------------------------- */

private _statement =
{
    params ["_target", "_player", "_params"];
    _params params ["_hiddenSelection", "_screenIndex"];

    private _screenMutex = _target getVariable [format ["WR_screen%1Mutex", _screenIndex], false];

    if (_screenMutex) then
    {
        // true means, display is currently enabled, so the display will be disabled
        [_target, _screenIndex] call WR_main_fnc_removeUpdateUiOnTexEventHandler;
        [_target, _hiddenSelection, _screenIndex] call WR_main_fnc_terminateUiOnTex;
        _target setVariable [format ["WR_screen%1Mutex", _screenIndex], false, true];

        systemChat format ["Screen %1 disabled", _screenIndex];
    }
    else 
    {
        // false means, display is currently disabled, so the display will be enabled
        private _resolution = _target getVariable ["WR_resolution", 256];
        private _uiClasses = _target getVariable ["WR_uiClasses", []];
        [_target, _hiddenSelection, _screenIndex, _resolution, _uiClasses select _screenIndex] call WR_main_fnc_initUiOnTex;
        [_target, _screenIndex] call WR_main_fnc_addUpdateUiOnTexEventHandler;
        _target setVariable [format ["WR_screen%1Mutex", _screenIndex], true, true];

        systemChat format ["Screen %1 enabled", _screenIndex];
    };
};

/* ---------------------------------------- */

private _modifier =
{
    params ["_target", "_player", "_params", "_actionData"];
    _params params ["_hiddenSelection", "_screenIndex"];

    private _screenMutex = _target getVariable [format ["WR_screen%1Mutex", _screenIndex], false];
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