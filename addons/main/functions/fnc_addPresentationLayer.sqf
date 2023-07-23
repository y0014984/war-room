params ["_entity", "_screenIndex"];

#include "\y\wr\addons\main\defines.inc"

private _uiOnTextureDisplay = _entity getVariable [format ["WR_uiOnTextureDisplayScreen%1", _screenIndex], displayNull];

private _pointerCtrl = _uiOnTextureDisplay ctrlCreate ["RscPicture", 9999];

_pointerCtrl ctrlSetText "\y\wr\addons\main\ui\WarRoom_Pointer_32x32.paa";

private _backgroundCtrl = _uiOnTextureDisplay displayCtrl 1001;

private _backgroundCtrlPos = ctrlPosition _backgroundCtrl;

private _backgroundCenterX = (_backgroundCtrlPos select 0) + ((_backgroundCtrlPos select 2) / 2);
private _backgroundCenterY = (_backgroundCtrlPos select 1) + ((_backgroundCtrlPos select 3) / 2);

_pointerCtrl ctrlSetPosition [_backgroundCenterX - (0.5 * GUI_GRID_W), _backgroundCenterY - (0.5 * GUI_GRID_H), (1 * GUI_GRID_W), (1 * GUI_GRID_H)];
_pointerCtrl ctrlCommit 0;

_pointerCtrl ctrlShow false;

/* ================================================================================ */

// add Event Handler to update pointer position regularly
private _updateInterval = 0.2; // 5 times per second
private _pointerUpdatePerFrameHandler = 
    [
        {
            (_this select 0) params ["_entity", "_screenIndex", "_pointerCtrl"];

            private _pointerEnabled = _entity getVariable [format ["WR_pointerEnabledScreen%1", _screenIndex], false];
            private _pointerPos = _entity getVariable [format ["WR_pointerPosScreen%1", _screenIndex], [0, 0]];

            systemChat "updating pointer ...";

            if (_pointerEnabled) then
            {
                if (!ctrlShown _pointerCtrl) then { _pointerCtrl ctrlShow true; };

                _pointerCtrl ctrlSetPosition _pointerPos;
                _pointerCtrl ctrlCommit 0;
            }
            else
            {
                if (ctrlShown _pointerCtrl) then { _pointerCtrl ctrlShow false; };
            };
        }, 
        _updateInterval, 
        [_entity, _screenIndex, _pointerCtrl]
    ] call CBA_fnc_addPerFrameHandler;

_entity setVariable [format ["WR_pointerUpdatePerFrameHandlerScreen%1", _screenIndex], _pointerUpdatePerFrameHandler];

/* ================================================================================ */

systemChat format ["Locally added presentation layer for entity %1 with screen %2", _entity, _screenIndex];