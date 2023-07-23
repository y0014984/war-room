params ["_event", "_params"];

/* ================================================================================ */

if (_event isEqualTo "onInitDialog") exitWith
{
    _params params ["_entity", "_screenIndex", "_screenItemIndex", "_resultCtrl"];

    private _dialog = createDialog ["ConfigureScreenTextItemDialog", true];

    _dialog setVariable ["WR_entity", _entity];
    _dialog setVariable ["WR_screenIndex", _screenIndex];
    _dialog setVariable ["WR_screenItemIndex", _screenItemIndex];
    _dialog setVariable ["WR_resultCtrl", _resultCtrl];

    // add example texts
    private _headlineCtrl = _dialog displayCtrl 4001;
    private _textCtrl = _dialog displayCtrl 4002;

    _headlineCtrl ctrlSetText "My Example Headline";
    _textCtrl ctrlSetText
        "<t size='2'>Hello!</t>" + endl + 
        "<t color='#ff0000'>Red text</t>" + endl + 
        "<t font='PuristaBold'>Bold Text</t>" + endl + 
        "<t font='LCD14'>Wicked looking text</t>" + endl + 
        "<t align='right'>Text displayed to the right</t>" + endl + 
        "<t valign='bottom'>Text displayed at the bottom</t>" + endl + 
        "<t underline='1'>Underlined Text</t>" + endl + 
        "<t shadow='0'>Text with no shadow</t>" + endl + 
        "<t shadow='1'>Text with default black shadow</t>" + endl + 
        "<t shadow='2'>Text with default black outline</t>" + endl + 
        "<t shadow='1' shadowColor='#ff0000'>Text with red shadow</t>" + endl + 
        "<t shadow='1' shadowColor='#ff0000' shadowOffset='0.5'>Text with red shadow, which is offset by half character size</t>" + endl + 
        "<t colorLink='#0000ff'><a href='http://www.arma3.com/'>Blue text</a></t>" + endl + 
        "<a colorLink='#0000ff' href='http://www.arma3.com/'>Blue text too</a>" + endl + 
        "<t colorLink='#0000ff'>Normal text color</t>" + endl + 
        "<img image='\a3\Data_f\Flags\flag_Altis_co.paa'/>";
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

    private _headlineCtrl = _dialog displayCtrl 4001;
    private _textCtrl = _dialog displayCtrl 4002;

    private _headline = ctrlText _headlineCtrl;
    private _text = ctrlText _textCtrl;

    private _screenItemType = "TEXT";
    private _screenItemContent = [_headline, _text];

    _entity setVariable [format ["WR_screen%1Item%2Type", _screenIndex, _screenItemIndex], _screenItemType, true];
    _entity setVariable [format ["WR_screen%1Item%2Content", _screenIndex, _screenItemIndex], _screenItemContent, true];

    _resultCtrl ctrlSetText format ["%1 - %2", _screenItemType, _screenItemContent];

    systemChat format ["Set text item to: %1 %2", _headline, _text];
};

/* ================================================================================ */
