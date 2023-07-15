params ["_entity", "_ScreenItemIndex"];

// get the display for the ui on texture feature
private _uiOnTextureDisplay = _entity getVariable ["WR_uiOnTextureDisplay", displayNull];
if (isNull _uiOnTextureDisplay) exitWith {};

// get the new control - all new controls will be in the 4000 range
private _newCtrl = _uiOnTextureDisplay displayCtrl (4000 + _screenItemIndex);
if (isNull _newCtrl) exitWith {};
// delete new control
ctrlDelete _newCtrl;
// delete ScreenItem variables
_entity setVariable [format ["WR_ScreenItem%1Mutex", _screenItemIndex], nil, true];

systemChat format ["Control with index %1 deleted.", _screenItemIndex];

true;