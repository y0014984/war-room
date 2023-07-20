// runs on init of entity

params ["_entity"];

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