params ["_dialog", "_entity", "_screenIndex"];

[_entity, _screenIndex] remoteExec ["WR_main_fnc_removePresentationLayer", 0, true];

private _pointerVariablesPerFrameHandler = _entity getVariable [format ["WR_pointerVariablesPerFrameHandlerScreen%1", _screenIndex], -1];
private _mouseMovingEventHandler = _entity getVariable [format ["WR_mouseMovingEventHandlerScreen%1", _screenIndex], -1];
private _mouseButtonUpEventHandler = _entity getVariable [format ["WR_mouseButtonUpEventHandlerScreen%1", _screenIndex], -1];
private _mouseButtonDownEventHandler = _entity getVariable [format ["WR_mouseButtonDownEventHandlerScreen%1", _screenIndex], -1];

[_pointerVariablesPerFrameHandler] call CBA_fnc_removePerFrameHandler;
_dialog displayRemoveEventHandler ["MouseMoving", _mouseMovingEventHandler];
_dialog displayRemoveEventHandler ["MouseButtonUp", _mouseButtonUpEventHandler];
_dialog displayRemoveEventHandler ["MouseButtonDown", _mouseButtonDownEventHandler];

systemChat "_pointerVariablesPerFrameHandler removed";
systemChat "_mouseMovingEventHandler removed";
systemChat "_mouseButtonUpEventHandler removed";
systemChat "_mouseButtonDownEventHandler removed";

_entity setVariable [format ["WR_pointerEnabledScreen%1", _screenIndex], nil];
_entity setVariable [format ["WR_pointerPosScreen%1", _screenIndex], nil];

systemChat format ["Disabled presentation layer for entity %1 with screen %2", _entity, _screenIndex];