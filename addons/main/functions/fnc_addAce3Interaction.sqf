params ["_entity"];

private _statement =
{
    params ["_target", "_player", "_params"];

    private _warRoomMutex = _target getVariable ["WR_mutex", false];

    if (_warRoomMutex) then
    {
        // true means, display is currently enabled, so the display will be disabled
        private _hiddenSelectionIndex = (_target getVariable ["WR_displayHiddenSelections", -1]) select 0;
        [_target, nil] call WR_main_fnc_removeEventHandler;
        //_target setObjectTexture [_hiddenSelectionIndex, "#(rgb,1,1,1)color(0,0,0,1)"]; // site 1x1 with 1 mimap; black with no transparency
        _target setObjectTexture [_hiddenSelectionIndex, "\y\wr\addons\main\ui\WarRoom_DefaultDisplay_1024x1024.paa"];
        _target setVariable ["WR_mutex", false, true];

        hint "War Room Display disabled";
    }
    else 
    {
        // false means, display is currently disabled, so the display will be enabled
        private _hiddenSelectionIndex = (_target getVariable ["WR_displayHiddenSelections", -1]) select 0;
        private _resolution = _target getVariable ["WR_resolution", 256];
        private _uiClass = _target getVariable ["WR_uiClass", "WarRoomDefault"];
        [_target, _hiddenSelectionIndex, _resolution, _uiClass] call WR_main_fnc_initUiOnTex;
        _target setVariable ["WR_mutex", true, true];

        hint "War Room Display enabled";
    };
};

private _condition = 
{
    params ["_target", "_player", "_params"];

    (alive _target) && (_target getVariable ["WR_interactionAllowedGlobal", false]);
};

private _modifier =
{
    params ["_target", "_player", "_params", "_actionData"];

    private _warRoomMutex = _target getVariable ["WR_mutex", false];
    // Modify the action - index 1 is the display name, 2 is the icon...
    if (_warRoomMutex) then { _actionData set [1, "disable display"]; } else { _actionData set [1, "enable display"]; };
};

private _toggleWarRoomDisplayAction = 
[
    "ToggleWarRoomDisplay", // Action name <STRING>
    "Toggle War Room Display", // Name of the action shown in the menu <STRING>
    "", // Icon <STRING>
    _statement, // Statement <CODE>
    _condition, // Condition <CODE>
    nil, // Insert children code <CODE> (Optional)
    [], // Action parameters <ANY> (Optional)
    nil, // Position (Position array, Position code or Selection Name) <ARRAY>, <CODE> or <STRING> (Optional)
    nil, // Distance <NUMBER> (Optional)
    nil, // Other parameters [showDisabled,enableInside,canCollapse,runOnHover,doNotCheckLOS] <ARRAY> (Optional)
    _modifier // Modifier function <CODE> (Optional)
] call ace_interact_menu_fnc_createAction;

private _warRoomAction = 
[
    "WarRoomMain", // Action name <STRING>
    "War Room", // Name of the action shown in the menu <STRING>
    "", // Icon <STRING>
    {}, // Statement <CODE>
    { true; }, // Condition <CODE>
    nil, // Insert children code <CODE> (Optional)
    [], // Action parameters <ANY> (Optional)
    nil, // Position (Position array, Position code or Selection Name) <ARRAY>, <CODE> or <STRING> (Optional)
    nil, // Distance <NUMBER> (Optional)
    nil, // Other parameters [showDisabled,enableInside,canCollapse,runOnHover,doNotCheckLOS] <ARRAY> (Optional)
    nil // Modifier function <CODE> (Optional)
] call ace_interact_menu_fnc_createAction;

private _warRoomActionPath = 
[
    _entity, // Object the action should be assigned to <OBJECT>
    0, // Type of action, 0 for actions, 1 for self-actions <NUMBER>
    ["ACE_MainActions"], // Parent path of the new action <ARRAY> (Example: `["ACE_SelfActions", "ACE_Equipment"]`)
    _warRoomAction // Action <ARRAY>
] call ace_interact_menu_fnc_addActionToObject;

[
    _entity, // Object the action should be assigned to <OBJECT>
    0, // Type of action, 0 for actions, 1 for self-actions <NUMBER>
    _warRoomActionPath, // Parent path of the new action <ARRAY> (Example: `["ACE_SelfActions", "ACE_Equipment"]`)
    _toggleWarRoomDisplayAction // Action <ARRAY>
] call ace_interact_menu_fnc_addActionToObject;