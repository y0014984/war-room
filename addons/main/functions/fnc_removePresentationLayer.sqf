params ["_entity", "_screenIndex"];

private _pointerUpdatePerFrameHandler = _entity getVariable [format ["WR_pointerUpdatePerFrameHandlerScreen%1", _screenIndex], -1];

[_pointerUpdatePerFrameHandler] call CBA_fnc_removePerFrameHandler;

private _uiOnTextureDisplay = _entity getVariable [format ["WR_uiOnTextureDisplayScreen%1", _screenIndex], displayNull];

private _pointerCtrl = _uiOnTextureDisplay displayCtrl 9999;

ctrlDelete _pointerCtrl;

systemChat "_pointerUpdatePerFrameHandler removed";

systemChat format ["Locally removed presentation layer for entity %1 with screen %2", _entity, _screenIndex];

