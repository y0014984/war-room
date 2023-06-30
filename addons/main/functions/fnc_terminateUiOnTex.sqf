params ["_entity"];

// get the ui on texture display
private _uiOnTextureDisplay = _entity getVariable ["WR_uiOnTextureDisplay", displayNull];
if (isNull _uiOnTextureDisplay) exitWith {};

// delete all new controls
private _uiPlaceholderCount = _entity getVariable ["WR_uiPlaceholderCount", false];
for "_i" from 1 to _uiPlaceholderCount do
{
    [_entity, _i] call WR_main_fnc_removeNewControlOnPlaceholder;
};

// close display
_uiOnTextureDisplay closeDisplay 1; // 1 emulates "OK" button

// delete display variable globally
_entity setVariable ["WR_uiOnTextureDisplay", displayNull, true];

systemChat "'ui on texture' display closed.";

true;