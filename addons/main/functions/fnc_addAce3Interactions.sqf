// runs on init of entity

params ["_entity"];

/* ================================================================================ */

/* private _insertChildren =
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
}; */

// private _screenAction = [_insertChildren] call WR_main_fnc_createscreenAction;

/* ================================================================================ */

// create war room action
private _warRoomAction = [] call WR_main_fnc_createWarRoomAction;

/* ================================================================================ */

// add war room action to entity
private _warRoomActionPath = 
[
    _entity, // Object the action should be assigned to <OBJECT>
    0, // Type of action, 0 for actions, 1 for self-actions <NUMBER>
    ["ACE_MainActions"], // Parent path of the new action <ARRAY> (Example: `["ACE_SelfActions", "ACE_Equipment"]`)
    _warRoomAction // Action <ARRAY>
] call ace_interact_menu_fnc_addActionToObject;

/* ================================================================================ */

private _screenHiddenSelections = _entity getVariable ["WR_screenHiddenSelections", []];
{
    // create screen actions based on screen hidden selections count
    private _screenAction = [_forEachIndex] call WR_main_fnc_createScreenAction;
    
    /* ---------------------------------------- */

    // add screen actions to entity
    private _screenActionPath =
    [
        _entity, // Object the action should be assigned to <OBJECT>
        0, // Type of action, 0 for actions, 1 for self-actions <NUMBER>
        _warRoomActionPath, // Parent path of the new action <ARRAY> (Example: `["ACE_SelfActions", "ACE_Equipment"]`)
        _screenAction // Action <ARRAY>
    ] call ace_interact_menu_fnc_addActionToObject;

    /* ---------------------------------------- */

    // create screen toggle action
    private _screenToggleAction = [_x, _forEachIndex] call WR_main_fnc_createScreenToggleAction;

    /* ---------------------------------------- */

    // add screen toggle actions to entity
    private _screenToggleActionPath =
    [
        _entity, // Object the action should be assigned to <OBJECT>
        0, // Type of action, 0 for actions, 1 for self-actions <NUMBER>
        _screenActionPath, // Parent path of the new action <ARRAY> (Example: `["ACE_SelfActions", "ACE_Equipment"]`)
        _screenToggleAction // Action <ARRAY>
    ] call ace_interact_menu_fnc_addActionToObject;

    /* ---------------------------------------- */

    // create screen resolution action
    private _screenResolutionAction = [_forEachIndex] call WR_main_fnc_createScreenResolutionAction;

    /* ---------------------------------------- */

    // add screen resolution actions to entity
    private _screenResolutionActionPath =
    [
        _entity, // Object the action should be assigned to <OBJECT>
        0, // Type of action, 0 for actions, 1 for self-actions <NUMBER>
        _screenActionPath, // Parent path of the new action <ARRAY> (Example: `["ACE_SelfActions", "ACE_Equipment"]`)
        _screenResolutionAction // Action <ARRAY>
    ] call ace_interact_menu_fnc_addActionToObject;

    /* ---------------------------------------- */

    // create screen layout action
    private _screenLayoutAction = [_forEachIndex] call WR_main_fnc_createScreenLayoutAction;

    /* ---------------------------------------- */

    // add screen layout actions to entity
    private _screenLayoutActionPath =
    [
        _entity, // Object the action should be assigned to <OBJECT>
        0, // Type of action, 0 for actions, 1 for self-actions <NUMBER>
        _screenActionPath, // Parent path of the new action <ARRAY> (Example: `["ACE_SelfActions", "ACE_Equipment"]`)
        _screenLayoutAction // Action <ARRAY>
    ] call ace_interact_menu_fnc_addActionToObject;

    /* ---------------------------------------- */

    // create screen placeholders action
    private _screenPlaceholdersAction = [_forEachIndex] call WR_main_fnc_createScreenPlaceholdersAction;

    /* ---------------------------------------- */

    // add screen placeholders actions to entity
    private _screenPlaceholdersActionPath =
    [
        _entity, // Object the action should be assigned to <OBJECT>
        0, // Type of action, 0 for actions, 1 for self-actions <NUMBER>
        _screenActionPath, // Parent path of the new action <ARRAY> (Example: `["ACE_SelfActions", "ACE_Equipment"]`)
        _screenPlaceholdersAction // Action <ARRAY>
    ] call ace_interact_menu_fnc_addActionToObject;

} forEach _screenHiddenSelections;

/* ================================================================================ */

systemChat format ["ACE3 Interactions added to entity: %1", _entity];