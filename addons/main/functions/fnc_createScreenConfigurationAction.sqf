// runs on init of entity

params ["_screenIndex"];

/* ---------------------------------------- */

private _statement =
{
    params ["_entity", "_player", "_params"];
    _params params ["_screenIndex"];

    ["onInitDialog", [_entity, _screenIndex]] call WR_main_fnc_ui_configureScreen;
};

/* ---------------------------------------- */

private _condition =
{
    params ["_entity", "_player", "_params"];
    _params params ["_screenIndex"];

    _entity getVariable [format ["WR_screen%1Mutex", _screenIndex], false];
};

/* ---------------------------------------- */

private _screenConfigurationAction = 
[
    format ["Screen%1Configuration", _screenIndex], // Action name <STRING>
    "configure", // Name of the action shown in the menu <STRING>
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

_screenConfigurationAction;