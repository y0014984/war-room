// runs on init of entity

/* ---------------------------------------- */

private _condition = 
{
    params ["_target", "_player", "_params"];

    (alive _target) && (_target getVariable ["WR_interactionAllowedGlobal", false]);
};

/* ---------------------------------------- */

// For only hirarchical items, statement is needed; otherwise the item doesn't show up

private _warRoomAction = 
[
    "WarRoom", // Action name <STRING>
    "War Room", // Name of the action shown in the menu <STRING>
    "", // Icon <STRING>
    { true; }, // Statement <CODE>
    _condition, // Condition <CODE>
    nil, // Insert children code <CODE> (Optional)
    [], // Action parameters <ANY> (Optional)
    nil, // Position (Position array, Position code or Selection Name) <ARRAY>, <CODE> or <STRING> (Optional)
    nil, // Distance <NUMBER> (Optional)
    nil, // Other parameters [showDisabled,enableInside,canCollapse,runOnHover,doNotCheckLOS] <ARRAY> (Optional)
    nil // Modifier function <CODE> (Optional)
] call ace_interact_menu_fnc_createAction;

/* ---------------------------------------- */

_warRoomAction;