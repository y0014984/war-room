params ["_entity"];

private _updateInterval = 0.05;

private _updateUiOnTexHandle = 
[
	{
        (_this select 0) params ["_entity"];

		private _uiOnTextureDisplay = _entity getVariable ["WR_uiOnTextureDisplay", displayNull];
        if (isNull _uiOnTextureDisplay) exitWith {};

		// set current date and time on headline of war room display
		private _headlineCtrl = _uiOnTextureDisplay displayCtrl 2001;
        private _date = date;
        _date = [_date] call WR_main_fnc_addLeadingZerosToDateTime;
        _date params ["_year", "_month", "_day", "_hours", "_minutes"];
        private _dateTimeString = format ["%1-%2-%3 %4:%5", _year, _month, _day, _hours, _minutes];
        _headlineCtrl ctrlSetText format ["War Room - %1", _dateTimeString];
		
		// update ui on texture (re-render)
		displayUpdate _uiOnTextureDisplay;
	}, 
	_updateInterval, 
	[_entity]
] call CBA_fnc_addPerFrameHandler;

// save the handle for this per-frame-event-handler in ui namespace for later use
uiNamespace setVariable ["WR_updateUiOnTexHandle", _updateUiOnTexHandle];

systemChat "added 'update ui on texture' event handler";

true;