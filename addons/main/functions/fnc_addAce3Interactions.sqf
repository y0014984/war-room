// runs on init of entity

params ["_entity"];

/* ================================================================================ */

/* private _insertChildren =
{
    params ["_target", "_player", "_params"];

    private _uiScreenItemCount = _target getVariable ["WR_uiScreenItemCount", false];
    // Add children to action
    private _actions = [];
    for "_i" from 1 to _uiScreenItemCount do
    { 
        private _statement =
        {
            params ["_target", "_player", "_params"];
            _params params ["_screenItemIndex"];

            private _screenItemMutex = _target getVariable [format ["WR_ScreenItem%1Mutex", _screenItemIndex], false];
            if (_ScreenItemMutex) then
            {
                // true means, ScreenItem is currently enabled, so the ScreenItem will be disabled
                systemChat format ["reset %1", _screenItemIndex];
                [_target, _screenItemIndex] call WR_main_fnc_removeNewControlOnScreenItem;
                _target setVariable [format ["WR_ScreenItem%1Mutex", _screenItemIndex], false, true];
            }
            else
            {
                // false means, ScreenItem is currently disabled, so the ScreenItem will be enabled
                systemChat format ["setup %1", _screenItemIndex];
                [_target, _screenItemIndex] call WR_main_fnc_setupNewControlOnScreenItem;
                _target setVariable [format ["WR_ScreenItem%1Mutex", _screenItemIndex], true, true];
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
            _params params ["_ScreenItemIndex"];

            private _screenItemMutex = _target getVariable [format ["WR_ScreenItem%1Mutex", _screenItemIndex], false];
            // Modify the action - index 1 is the display name, 2 is the icon...
            if (_ScreenItemMutex) then { _actionData set [1, format ["reset ScreenItem %1", _screenItemIndex]]; } else { _actionData set [1, format ["setup ScreenItem %1", _screenItemIndex]]; };
        };
        private _action = [format ["ToggleScreenItem%1", _i], format ["Toggle ScreenItem %1", _i], "", _statement, _condition, nil, _i, nil, nil, nil, _modifier] call ace_interact_menu_fnc_createAction;
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

private _screens = _entity getVariable ["WR_screens", []];
{
    private _hiddenSelection = _x select 0;

    // create screen actions for every screen
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
    private _screenToggleAction = [_hiddenSelection, _forEachIndex] call WR_main_fnc_createScreenToggleAction;

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

    // create screen configuration action
    private _screenConfigurationAction = [_forEachIndex] call WR_main_fnc_createScreenConfigurationAction;

    /* ---------------------------------------- */

    // add screen configuration actions to entity
    private _screenConfigurationActionPath =
    [
        _entity, // Object the action should be assigned to <OBJECT>
        0, // Type of action, 0 for actions, 1 for self-actions <NUMBER>
        _screenActionPath, // Parent path of the new action <ARRAY> (Example: `["ACE_SelfActions", "ACE_Equipment"]`)
        _screenConfigurationAction // Action <ARRAY>
    ] call ace_interact_menu_fnc_addActionToObject;

    /* ---------------------------------------- */

    // create screen presentation action
    private _screenPresentationAction = [_forEachIndex] call WR_main_fnc_createScreenPresentationAction;

    /* ---------------------------------------- */

    // add screen presentation actions to entity
    private _screenPresentationActionPath =
    [
        _entity, // Object the action should be assigned to <OBJECT>
        0, // Type of action, 0 for actions, 1 for self-actions <NUMBER>
        _screenActionPath, // Parent path of the new action <ARRAY> (Example: `["ACE_SelfActions", "ACE_Equipment"]`)
        _screenPresentationAction // Action <ARRAY>
    ] call ace_interact_menu_fnc_addActionToObject;

} forEach _screens;

/* ================================================================================ */

systemChat format ["ACE3 Interactions added to entity: %1", _entity];