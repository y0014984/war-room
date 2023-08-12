params ["_event", "_params"];

/* ================================================================================ */

if (_event isEqualTo "onInitDialog") exitWith
{
    _params params ["_entity", "_screenIndex", "_screenItemIndex", "_resultCtrl"];

    private _dialog = createDialog ["ConfigureScreenImageItemDialog", true];

    _dialog setVariable ["WR_entity", _entity];
    _dialog setVariable ["WR_screenIndex", _screenIndex];
    _dialog setVariable ["WR_screenItemIndex", _screenItemIndex];
    _dialog setVariable ["WR_resultCtrl", _resultCtrl];

    private _path = getMissionPath "war-room";
    private _result = "ArmaExtensionFolders" callExtension ["getFiles", [_path]];
    _result = _result select 0;
    _result = (_result select [0, _result find """]"]) + """]"; // remove some random bytes at the end
    private _imageFileNames = parseSimpleArray _result;

    private _imageFileNamesFiltered = [];

    private _allowedExtensions = ["paa"];

    {
        private _stringArray = (_x splitString ".");
        private _extension = _stringArray select ((count _stringArray) - 1);

        if (_extension in _allowedExtensions) then { _imageFileNamesFiltered pushBack _x; };
    } forEach _imageFileNames;

    private _imageCtrl = _dialog displayCtrl 4001;

    {
        _imageCtrl lbAdd _x;
    } forEach _imageFileNamesFiltered;

    _imageCtrl lbSetCurSel 0;
};

/* ================================================================================ */

if (_event isEqualTo "onUnloadDialog") exitWith
{
    _params params ["_dialog", "_exitCode"];
    // ok = 1, cancel = 2

    if (_exitCode == 2) exitWith {};

    private _entity = _dialog getVariable ["WR_entity", objNull];

    private _screenIndex = _dialog getVariable ["WR_screenIndex", -1];
    private _screenItemIndex = _dialog getVariable ["WR_screenItemIndex", -1];
    private _resultCtrl = _dialog getVariable ["WR_resultCtrl", controlNull];
    private _screenItemType = _dialog getVariable ["WR_screenItemType", ""];
    private _screenItemContent = _dialog getVariable ["WR_screenItemContent", nil];

    if (_screenItemType isEqualTo "") exitWith { _resultCtrl ctrlSetText ""; };

    _entity setVariable [format ["WR_screen%1Item%2Type", _screenIndex, _screenItemIndex], _screenItemType, true];
    _entity setVariable [format ["WR_screen%1Item%2Content", _screenIndex, _screenItemIndex], _screenItemContent, true];

    _resultCtrl ctrlSetText format ["%1 - %2", _screenItemType, _screenItemContent];
};

/* ================================================================================ */

if (_event isEqualTo "onLBSelChangedImage") exitWith
{
    _params params ["_control", "_lbCurSel", "_lbSelection"];

    private _dialog = ctrlParent _control;

    private _imageCtrl = _dialog displayCtrl 5001;

    private _imageName = _control lbText _lbCurSel;

    // command fileExists only supports relative paths
    private _path = format ["war-room\%1", _imageName];

    if (fileExists _path) then
    {
        _imageCtrl ctrlSetText _path;

        private _itemInfoCtrl = _dialog displayCtrl 4000;
        private _itemInfoAutoCtrl = _dialog displayCtrl 4002;

        if (cbChecked _itemInfoAutoCtrl) then
        {
            private _imageNameWithoutExtension = [_imageName] call WR_main_fnc_removeFilenameExtension;
            
            _itemInfoCtrl ctrlSetText format ["%1", _imageNameWithoutExtension];
        };

        private _itemInfo = ctrlText _itemInfoCtrl;

        _dialog setVariable ["WR_screenItemType", "IMAGE"];
        _dialog setVariable ["WR_screenItemContent", [_itemInfo, _path]];

        systemChat format ["Changed image item to image: %1", _imageName];
    }
    else
    {
        systemChat format ["Image file does not exist anymore: %1", _imageName];
    };
};

/* ================================================================================ */

if (_event isEqualTo "onCheckedChangedItemInfoAuto") exitWith
{
    _params params ["_control", "_checked"];

    private _dialog = ctrlParent _control;

    private _itemInfoCtrl = _dialog displayCtrl 4000;

    if (_checked == 1) then
    {
        private _imageSelCtrl = _dialog displayCtrl 4001;
        private _lbCurSel = lbCurSel _imageSelCtrl;
        private _imageName = _imageSelCtrl lbText _lbCurSel;
        private _imageNameWithoutExtension = [_imageName] call WR_main_fnc_removeFilenameExtension;
        
        _itemInfoCtrl ctrlSetText format ["%1", _imageNameWithoutExtension];

        _itemInfoCtrl ctrlEnable false;
    }
    else
    {
        _itemInfoCtrl ctrlEnable true;
    };
};

/* ================================================================================ */

if (_event isEqualTo "onKeyUpItemInfo") exitWith
{
    _params params ["_control", "_key", "_shift", "_ctrl", "_alt"];

    private _dialog = ctrlParent _control;

    private _screenItemContent = _dialog getVariable ["WR_screenItemContent", nil];

    private _itemInfoCtrl = _dialog displayCtrl 4000;
    private _itemInfo = ctrlText _itemInfoCtrl;
    _screenItemContent set [0, _itemInfo];

    _dialog setVariable ["WR_screenItemContent", _screenItemContent];
};

/* ================================================================================ */