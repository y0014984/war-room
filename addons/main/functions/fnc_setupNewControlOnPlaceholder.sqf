params ["_entity", "_placeholderIndex"];

// get the display for the ui on texture feature
private _uiOnTextureDisplay = _entity getVariable ["WR_uiOnTextureDisplay", displayNull];
if (isNull _uiOnTextureDisplay) exitWith {};

// all placeholders have an id in the 3000 range; 1st placeholder is always 3001, 2nd is 3002 and so on
private _placeholderCtrl = _uiOnTextureDisplay displayCtrl (3000 + _placeholderIndex);

// get the position of the placeholder control
private _ctrlPos = ctrlPosition _placeholderCtrl;

// add a new control
// all new controls will be placed on top of the placeholders and will be in the 4000 range, which is always free
private _newControl = _uiOnTextureDisplay ctrlCreate ["RscMapControl", (4000 + _placeholderIndex)];

// set position of new control to placeholder's position
// ctrlSetPosition for all ctrl except maps
_newControl ctrlMapSetPosition _ctrlPos;
_newControl ctrlCommit 0;
_newControl ctrlMapSetPosition []; // sync

true;

/*
        _mapTarget, _uav1Target, _uav2Target

        //private _mapHeadlineCtrl = _uiOnTextureDisplay displayCtrl 5001;
        private _uav1HeadlineCtrl = _uiOnTextureDisplay displayCtrl 5002;
        private _uav2HeadlineCtrl = _uiOnTextureDisplay displayCtrl 5003;

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
*/