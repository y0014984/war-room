params ["_entity", "_placeholderIndex"];

// get the display for the ui on texture feature
private _uiOnTextureDisplay = _entity getVariable ["WR_uiOnTextureDisplay", displayNull];
if (isNull _uiOnTextureDisplay) exitWith {};

// get the new control - all new controls will be in the 4000 range
private _newCtrl = _uiOnTextureDisplay displayCtrl (4000 + _placeholderIndex);
if (isNull _newCtrl) exitWith {};
// delete new control
ctrlDelete _newCtrl;
// delete placeholder variables
_entity setVariable [format ["WR_placeholder%1Mutex", _placeholderIndex], nil, true];

systemChat format ["Control with index %1 deleted.", _placeholderIndex];

true;