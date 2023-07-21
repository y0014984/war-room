params ["_entity", "_hiddenSelection", "_screenIndex", "_horizontalResolution", "_verticalResolution", "_fps", "_uiClass"];

if (!canSuspend) exitWith { systemChat "calling 'initUiOnTex' unscheduled is forbidden" };

// if dedicated server or headless client
if (!hasInterface) exitWith {};

private _uiOnTextureDisplayCounter = _entity getVariable [format ["WR_uiOnTextureDisplayCounterScreen%1", _screenIndex], -1];
_uiOnTextureDisplayCounter = _uiOnTextureDisplayCounter + 1;

private _uiOnTextureDisplayName = format ["UiOnTexture-%1-%2-%3", getObjectID _entity, _screenIndex, _uiOnTextureDisplayCounter];

private _texture = format ["#(rgb,%1,%2,1)ui('%3','%4')", _horizontalResolution, _verticalResolution, _uiClass, _uiOnTextureDisplayName];

_entity setObjectTexture [_hiddenSelection, _texture];

waitUntil { !isNull findDisplay _uiOnTextureDisplayName };

private _uiOnTextureDisplay = findDisplay _uiOnTextureDisplayName;

_entity setVariable [format ["WR_uiOnTextureDisplayScreen%1", _screenIndex], _uiOnTextureDisplay];
_entity setVariable [format ["WR_uiOnTextureDisplayNameScreen%1", _screenIndex], _uiOnTextureDisplayName]; // could be removed eventually
_entity setVariable [format ["WR_uiOnTextureDisplayCounterScreen%1", _screenIndex], _uiOnTextureDisplayCounter];
_entity setVariable [format ["WR_uiClassScreen%1", _screenIndex], _uiClass];
_entity setVariable [format ["WR_hiddenSelectionScreen%1", _screenIndex], _hiddenSelection];
_entity setVariable [format ["WR_horizontalResolutionScreen%1", _screenIndex], _horizontalResolution];
_entity setVariable [format ["WR_verticalResolutionScreen%1", _screenIndex], _verticalResolution];

for [{ private _i = 0 }, { _i < 7 }, { _i = _i + 1 }] do
{
    [_entity, _screenIndex, _i] call WR_main_fnc_setupNewControlOnScreenItem;
};

[_entity, _screenIndex, _fps] call WR_main_fnc_addUpdateUiOnTexEventHandler;

systemChat format ["'ui on texture' display for screen %1 initialized.", _screenIndex];