params ["_entity"];

/* ================================================================================ */

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
        [_target] call WR_main_fnc_removeUpdateUiOnTexEventHandler;
        [_target] call WR_main_fnc_terminateUiOnTex;
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
        [_target] call WR_main_fnc_addUpdateUiOnTexEventHandler;
        _target setVariable ["WR_mutex", true, true];

        hint "War Room Display enabled";
    };
};

/* ---------------------------------------- */

private _modifier =
{
    params ["_target", "_player", "_params", "_actionData"];

    private _warRoomMutex = _target getVariable ["WR_mutex", false];
    // Modify the action - index 1 is the display name, 2 is the icon...
    if (_warRoomMutex) then { _actionData set [1, "disable Display"]; } else { _actionData set [1, "enable Display"]; };
};

/* ---------------------------------------- */

private _toggleWarRoomDisplayAction = 
[
    "ToggleWarRoomDisplay", // Action name <STRING>
    "Toggle War Room Display", // Name of the action shown in the menu <STRING>
    "", // Icon <STRING>
    _statement, // Statement <CODE>
    { true; }, // Condition <CODE>
    nil, // Insert children code <CODE> (Optional)
    [], // Action parameters <ANY> (Optional)
    nil, // Position (Position array, Position code or Selection Name) <ARRAY>, <CODE> or <STRING> (Optional)
    nil, // Distance <NUMBER> (Optional)
    nil, // Other parameters [showDisabled,enableInside,canCollapse,runOnHover,doNotCheckLOS] <ARRAY> (Optional)
    _modifier // Modifier function <CODE> (Optional)
] call ace_interact_menu_fnc_createAction;

/* ================================================================================ */

private _insertChildren =
{
    params ["_target", "_player", "_params"];

    private _uiPlaceholderCount = _target getVariable ["WR_uiPlaceholderCount", false];
    // Add children to action
    private _actions = [];
    for "_i" from 1 to _uiPlaceholderCount do
    { 
        private _statement =
        {
            params ["_target", "_player", "_params"];
            _params params ["_placeholderIndex"];

            private _placeholderMutex = _target getVariable [format ["WR_placeholder%1Mutex", _placeholderIndex], false];
            if (_placeholderMutex) then
            {
                // true means, placeholder is currently enabled, so the placeholder will be disabled
                systemChat format ["reset %1", _placeholderIndex];
                [_target, _placeholderIndex] call WR_main_fnc_removeNewControlOnPlaceholder;
                _target setVariable [format ["WR_placeholder%1Mutex", _placeholderIndex], false, true];
            }
            else
            {
                // false means, placeholder is currently disabled, so the placeholder will be enabled
                systemChat format ["setup %1", _placeholderIndex];
                [_target, _placeholderIndex] call WR_main_fnc_setupNewControlOnPlaceholder;
                _target setVariable [format ["WR_placeholder%1Mutex", _placeholderIndex], true, true];
            };
        };
        private _condition =
        {
            params ["_target", "_player", "_params"];

            (_target getVariable ["WR_mutex", false]);
        };
        private _modifier =
        {
            params ["_target", "_player", "_params", "_actionData"];
            _params params ["_placeholderIndex"];

            private _placeholderMutex = _target getVariable [format ["WR_placeholder%1Mutex", _placeholderIndex], false];
            // Modify the action - index 1 is the display name, 2 is the icon...
            if (_placeholderMutex) then { _actionData set [1, format ["reset Placeholder %1", _placeholderIndex]]; } else { _actionData set [1, format ["setup Placeholder %1", _placeholderIndex]]; };
        };
        private _action = [format ["TogglePlaceholder%1", _i], format ["Toggle Placeholder %1", _i], "", _statement, _condition, nil, _i, nil, nil, nil, _modifier] call ace_interact_menu_fnc_createAction;
        _actions pushBack [_action, [], _target]; // New action, it's children, and the action's target
    };

    _actions
};

/* ---------------------------------------- */

private _condition = 
{
    params ["_target", "_player", "_params"];

    (alive _target) && (_target getVariable ["WR_interactionAllowedGlobal", false]);
};

/* ---------------------------------------- */

private _warRoomAction = 
[
    "WarRoomMain", // Action name <STRING>
    "War Room", // Name of the action shown in the menu <STRING>
    "", // Icon <STRING>
    {}, // Statement <CODE>
    _condition, // Condition <CODE>
    _insertChildren, // Insert children code <CODE> (Optional)
    [], // Action parameters <ANY> (Optional)
    nil, // Position (Position array, Position code or Selection Name) <ARRAY>, <CODE> or <STRING> (Optional)
    nil, // Distance <NUMBER> (Optional)
    nil, // Other parameters [showDisabled,enableInside,canCollapse,runOnHover,doNotCheckLOS] <ARRAY> (Optional)
    nil // Modifier function <CODE> (Optional)
] call ace_interact_menu_fnc_createAction;

/* ================================================================================ */

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

/* ================================================================================ */