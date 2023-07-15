params ["_event", "_params"];

/* ================================================================================ */

if (_event isEqualTo "onInitDialog") exitWith
{
    _params params ["_target", "_screenIndex", "_screenItemIndex", "_selectCtrl", "_resultCtrl"];

    private _dialog = createDialog ["ConfigureScreenImageItemDialog", true];

    _dialog setVariable ["WR_target", _target];
    _dialog setVariable ["WR_screenIndex", _screenIndex];
    _dialog setVariable ["WR_screenItemIndex", _screenItemIndex];
    _dialog setVariable ["WR_selectCtrl", _selectCtrl];
    _dialog setVariable ["WR_resultCtrl", _resultCtrl];

    private _path = getMissionPath "war-room";
    private _result = "ArmaExtensionFolders" callExtension ["getFiles", [_path]];
    _result = _result select 0;
    _result = (_result select [0, _result find """]"]) + """]"; // remove some random bytes at the end
    private _ImageFileNames = parseSimpleArray _result;

    private _ImageFileNamesFiltered = [];

    private _allowedExtensions = ["paa"];

    {
        private _stringArray = (_x splitString ".");
        private _extension = _stringArray select ((count _stringArray) - 1);

        if (_extension in _allowedExtensions) then { _ImageFileNamesFiltered pushBack _x; };
    } forEach _ImageFileNames;

    private _imageCtrl = _dialog displayCtrl 4001;

    {
        _imageCtrl lbAdd _x;
    } forEach _ImageFileNamesFiltered;

    _imageCtrl lbSetCurSel 0;
};

/* ================================================================================ */

if (_event isEqualTo "onUnloadDialog") exitWith
{
    _params params ["_dialog", "_exitCode"];
    // ok = 1, cancel = 2

    private _target = _dialog getVariable ["WR_target", objNull];
    private _selectCtrl = _dialog getVariable ["WR_selectCtrl", controlNull];

    if (_exitCode == 2) exitWith { _selectCtrl lbSetCurSel 0; };

    private _screenIndex = _dialog getVariable ["WR_screenIndex", -1];
    private _screenItemIndex = _dialog getVariable ["WR_screenItemIndex", -1];
    private _resultCtrl = _dialog getVariable ["WR_resultCtrl", controlNull];
    private _screenItemType = _dialog getVariable ["WR_screenItemType", ""];
    private _screenItemContent = _dialog getVariable ["WR_screenItemContent", nil];

    if (_screenItemType isEqualTo "") exitWith { _resultCtrl ctrlSetText ""; };

    _target setVariable [format ["WR_screen%1Item%2Type", _screenIndex, _screenItemIndex], _screenItemType];
    _target setVariable [format ["WR_screen%1Item%2Content", _screenIndex, _screenItemIndex], _screenItemContent];

    _resultCtrl ctrlSetText format ["%1: %2", _screenItemType, _screenItemContent];
};

/* ================================================================================ */

if (_event isEqualTo "onLBSelChangedImage") exitWith
{
    _params params ["_control", "_lbCurSel", "_lbSelection"];

    _imageName = _control lbText _lbCurSel;

    // command fileExists only supports relative paths
    private _path = format ["war-room\%1", _imageName];

    private _dialog = ctrlParent _control;

    private _imageCtrl = _dialog displayCtrl 5001;

    if (fileExists _path) then
    {
        _imageCtrl ctrlSetText _path;

        _dialog setVariable ["WR_screenItemType", "IMAGE"];
        _dialog setVariable ["WR_screenItemContent", _path];

        systemChat format ["Changed image item to image: %1", _imageName];
    }
    else
    {
        systemChat format ["Image file does not exist anymore: %1", _imageName];
    };
};

/* ================================================================================ */
