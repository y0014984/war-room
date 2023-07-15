// runs on init of entity

params ["_screenIndex"];

/* ---------------------------------------- */

private _statement =
{
    params ["_target", "_player", "_params"];
    _params params ["_screenIndex"];

    systemChat format ["Enter presentation mode for Screen %1", _screenIndex];
};

/* ---------------------------------------- */

private _condition =
{
    params ["_target", "_player", "_params"];
    _params params ["_screenIndex"];

    systemChat format ["Screen Index: %1", _screenIndex];

    _target getVariable [format ["WR_screen%1Mutex", _screenIndex], false];
};

/* ---------------------------------------- */

private _screenPresentationAction = 
[
    format ["Screen%1Presentation", _screenIndex], // Action name <STRING>
    "present", // Name of the action shown in the menu <STRING>
    "", // Icon <STRING>
    _statement, // Statement <CODE>
    _condition, // Condition <CODE>
    nil, // Insert children code <CODE> (Optional)
    [_screenIndex], // Action parameters <ANY> (Optional)
    nil, // Position (Position array, Position code or Selection Name) <ARRAY>, <CODE> or <STRING> (Optional)
    nil, // Distance <NUMBER> (Optional)
    nil, // Other parameters [showDisabled,enableInside,canCollapse,runOnHover,doNotCheckLOS] <ARRAY> (Optional)
    nil // Modifier function <CODE> (Optional)
] call ace_interact_menu_fnc_createAction;

/* ---------------------------------------- */

_screenPresentationAction;