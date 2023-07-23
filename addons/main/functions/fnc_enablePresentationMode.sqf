params ["_entity", "_screenIndex"];

#include "\y\wr\addons\main\defines.inc"

private _uiClass = _entity getVariable [format ["WR_uiClassScreen%1", _screenIndex], ""];
if (_uiClass isEqualTo "") then
{
    private _screens = _entity getVariable ["WR_screens", []];
    private _allowedUiClasses = (_screens select _screenIndex) select 1;
    private _defaultUiClass = (_screens select _screenIndex) select 2;
    _uiClass = _allowedUiClasses select _defaultUiClass;
};

private _dialog = createDialog [_uiClass];

_entity setVariable [format ["WR_presentationDialogScreen%1", _screenIndex], _dialog];

_dialog setVariable ["WR_entity", _entity];
_dialog setVariable ["WR_screenIndex", _screenIndex];

private _pointerCtrl = _dialog ctrlCreate ["RscPicture", 9999];

_pointerCtrl ctrlSetText "\y\wr\addons\main\ui\WarRoom_Pointer_32x32.paa";

private _backgroundCtrl = _dialog displayCtrl 1001;

private _backgroundCtrlPos = ctrlPosition _backgroundCtrl;

private _backgroundCenterX = (_backgroundCtrlPos select 0) + ((_backgroundCtrlPos select 2) / 2);
private _backgroundCenterY = (_backgroundCtrlPos select 1) + ((_backgroundCtrlPos select 3) / 2);

_pointerCtrl ctrlSetPosition [_backgroundCenterX - (0.5 * GUI_GRID_W), _backgroundCenterY - (0.5 * GUI_GRID_H), (1 * GUI_GRID_W), (1 * GUI_GRID_H)];
_pointerCtrl ctrlCommit 0;

_pointerCtrl ctrlShow false;

[_entity, _screenIndex] remoteExec ["WR_main_fnc_addPresentationLayer", 0, true];

/* ================================================================================ */

_dialog displayAddEventHandler
    [
        "Unload",
        {
            params ["_dialog", "_exitCode"];

            private _entity = _dialog getVariable ["WR_entity", objNull];
            private _screenIndex = _dialog getVariable ["WR_screenIndex", 0];

            [_dialog, _entity, _screenIndex] call WR_main_fnc_disablePresentationMode;
        }
    ];


/* ================================================================================ */

private _mouseButtonDownEventHandler = _dialog displayAddEventHandler
    [
        "MouseButtonDown",
        {
            params ["_dialog", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

            private _pointerCtrl = _dialog displayCtrl 9999;

            _pointerCtrl ctrlShow true;

            _dialog setVariable ["WR_mouseButtonPressed", true];

            private _entity = _dialog getVariable ["WR_entity", objNull];
            private _screenIndex = _dialog getVariable ["WR_screenIndex", 0];

            _entity setVariable [format ["WR_pointerEnabledScreen%1", _screenIndex], true];
        }
    ];

_entity setVariable [format ["WR_mouseButtonDownEventHandlerScreen%1", _screenIndex], _mouseButtonDownEventHandler];

/* ================================================================================ */

private _mouseButtonUpEventHandler = _dialog displayAddEventHandler
    [
        "MouseButtonUp",
        {
            params ["_dialog", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

            private _pointerCtrl = _dialog displayCtrl 9999;

            _pointerCtrl ctrlShow false;

            _dialog setVariable ["WR_mouseButtonPressed", false];

            private _entity = _dialog getVariable ["WR_entity", objNull];
            private _screenIndex = _dialog getVariable ["WR_screenIndex", 0];

            _entity setVariable [format ["WR_pointerEnabledScreen%1", _screenIndex], false];
        }
    ];

_entity setVariable [format ["WR_mouseButtonUpEventHandlerScreen%1", _screenIndex], _mouseButtonUpEventHandler];

/* ================================================================================ */

private _mouseMovingEventHandler = _dialog displayAddEventHandler
    [
        "MouseMoving",
        {
            params ["_dialog", "_xPos", "_yPos"];

            private _mouseButtonPressed = _dialog getVariable ["WR_mouseButtonPressed", false];

            if (_mouseButtonPressed) then 
            {
                private _pointerCtrl = _dialog displayCtrl 9999;

                // the relative values of _xPos and _yPos don't work good for what I'm trying to do
                // So, let's use the current mouse position instead
                private _pointerPos = getMousePosition;
                _pointerPos set [0, (_pointerPos select 0) - (0.5 * GUI_GRID_W)];
                _pointerPos set [1, (_pointerPos select 1) - (0.5 * GUI_GRID_H)];

                _pointerCtrl ctrlSetPosition _pointerPos;
                _pointerCtrl ctrlCommit 0;

                private _entity = _dialog getVariable ["WR_entity", objNull];
                private _screenIndex = _dialog getVariable ["WR_screenIndex", 0];

                _entity setVariable [format ["WR_pointerPosScreen%1", _screenIndex], _pointerPos];

                hintSilent format ["Mouse pressed and moving with xPos: %1 yPos: %2", _pointerPos select 0, _pointerPos select 1];
            };
        }
    ];

_entity setVariable [format ["WR_mouseMovingEventHandlerScreen%1", _screenIndex], _mouseMovingEventHandler];

/* ================================================================================ */

// add Event Handler to sync pointer position regularly to network clients
private _updateInterval = 0.2; // 5 times per second
private _pointerVariablesPerFrameHandler = 
    [
        {
            (_this select 0) params ["_entity", "_screenIndex"];

            // get local stored variables
            private _pointerEnabled = _entity getVariable [format ["WR_pointerEnabledScreen%1", _screenIndex], false];
            private _pointerPos = _entity getVariable [format ["WR_pointerPosScreen%1", _screenIndex], [0, 0]];

            // broadcast variables
            _entity setVariable [format ["WR_pointerEnabledScreen%1", _screenIndex], _pointerEnabled, true];
            _entity setVariable [format ["WR_pointerPosScreen%1", _screenIndex], _pointerPos, true];
        }, 
        _updateInterval, 
        [_entity, _screenIndex]
    ] call CBA_fnc_addPerFrameHandler;

_entity setVariable [format ["WR_pointerVariablesPerFrameHandlerScreen%1", _screenIndex], _pointerVariablesPerFrameHandler];

/* ================================================================================ */

systemChat format ["Enabled presentation layer for entity %1 with screen %2", _entity, _screenIndex];