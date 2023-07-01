// runs on init of entity

params ["_screenIndex"];

/* ---------------------------------------- */

// For only hirarchical items, statement is needed; otherwise the item doesn't show up

private _screenAction = 
[
    format ["Screen%1", _screenIndex], // Action name <STRING>
    format ["Screen %1", _screenIndex], // Name of the action shown in the menu <STRING>
    "", // Icon <STRING>
    { true; }, // Statement <CODE>
    { true; }, // Condition <CODE>
    nil, // Insert children code <CODE> (Optional)
    [], // Action parameters <ANY> (Optional)
    nil, // Position (Position array, Position code or Selection Name) <ARRAY>, <CODE> or <STRING> (Optional)
    nil, // Distance <NUMBER> (Optional)
    nil, // Other parameters [showDisabled,enableInside,canCollapse,runOnHover,doNotCheckLOS] <ARRAY> (Optional)
    nil // Modifier function <CODE> (Optional)
] call ace_interact_menu_fnc_createAction;

/* ---------------------------------------- */

_screenAction;