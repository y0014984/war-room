params ["_entity", "_hiddenSelection", "_screenIndex"];

if (!canSuspend) exitWith { systemChat "calling 'terminateUiOnTex' unscheduled is forbidden" };

[_entity, _screenIndex] call WR_main_fnc_removeUpdateUiOnTexEventHandler;

// get the ui on texture display
private _uiOnTextureDisplay = _entity getVariable [format ["WR_uiOnTextureDisplayScreen%1", _screenIndex], displayNull];
if (isNull _uiOnTextureDisplay) exitWith {};

/* // delete all new controls
private _uiScreenItemCount = _entity getVariable ["WR_uiScreenItemCount", false];
for "_i" from 1 to _uiScreenItemCount do
{
    [_entity, _i] call WR_main_fnc_removeNewControlOnScreenItem;
}; */

//_target setObjectTexture [_x, "#(rgb,1,1,1)color(0,0,0,1)"]; // site 1x1 with 1 mimap; black with no transparency
_entity setObjectTexture [_hiddenSelection, "\y\wr\addons\main\ui\WarRoom_DefaultDisplay_1024x1024.paa"];

// close display
//_uiOnTextureDisplay closeDisplay 1; // 1 emulates "OK" button

//private _uiOnTextureDisplayName = _entity getVariable [format ["WR_uiOnTextureDisplayNameScreen%1", _screenIndex], ""];

//waitUntil { isNull findDisplay _uiOnTextureDisplayName };

//_entity setVariable [format ["WR_uiOnTextureDisplayScreen%1", _screenIndex], nil];
//_entity setVariable [format ["WR_uiOnTextureDisplayNameScreen%1", _screenIndex], nil];
//_entity setVariable [format ["WR_uiClassScreen%1", _screenIndex], nil];
//_entity setVariable [format ["WR_hiddenSelectionScreen%1", _screenIndex], nil];

systemChat format ["'ui on texture' display for screen %1 terminated.", _screenIndex];