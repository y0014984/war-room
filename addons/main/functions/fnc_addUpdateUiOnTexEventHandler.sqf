params ["_entity", "_mapTarget", "_uav1Target", "_uav2Target"];

private _updateInterval = 0.05;

private _updateUiOnTexHandle = 
[
	{
        (_this select 0) params ["_entity", "_mapTarget", "_uav1Target", "_uav2Target"];

		private _uiOnTextureDisplay = _entity getVariable ["WR_uiOnTextureDisplay", displayNull];
        if (isNull _uiOnTextureDisplay) exitWith {};

		private _headlineCtrl = _uiOnTextureDisplay displayCtrl 2001;

        private _date = date;
        _date = [_date] call WR_main_fnc_addLeadingZerosToDateTime;
        _date params ["_year", "_month", "_day", "_hours", "_minutes"];
        private _dateTimeString = format ["%1-%2-%3 %4:%5", _year, _month, _day, _hours, _minutes];

        _headlineCtrl ctrlSetText format ["War Room - %1", _dateTimeString];

        //private _mapHeadlineCtrl = _uiOnTextureDisplay displayCtrl 4001;
        private _uav1HeadlineCtrl = _uiOnTextureDisplay displayCtrl 4002;
        private _uav2HeadlineCtrl = _uiOnTextureDisplay displayCtrl 4003;

		private _mapPos = getPos _mapTarget;
		private _uav1Pos = getPosAsL _uav1Target;
		private _uav2Pos = getPosAsL _uav2Target;
		
        //_mapHeadlineCtrl ctrlSetText format ["Map (Pos: %1)", mapGridPosition _mapPos];
		_uav1HeadlineCtrl ctrlSetText format ["UAV 1 (Pos: %1)", mapGridPosition _uav1Pos];
		_uav2HeadlineCtrl ctrlSetText format ["UAV 2 (Pos: %1)", mapGridPosition _uav2Pos];
		
		private _mapCtrl = _uiOnTextureDisplay displayCtrl 3001;
		
		private _mapZoom = 0.15;
		
		_mapCtrl ctrlMapAnimAdd [0, _mapZoom, _mapPos];
		ctrlMapAnimCommit _mapCtrl;
		
		displayUpdate _uiOnTextureDisplay;
	}, 
	_updateInterval, 
	[_entity, _mapTarget, _uav1Target, _uav2Target]
] call CBA_fnc_addPerFrameHandler;

uiNamespace setVariable ["WR_updateUiOnTexHandle", _updateUiOnTexHandle];

true;