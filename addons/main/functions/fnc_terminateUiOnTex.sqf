params ["_entity", "_hiddenSelection", "_screenIndex"];

// get the ui on texture display
private _uiOnTextureDisplay = _entity getVariable [format ["WR_uiOnTextureDisplayScreen%1", _screenIndex], displayNull];
if (isNull _uiOnTextureDisplay) exitWith {};

/* // delete all new controls
private _uiPlaceholderCount = _entity getVariable ["WR_uiPlaceholderCount", false];
for "_i" from 1 to _uiPlaceholderCount do
{
    [_entity, _i] call WR_main_fnc_removeNewControlOnPlaceholder;
}; */

// close display
_uiOnTextureDisplay closeDisplay 1; // 1 emulates "OK" button

// delete display variable globally
_entity setVariable [format ["WR_uiOnTextureDisplayScreen%1", _screenIndex], nil, true];

//_target setObjectTexture [_x, "#(rgb,1,1,1)color(0,0,0,1)"]; // site 1x1 with 1 mimap; black with no transparency
_target setObjectTexture [_hiddenSelection, "\y\wr\addons\main\ui\WarRoom_DefaultDisplay_1024x1024.paa"];

systemChat format ["'ui on texture' display for screen %1 terminated.", _screenIndex];

true;