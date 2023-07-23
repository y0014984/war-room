/* ================================================================================ */

	// size safezone 40x25
    // we can't change that
    
    // War Room 1 --> 1x 4x4
    // War Room 2 --> 2x 2x2
    // War Room 3 --> 1x 2x2 and 4x 1x1
    // War Room 4 --> 8x 1x1
    // War Room 5 --> 1x 3x2 and 2x 1x1

/* ================================================================================ */

class RscText;
class RscEdit;
class RscButton;
class RscCombo;
class RscMapControl;
class RscPicture;
class RscPictureKeepAspect;
class RscXSliderH;
class RscButtonMenuOK;
class RscButtonMenuCancel;

/* ================================================================================ */

// TEMPLATES

class ScreenItemXLabel: RscText
{
    idc = -1;

    x = 0 * GUI_GRID_W + GUI_GRID_X;
    y = 14 * GUI_GRID_H + GUI_GRID_Y;
    w = 10 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;

    style = ST_RIGHT;
};

class ScreenItemX: RscCombo
{
    idc = -1;

    x = 11 * GUI_GRID_W + GUI_GRID_X;
    y = 14 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;

    WR_screenItemIndex = -1;

    class Items
    {
        class NoneItem
        {
            text = "None";
            default = 1;
        };
        class ImageItem
        {
            text = "Image";
        };
        class MapItem
        {
            text = "Map";
        };
        class DroneCamItem
        {
            text = "DroneCam";
        };
        class InfantryCamItem
        {
            text = "InfantryCam";
        };
        class TextItem
        {
            text = "Text";
        };
    };

    onLBSelChanged = "['onLBSelChangedItem', _this] call WR_main_fnc_ui_configureScreen;";
};

class ScreenItemXResult: RscText
{
    idc = -1;

    x = 21 * GUI_GRID_W + GUI_GRID_X;
    y = 14 * GUI_GRID_H + GUI_GRID_Y;
    w = 18.5 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
};

/* ================================================================================ */

class ConfigureScreenDialog
{
	idd = 14631;
	enableSimulation = true;

    onUnload = "['onUnloadDialog', _this] call WR_main_fnc_ui_configureScreen;";

	class ControlsBackground
	{
        class Background: RscText
        {
            idc = 1001;

            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 0 * GUI_GRID_H + GUI_GRID_Y;
            w = 40 * GUI_GRID_W;
            h = 23 * GUI_GRID_H;

            colorBackground[] = {0.3, 0.3, 0.3, 1}; // opaque dark grey
        };
	};

	class Controls
	{
        class Headline: RscText
        {
            idc = 2001;

            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 0 * GUI_GRID_H + GUI_GRID_Y;
            w = 40 * GUI_GRID_W;
            h = 1.5 * GUI_GRID_H;

            colorBackground[] = {0, 0, 0, 1}; // opaque black
            text = "Configure Screen"; //--- ToDo: Localize;
        };

		class WarRoomNameLabel: RscText
		{
			idc = 3000;
        
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
			text = "War Room Name"; //--- ToDo: Localize;
            style = ST_RIGHT;
		};

		class WarRoomName: RscEdit
		{
			idc = 4000;
        
			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 26 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;

            colorBackground[] = {0.2, 0.2, 0.2, 1}; // opaque dark grey
		};

		class ResolutionLabel: RscText
		{
			idc = 3001;
        
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
			text = "Resolution"; //--- ToDo: Localize;
            style = ST_RIGHT;
		};

        class HorizontalResolution: RscCombo
        {
            idc = 4001;

            x = 11 * GUI_GRID_W + GUI_GRID_X;
            y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 8 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;

            class Items
            {
                class 256
                {
                    text = "256px";
                };
                class 512
                {
                    text = "512px";
                };
                class 1024
                {
                    text = "1024px";
                    default = 1;
                };
                class 2048
                {
                    text = "2048px";
                };
                class 4096
                {
                    text = "4096px";
                };
            };
        };

		class timesLabel: RscText
		{
			idc = 3002;
        
			x = 19.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 1 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
			text = "x"; //--- ToDo: Localize;
            style = ST_RIGHT;
		};

        class VerticalResolution: RscCombo
        {
            idc = 4002;

            x = 21 * GUI_GRID_W + GUI_GRID_X;
            y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 8 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;

            class Items
            {
                class 256
                {
                    text = "256px";
                };
                class 512
                {
                    text = "512px";
                };
                class 1024
                {
                    text = "1024px";
                    default = 1;
                };
                class 2048
                {
                    text = "2048px";
                };
                class 4096
                {
                    text = "4096px";
                };
            };
        };

		class atLabel: RscText
		{
			idc = 3003;
        
			x = 29.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 1 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
			text = "@"; //--- ToDo: Localize;
            style = ST_RIGHT;
		};

        class FramesPerSecond: RscCombo
        {
            idc = 4003;

            x = 31 * GUI_GRID_W + GUI_GRID_X;
            y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 6 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;

            class Items
            {
                class 1
                {
                    text = "1 FPS";
                };
                class 2
                {
                    text = "2 FPS";
                };
                class 3
                {
                    text = "3 FPS";
                };
                class 4
                {
                    text = "4 FPS";
                };
                class 5
                {
                    text = "5 FPS";
                };
                class 10
                {
                    text = "10 FPS";
                    default = 1;
                };
                class 20
                {
                    text = "20 FPS";
                };
                class 30
                {
                    text = "30 FPS";
                };
                class 45
                {
                    text = "45 FPS";
                };
                class 60
                {
                    text = "60 FPS";
                };
            };
        };

		class UiClassLabel: RscText
		{
			idc = 3004;
        
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
			text = "UI Class"; //--- ToDo: Localize;
            style = ST_RIGHT;
		};

        class UiClass: RscCombo
        {
            idc = 4004;

            x = 11 * GUI_GRID_W + GUI_GRID_X;
            y = 5 * GUI_GRID_H + GUI_GRID_Y;
            w = 8 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;

            onLBSelChanged = "['onLBSelChangedUiClass', _this] call WR_main_fnc_ui_configureScreen;";
        };

		class UiClassDemo: RscPicture
		{
			idc = 5001;

            x = 21 * GUI_GRID_W + GUI_GRID_X;
            y = 5 * GUI_GRID_H + GUI_GRID_Y;
            w = 8 * GUI_GRID_W;
            h = 5 * GUI_GRID_H;
		};

        /* ---------------------------------------- */

		class ScreenItem0Label: ScreenItemXLabel
		{
			idc = 3005;

			y = 10.5 * GUI_GRID_H + GUI_GRID_Y;     

			text = "Screen Item 0"; //--- ToDo: Localize;
		};

        class ScreenItem0: ScreenItemX
        {
            idc = 4005;

            y = 10.5 * GUI_GRID_H + GUI_GRID_Y;

            WR_screenItemIndex = 0;
        };

        class ScreenItem0Result: ScreenItemXResult
        {
            idc = 5005;

            y = 10.5 * GUI_GRID_H + GUI_GRID_Y;
        };

        /* ---------------------------------------- */

		class ScreenItem1Label: ScreenItemXLabel
		{
			idc = 3006;

			y = 12 * GUI_GRID_H + GUI_GRID_Y;     

			text = "Screen Item 1"; //--- ToDo: Localize;
		};

        class ScreenItem1: ScreenItemX
        {
            idc = 4006;

            y = 12 * GUI_GRID_H + GUI_GRID_Y;

            WR_screenItemIndex = 1;
        };

        class ScreenItem1Result: ScreenItemXResult
        {
            idc = 5006;

            y = 12 * GUI_GRID_H + GUI_GRID_Y;
        };

        /* ---------------------------------------- */

		class ScreenItem2Label: ScreenItemXLabel
		{
			idc = 3007;

			y = 13.5 * GUI_GRID_H + GUI_GRID_Y;     

			text = "Screen Item 2"; //--- ToDo: Localize;
		};

        class ScreenItem2: ScreenItemX
        {
            idc = 4007;

            y = 13.5 * GUI_GRID_H + GUI_GRID_Y;

            WR_screenItemIndex = 2;
        };

        class ScreenItem2Result: ScreenItemXResult
        {
            idc = 5007;

            y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
        };

        /* ---------------------------------------- */

		class ScreenItem3Label: ScreenItemXLabel
		{
			idc = 3008;

			y = 15 * GUI_GRID_H + GUI_GRID_Y;     

			text = "Screen Item 3"; //--- ToDo: Localize;
		};

        class ScreenItem3: ScreenItemX
        {
            idc = 4008;

            y = 15 * GUI_GRID_H + GUI_GRID_Y;

            WR_screenItemIndex = 3;
        };

        class ScreenItem3Result: ScreenItemXResult
        {
            idc = 5008;

            y = 15 * GUI_GRID_H + GUI_GRID_Y;
        };

        /* ---------------------------------------- */

		class ScreenItem4Label: ScreenItemXLabel
		{
			idc = 3009;

			y = 16.5 * GUI_GRID_H + GUI_GRID_Y;     

			text = "Screen Item 4"; //--- ToDo: Localize;
		};

        class ScreenItem4: ScreenItemX
        {
            idc = 4009;

            y = 16.5 * GUI_GRID_H + GUI_GRID_Y;

            WR_screenItemIndex = 4;
        };

        class ScreenItem4Result: ScreenItemXResult
        {
            idc = 5009;

            y = 16.5 * GUI_GRID_H + GUI_GRID_Y;
        };
        
        /* ---------------------------------------- */

		class ScreenItem5Label: ScreenItemXLabel
		{
			idc = 3010;

			y = 18 * GUI_GRID_H + GUI_GRID_Y;     

			text = "Screen Item 5"; //--- ToDo: Localize;
		};

        class ScreenItem5: ScreenItemX
        {
            idc = 4010;

            y = 18 * GUI_GRID_H + GUI_GRID_Y;

            WR_screenItemIndex = 5;
        };

        class ScreenItem5Result: ScreenItemXResult
        {
            idc = 5010;

            y = 18 * GUI_GRID_H + GUI_GRID_Y;
        };
        
        /* ---------------------------------------- */

		class ScreenItem6Label: ScreenItemXLabel
		{
			idc = 3011;

			y = 19.5 * GUI_GRID_H + GUI_GRID_Y;     

			text = "Screen Item 6"; //--- ToDo: Localize;
		};

        class ScreenItem6: ScreenItemX
        {
            idc = 4011;

            y = 19.5 * GUI_GRID_H + GUI_GRID_Y;

            WR_screenItemIndex = 6;
        };

        class ScreenItem6Result: ScreenItemXResult
        {
            idc = 5011;

            y = 19.5 * GUI_GRID_H + GUI_GRID_Y;
        };
        
        /* ---------------------------------------- */

		class ScreenItem7Label: ScreenItemXLabel
		{
			idc = 3012;

			y = 21 * GUI_GRID_H + GUI_GRID_Y;     

			text = "Screen Item 7"; //--- ToDo: Localize;
		};

        class ScreenItem7: ScreenItemX
        {
            idc = 4012;

            y = 21 * GUI_GRID_H + GUI_GRID_Y;

            WR_screenItemIndex = 7;
        };

        class ScreenItem7Result: ScreenItemXResult
        {
            idc = 5012;

            y = 21 * GUI_GRID_H + GUI_GRID_Y;
        };
        
        /* ---------------------------------------- */

        class MyOk: RscButtonMenuOK
        {
            x = 37 * GUI_GRID_W + GUI_GRID_X;
            y = 23.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 3 * GUI_GRID_W;
            h = 1.5 * GUI_GRID_H;
        };

        class MyCancel: RscButtonMenuCancel
        {
            x = 31 * GUI_GRID_W + GUI_GRID_X;
            y = 23.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 5 * GUI_GRID_W;
            h = 1.5 * GUI_GRID_H;
        };
	};
};

/* ================================================================================ */

class ConfigureScreenImageItemDialog
{
	idd = 14632;
	enableSimulation = true;

    onUnload = "['onUnloadDialog', _this] call WR_main_fnc_ui_configureScreenImageItem;";

	class ControlsBackground
	{
        class Background: RscText
        {
            idc = 1001;

            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 0 * GUI_GRID_H + GUI_GRID_Y;
            w = 40 * GUI_GRID_W;
            h = 23 * GUI_GRID_H;

            colorBackground[] = {0.3, 0.3, 0.3, 1}; // opaque dark grey
        };
	};

	class Controls
	{
        class Headline: RscText
        {
            idc = 2001;

            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 0 * GUI_GRID_H + GUI_GRID_Y;
            w = 40 * GUI_GRID_W;
            h = 1.5 * GUI_GRID_H;

            colorBackground[] = {0, 0, 0, 1}; // opaque black
            text = "Configure Image Item"; //--- ToDo: Localize;
        };

		class ImageLabel: RscText
		{
			idc = 3001;
        
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
			text = "Image"; //--- ToDo: Localize;
            style = ST_RIGHT;
		};

        class Image: RscCombo
        {
            idc = 4001;

            x = 11 * GUI_GRID_W + GUI_GRID_X;
            y = 2 * GUI_GRID_H + GUI_GRID_Y;
            w = 28.5 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;

            onLBSelChanged = "['onLBSelChangedImage', _this] call WR_main_fnc_ui_configureScreenImageItem;";
        };

		class ImageDemoBackground: RscText
		{
			idc = 5000;

            x = 11 * GUI_GRID_W + GUI_GRID_X;
            y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 28.5 * GUI_GRID_W;
            h = 19 * GUI_GRID_H;

			colorBackground[] = {0.2, 0.2, 0.2, 1}; // opaque dark grey
		};

		class ImageDemo: RscPictureKeepAspect
		{
			idc = 5001;

            x = 11 * GUI_GRID_W + GUI_GRID_X;
            y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 28.5 * GUI_GRID_W;
            h = 19 * GUI_GRID_H;
		};

       class MyOk: RscButtonMenuOK
        {
            x = 37 * GUI_GRID_W + GUI_GRID_X;
            y = 23.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 3 * GUI_GRID_W;
            h = 1.5 * GUI_GRID_H;
        };

        class MyCancel: RscButtonMenuCancel
        {
            x = 31 * GUI_GRID_W + GUI_GRID_X;
            y = 23.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 5 * GUI_GRID_W;
            h = 1.5 * GUI_GRID_H;
        };
	};
};

/* ================================================================================ */

class ConfigureScreenTextItemDialog
{
	idd = 14633;
	enableSimulation = true;

    onUnload = "['onUnloadDialog', _this] call WR_main_fnc_ui_configureScreenTextItem;";

	class ControlsBackground
	{
        class Background: RscText
        {
            idc = 1001;

            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 0 * GUI_GRID_H + GUI_GRID_Y;
            w = 40 * GUI_GRID_W;
            h = 23 * GUI_GRID_H;

            colorBackground[] = {0.3, 0.3, 0.3, 1}; // opaque dark grey
        };
	};

	class Controls
	{
        class Headline: RscText
        {
            idc = 2001;

            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 0 * GUI_GRID_H + GUI_GRID_Y;
            w = 40 * GUI_GRID_W;
            h = 1.5 * GUI_GRID_H;

            colorBackground[] = {0, 0, 0, 1}; // opaque black
            text = "Configure Text Item"; //--- ToDo: Localize;
        };

		class HeadlineTextLabel: RscText
		{
			idc = 3001;
        
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
			text = "Headline"; //--- ToDo: Localize;
            style = ST_RIGHT;
		};

        class HeadlineText: RscEdit
        {
            idc = 4001;

            x = 11 * GUI_GRID_W + GUI_GRID_X;
            y = 2 * GUI_GRID_H + GUI_GRID_Y;
            w = 28.5 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;

			colorBackground[] = {0.2, 0.2, 0.2, 1}; // opaque dark grey
        };

		class TextLabel: RscText
		{
			idc = 3002;
        
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
			text = "Structured Text"; //--- ToDo: Localize;
            style = ST_RIGHT;
		};

        class Text: RscEdit
        {
            idc = 4002;

            x = 11 * GUI_GRID_W + GUI_GRID_X;
            y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 28.5 * GUI_GRID_W;
            h = 19 * GUI_GRID_H;

			colorBackground[] = {0.2, 0.2, 0.2, 1}; // opaque dark grey
			style = ST_MULTI;
			lineSpacing = 1;
        };

       class MyOk: RscButtonMenuOK
        {
            x = 37 * GUI_GRID_W + GUI_GRID_X;
            y = 23.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 3 * GUI_GRID_W;
            h = 1.5 * GUI_GRID_H;
        };

        class MyCancel: RscButtonMenuCancel
        {
            x = 31 * GUI_GRID_W + GUI_GRID_X;
            y = 23.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 5 * GUI_GRID_W;
            h = 1.5 * GUI_GRID_H;
        };
	};
};

/* ================================================================================ */

class ConfigureScreenMapItemDialog
{
	idd = 14634;
	enableSimulation = true;

    onUnload = "['onUnloadDialog', _this] call WR_main_fnc_ui_configureScreenMapItem;";

	class ControlsBackground
	{
        class Background: RscText
        {
            idc = 1001;

            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 0 * GUI_GRID_H + GUI_GRID_Y;
            w = 40 * GUI_GRID_W;
            h = 23 * GUI_GRID_H;

            colorBackground[] = {0.3, 0.3, 0.3, 1}; // opaque dark grey
        };
	};

	class Controls
	{
        class Headline: RscText
        {
            idc = 2001;

            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 0 * GUI_GRID_H + GUI_GRID_Y;
            w = 40 * GUI_GRID_W;
            h = 1.5 * GUI_GRID_H;

            colorBackground[] = {0, 0, 0, 1}; // opaque black
            text = "Configure Map Item"; //--- ToDo: Localize;
        };

		class MapCenterPositionLabel: RscText
		{
			idc = 3001;
        
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
			text = "Map Center Position"; //--- ToDo: Localize;
            style = ST_RIGHT;
		};

        class MapCenterPosition: RscText
        {
            idc = 4001;

            x = 11 * GUI_GRID_W + GUI_GRID_X;
            y = 2 * GUI_GRID_H + GUI_GRID_Y;
            w = 28.5 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };

		class MapZoomLabel: RscText
		{
			idc = 3002;
        
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
			text = "Map Zoom"; //--- ToDo: Localize;
            style = ST_RIGHT;
		};

        class MapZoom: RscXSliderH
        {
            idc = 4002;
            sliderPosition = 0;
            sliderRange[] = {0.001,1};
            sliderStep = 0.001;

            x = 11 * GUI_GRID_W + GUI_GRID_X;
            y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 28.5 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;

            onSliderPosChanged = "['onSliderPosChangedMapZoom', _this] call WR_main_fnc_ui_configureScreenMapItem;";
        };

		class MapDemoLabel: RscText
		{
			idc = 3003;
        
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
			text = "Map Demo"; //--- ToDo: Localize;
            style = ST_RIGHT;
		};

		class MapDemo: RscMapControl
		{
			idc = 5001;

            x = 11 * GUI_GRID_W + GUI_GRID_X;
            y = 5 * GUI_GRID_H + GUI_GRID_Y;
            w = 28.5 * GUI_GRID_W;
            h = 17.5 * GUI_GRID_H;

            onMouseButtonUp = "['onMouseButtonUpMap', _this] call WR_main_fnc_ui_configureScreenMapItem;";
            onMouseZChanged = "['onMouseZChangedMap', _this] call WR_main_fnc_ui_configureScreenMapItem;";
		};

       class MyOk: RscButtonMenuOK
        {
            x = 37 * GUI_GRID_W + GUI_GRID_X;
            y = 23.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 3 * GUI_GRID_W;
            h = 1.5 * GUI_GRID_H;
        };

        class MyCancel: RscButtonMenuCancel
        {
            x = 31 * GUI_GRID_W + GUI_GRID_X;
            y = 23.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 5 * GUI_GRID_W;
            h = 1.5 * GUI_GRID_H;
        };
	};
};

/* ================================================================================ */

class ConfigureScreenCamItemDialog
{
	idd = 14635;
	enableSimulation = true;

    onUnload = "['onUnloadDialog', _this] call WR_main_fnc_ui_configureScreenCamItem;";

	class ControlsBackground
	{
        class Background: RscText
        {
            idc = 1001;

            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 0 * GUI_GRID_H + GUI_GRID_Y;
            w = 40 * GUI_GRID_W;
            h = 23 * GUI_GRID_H;

            colorBackground[] = {0.3, 0.3, 0.3, 1}; // opaque dark grey
        };
	};

	class Controls
	{
        class Headline: RscText
        {
            idc = 2001;

            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 0 * GUI_GRID_H + GUI_GRID_Y;
            w = 40 * GUI_GRID_W;
            h = 1.5 * GUI_GRID_H;

            colorBackground[] = {0, 0, 0, 1}; // opaque black
            text = "Configure Cam Item"; //--- ToDo: Localize;
        };

		class CamLabel: RscText
		{
			idc = 3001;
        
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
			text = "Cam"; //--- ToDo: Localize;
            style = ST_RIGHT;
		};

        class Cam: RscCombo
        {
            idc = 4001;

            x = 11 * GUI_GRID_W + GUI_GRID_X;
            y = 2 * GUI_GRID_H + GUI_GRID_Y;
            w = 28.5 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;

            onLBSelChanged = "['onLBSelChangedCam', _this] call WR_main_fnc_ui_configureScreenCamItem;";
        };

		class CamDemo: RscPicture
		{
			idc = 5001;

            x = 11 * GUI_GRID_W + GUI_GRID_X;
            y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 28.5 * GUI_GRID_W;
            h = 19 * GUI_GRID_H;
		};

       class MyOk: RscButtonMenuOK
        {
            x = 37 * GUI_GRID_W + GUI_GRID_X;
            y = 23.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 3 * GUI_GRID_W;
            h = 1.5 * GUI_GRID_H;
        };

        class MyCancel: RscButtonMenuCancel
        {
            x = 31 * GUI_GRID_W + GUI_GRID_X;
            y = 23.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 5 * GUI_GRID_W;
            h = 1.5 * GUI_GRID_H;
        };
	};
};

/* ================================================================================ */

class WarRoomTemplate40by25
{
	idd = -1;

	enableSimulation = true;

	WR_uiScreenItemCount = -1;

    class ControlsBackground
    {
        class BackgroundColor: RscText
        {
            idc = 1001;
        
            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 0 * GUI_GRID_H + GUI_GRID_Y;
            w = 40 * GUI_GRID_W;
            h = 25 * GUI_GRID_H;
        
            colorBackground[] = {0, 0, 0, 1}; // opaque black
        };

        class Headline: RscText
        {
            idc = 2001;

            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 0 * GUI_GRID_H + GUI_GRID_Y;
            w = 40 * GUI_GRID_W;
            h = 3 * GUI_GRID_H;

            colorBackground[] = {0.2, 0.2, 0.2, 1}; // opaque dark grey
            sizeEx = 1.5 * GUI_GRID_H;
        };

        class Subheadline: RscText
        {
            idc = 7001;

            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 23 * GUI_GRID_H + GUI_GRID_Y;
            w = 40 * GUI_GRID_W;
            h = 2 * GUI_GRID_H;

            colorBackground[] = {0.2, 0.2, 0.2, 1}; // opaque dark grey
        };

        class Pos1: RscText
        {
            idc = 9001;

            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 0 * GUI_GRID_H + GUI_GRID_Y;
            w = 1 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;

            colorBackground[] = {1, 0, 0, 1}; // opaque red
        };

        class Pos2: RscText
        {
            idc = 9002;

            x = 39 * GUI_GRID_W + GUI_GRID_X;
            y = 0 * GUI_GRID_H + GUI_GRID_Y;
            w = 1 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;

            colorBackground[] = {1, 0, 0, 1}; // opaque red
        };

        class Pos3: RscText
        {
            idc = 9003;

            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 24 * GUI_GRID_H + GUI_GRID_Y;
            w = 1 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;

            colorBackground[] = {1, 0, 0, 1}; // opaque red
        };

        class Pos4: RscText
        {
            idc = 9004;

            x = 39 * GUI_GRID_W + GUI_GRID_X;
            y = 24 * GUI_GRID_H + GUI_GRID_Y;
            w = 1 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;

            colorBackground[] = {1, 0, 0, 1}; // opaque red
        };
    };
};

/* ================================================================================ */

class WarRoomTemplate40by25Mod1
{
    // 40x25 cropped to 22x25

	idd = -1;

	enableSimulation = true;

	WR_uiScreenItemCount = -1;

    class ControlsBackground
    {
        class BackgroundColor: RscText
        {
            idc = 1001;
        
            x = 9 * GUI_GRID_W + GUI_GRID_X;
            y = 0 * GUI_GRID_H + GUI_GRID_Y;
            w = 22 * GUI_GRID_W;
            h = 25 * GUI_GRID_H;
        
            colorBackground[] = {0, 0, 0, 1}; // opaque black
        };

        class Headline: RscText
        {
            idc = 2001;

            x = 9 * GUI_GRID_W + GUI_GRID_X;
            y = 0 * GUI_GRID_H + GUI_GRID_Y;
            w = 22 * GUI_GRID_W;
            h = 3 * GUI_GRID_H;

            colorBackground[] = {0.2, 0.2, 0.2, 1}; // opaque dark grey
            sizeEx = 1.5 * GUI_GRID_H;
        };

        class Subheadline: RscText
        {
            idc = 7001;

            x = 9 * GUI_GRID_W + GUI_GRID_X;
            y = 23 * GUI_GRID_H + GUI_GRID_Y;
            w = 22 * GUI_GRID_W;
            h = 2 * GUI_GRID_H;

            colorBackground[] = {0.2, 0.2, 0.2, 1}; // opaque dark grey
        };

        class Pos1: RscText
        {
            idc = 9001;

            x = 9 * GUI_GRID_W + GUI_GRID_X;
            y = 0 * GUI_GRID_H + GUI_GRID_Y;
            w = 1 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;

            colorBackground[] = {1, 0, 0, 1}; // opaque red
        };

        class Pos2: RscText
        {
            idc = 9002;

            x = 30 * GUI_GRID_W + GUI_GRID_X;
            y = 0 * GUI_GRID_H + GUI_GRID_Y;
            w = 1 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;

            colorBackground[] = {1, 0, 0, 1}; // opaque red
        };

        class Pos3: RscText
        {
            idc = 9003;

            x = 9 * GUI_GRID_W + GUI_GRID_X;
            y = 24 * GUI_GRID_H + GUI_GRID_Y;
            w = 1 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;

            colorBackground[] = {1, 0, 0, 1}; // opaque red
        };

        class Pos4: RscText
        {
            idc = 9004;

            x = 30 * GUI_GRID_W + GUI_GRID_X;
            y = 24 * GUI_GRID_H + GUI_GRID_Y;
            w = 1 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;

            colorBackground[] = {1, 0, 0, 1}; // opaque red
        };
    };
};

/* ================================================================================ */

class WarRoomTemplate40by25Mod2
{
    // 40x25 cropped to 40x15

	idd = -1;

	enableSimulation = true;

	WR_uiScreenItemCount = -1;

    class ControlsBackground
    {
        class BackgroundColor: RscText
        {
            idc = 1001;
        
            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 5 * GUI_GRID_H + GUI_GRID_Y;
            w = 40 * GUI_GRID_W;
            h = 15 * GUI_GRID_H;
        
            colorBackground[] = {0, 0, 0, 1}; // opaque black
        };

        class Headline: RscText
        {
            idc = 2001;

            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 5 * GUI_GRID_H + GUI_GRID_Y;
            w = 40 * GUI_GRID_W;
            h = 3 * GUI_GRID_H;

            colorBackground[] = {0.2, 0.2, 0.2, 1}; // opaque dark grey
            sizeEx = 1.5 * GUI_GRID_H;
        };

        class Subheadline: RscText
        {
            idc = 7001;

            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 18 * GUI_GRID_H + GUI_GRID_Y;
            w = 40 * GUI_GRID_W;
            h = 2 * GUI_GRID_H;

            colorBackground[] = {0.2, 0.2, 0.2, 1}; // opaque dark grey
        };

        class Pos1: RscText
        {
            idc = 9001;

            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 5 * GUI_GRID_H + GUI_GRID_Y;
            w = 1 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;

            colorBackground[] = {1, 0, 0, 1}; // opaque red
        };

        class Pos2: RscText
        {
            idc = 9002;

            x = 39 * GUI_GRID_W + GUI_GRID_X;
            y = 5 * GUI_GRID_H + GUI_GRID_Y;
            w = 1 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;

            colorBackground[] = {1, 0, 0, 1}; // opaque red
        };

        class Pos3: RscText
        {
            idc = 9003;

            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 19 * GUI_GRID_H + GUI_GRID_Y;
            w = 1 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;

            colorBackground[] = {1, 0, 0, 1}; // opaque red
        };

        class Pos4: RscText
        {
            idc = 9004;

            x = 39 * GUI_GRID_W + GUI_GRID_X;
            y = 19 * GUI_GRID_H + GUI_GRID_Y;
            w = 1 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;

            colorBackground[] = {1, 0, 0, 1}; // opaque red
        };
    };
};

/* ================================================================================ */

class WarRoomTemplate40by25Mod3
{
    // 40x25 cropped to 40x11

	idd = -1;

	enableSimulation = true;

	WR_uiScreenItemCount = -1;

    class ControlsBackground
    {
        class BackgroundColor: RscText
        {
            idc = 1001;
        
            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 1 * GUI_GRID_H + GUI_GRID_Y;
            w = 40 * GUI_GRID_W;
            h = 11 * GUI_GRID_H;
        
            colorBackground[] = {0, 0, 0, 1}; // opaque black
        };

        class Headline: RscText
        {
            idc = 2001;

            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 1 * GUI_GRID_H + GUI_GRID_Y;
            w = 40 * GUI_GRID_W;
            h = 3 * GUI_GRID_H;

            colorBackground[] = {0.2, 0.2, 0.2, 1}; // opaque dark grey
            sizeEx = 1.5 * GUI_GRID_H;
        };

        class Subheadline: RscText
        {
            idc = 7001;

            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 10 * GUI_GRID_H + GUI_GRID_Y;
            w = 40 * GUI_GRID_W;
            h = 2 * GUI_GRID_H;

            colorBackground[] = {0.2, 0.2, 0.2, 1}; // opaque dark grey
        };

        class Pos1: RscText
        {
            idc = 9001;

            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 1 * GUI_GRID_H + GUI_GRID_Y;
            w = 1 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;

            colorBackground[] = {1, 0, 0, 1}; // opaque red
        };

        class Pos2: RscText
        {
            idc = 9002;

            x = 39 * GUI_GRID_W + GUI_GRID_X;
            y = 1 * GUI_GRID_H + GUI_GRID_Y;
            w = 1 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;

            colorBackground[] = {1, 0, 0, 1}; // opaque red
        };

        class Pos3: RscText
        {
            idc = 9003;

            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 11 * GUI_GRID_H + GUI_GRID_Y;
            w = 1 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;

            colorBackground[] = {1, 0, 0, 1}; // opaque red
        };

        class Pos4: RscText
        {
            idc = 9004;

            x = 39 * GUI_GRID_W + GUI_GRID_X;
            y = 11 * GUI_GRID_H + GUI_GRID_Y;
            w = 1 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;

            colorBackground[] = {1, 0, 0, 1}; // opaque red
        };
    };
};

/* ================================================================================ */

class WarRoom1: WarRoomTemplate40by25
{
	idd = 14641;

	WR_uiScreenItemCount = 1;

	class Controls
	{
		class ScreenItem0: RscPicture
		{
			idc = 3000;

			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 40 * GUI_GRID_W;
			h = 20 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem0_1024x1024.paa";
		};

		class ScreenItem0Infobox: RscText
		{
			idc = 5000;
        
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 40 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 0 Info";
		};
	};
};

/* ================================================================================ */

class WarRoom1Mod1: WarRoomTemplate40by25Mod1
{
	idd = 14641;

	WR_uiScreenItemCount = 1;

	class Controls
	{
		class ScreenItem0: RscPicture
		{
			idc = 3000;

			x = 9 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 22 * GUI_GRID_W;
			h = 20 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem0_1024x1024.paa";
		};

		class ScreenItem0Infobox: RscText
		{
			idc = 5000;
        
			x = 9 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 22 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 0 Info";
		};
	};
};

/* ================================================================================ */

class WarRoom1Mod2: WarRoomTemplate40by25Mod2
{
	idd = 14641;

	WR_uiScreenItemCount = 1;

	class Controls
	{
		class ScreenItem0: RscPicture
		{
			idc = 3000;

			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 8 * GUI_GRID_H + GUI_GRID_Y;
			w = 40 * GUI_GRID_W;
			h = 10 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem0_1024x1024.paa";
		};

		class ScreenItem0Infobox: RscText
		{
			idc = 5000;
        
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 8 * GUI_GRID_H + GUI_GRID_Y;
			w = 40 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 0 Info";
		};
	};
};

/* ================================================================================ */

class WarRoom1Mod3: WarRoomTemplate40by25Mod3
{
	idd = 14641;

	WR_uiScreenItemCount = 1;

	class Controls
	{
		class ScreenItem0: RscPicture
		{
			idc = 3000;

			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 40 * GUI_GRID_W;
			h = 6 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem0_1024x1024.paa";
		};

		class ScreenItem0Infobox: RscText
		{
			idc = 5000;
        
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 40 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 0 Info";
		};
	};
};

/* ================================================================================ */

class WarRoom2: WarRoomTemplate40by25
{
	idd = 14642;

	WR_uiScreenItemCount = 2;

	class Controls
	{
		class ScreenItem0: RscPicture
		{
			idc = 3000;

			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 20 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem0_1024x1024.paa";
		};

		class ScreenItem0Infobox: RscText
		{
			idc = 5000;
        
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 0 Info";
		};

		class ScreenItem1: RscPicture
		{
			idc = 3001;

			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 20 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem1_1024x1024.paa";
		};

		class ScreenItem1Infobox: RscText
		{
			idc = 5001;
        
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 1 Info";
		};
	};
};

/* ================================================================================ */

class WarRoom2Mod2: WarRoomTemplate40by25Mod2
{
	idd = 14642;

	WR_uiScreenItemCount = 2;

	class Controls
	{
		class ScreenItem0: RscPicture
		{
			idc = 3000;

			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 8 * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 10 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem0_1024x1024.paa";
		};

		class ScreenItem0Infobox: RscText
		{
			idc = 5000;
        
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 8 * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 0 Info";
		};

		class ScreenItem1: RscPicture
		{
			idc = 3001;

			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 8 * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 10 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem1_1024x1024.paa";
		};

		class ScreenItem1Infobox: RscText
		{
			idc = 5001;
        
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 8 * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 1 Info";
		};
	};
};

/* ================================================================================ */

class WarRoom2Mod3: WarRoomTemplate40by25Mod3
{
	idd = 14642;

	WR_uiScreenItemCount = 2;

	class Controls
	{
		class ScreenItem0: RscPicture
		{
			idc = 3000;

			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 6 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem0_1024x1024.paa";
		};

		class ScreenItem0Infobox: RscText
		{
			idc = 5000;
        
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 0 Info";
		};

		class ScreenItem1: RscPicture
		{
			idc = 3001;

			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 6 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem1_1024x1024.paa";
		};

		class ScreenItem1Infobox: RscText
		{
			idc = 5001;
        
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 1 Info";
		};
	};
};

/* ================================================================================ */

class WarRoom3: WarRoomTemplate40by25
{
	idd = 14643;

	WR_uiScreenItemCount = 5;

	class Controls
	{
		class ScreenItem0: RscPicture
		{
			idc = 3000;

			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 20 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem0_1024x1024.paa";
		};

		class ScreenItem0Infobox: RscText
		{
			idc = 5000;
        
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 0 Info";
		};

		class ScreenItem1: RscPicture
		{
			idc = 3001;

			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 10 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem1_1024x1024.paa";
		};

		class ScreenItem1Infobox: RscText
		{
			idc = 5001;
        
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 1 Info";
		};

		class ScreenItem2: RscPicture
		{
			idc = 3002;

			x = 30 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 10 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem2_1024x1024.paa";
		};

		class ScreenItem2Infobox: RscText
		{
			idc = 5002;
        
			x = 30 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 2 Info";
		};

		class ScreenItem3: RscPicture
		{
			idc = 3003;

			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 10 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem3_1024x1024.paa";
		};

		class ScreenItem3Infobox: RscText
		{
			idc = 5003;
        
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 3 Info";
		};

		class ScreenItem4: RscPicture
		{
			idc = 3004;

			x = 30 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 10 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem4_1024x1024.paa";
		};

		class ScreenItem4Infobox: RscText
		{
			idc = 5004;
        
			x = 30 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 4 Info";
		};
	};
};

/* ================================================================================ */

class WarRoom4: WarRoomTemplate40by25
{
	idd = 14644;

	WR_uiScreenItemCount = 8;

	class Controls
	{
		class ScreenItem0: RscPicture
		{
			idc = 3000;

			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 10 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem0_1024x1024.paa";
		};

		class ScreenItem0Infobox: RscText
		{
			idc = 5000;
        
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 0 Info";
		};

		class ScreenItem1: RscPicture
		{
			idc = 3001;

			x = 10 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 10 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem1_1024x1024.paa";
		};

		class ScreenItem1Infobox: RscText
		{
			idc = 5001;
        
			x = 10 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 1 Info";
		};

		class ScreenItem2: RscPicture
		{
			idc = 3002;

			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 10 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem2_1024x1024.paa";
		};

		class ScreenItem2Infobox: RscText
		{
			idc = 5002;
        
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 2 Info";
		};

		class ScreenItem3: RscPicture
		{
			idc = 3003;

			x = 30 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 10 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem3_1024x1024.paa";
		};

		class ScreenItem3Infobox: RscText
		{
			idc = 5003;
        
			x = 30 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 3 Info";
		};

		class ScreenItem4: RscPicture
		{
			idc = 3004;

			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 10 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem4_1024x1024.paa";
		};

		class ScreenItem4Infobox: RscText
		{
			idc = 5004;
        
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 4 Info";
		};

		class ScreenItem5: RscPicture
		{
			idc = 3005;

			x = 10 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 10 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem5_1024x1024.paa";
		};

		class ScreenItem5Infobox: RscText
		{
			idc = 5005;
        
			x = 10 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 5 Info";
		};

		class ScreenItem6: RscPicture
		{
			idc = 3006;

			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 10 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem6_1024x1024.paa";
		};

		class ScreenItem6Infobox: RscText
		{
			idc = 5006;
        
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 6 Info";
		};

		class ScreenItem7: RscPicture
		{
			idc = 3007;

			x = 30 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 10 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem7_1024x1024.paa";
		};

		class ScreenItem7Infobox: RscText
		{
			idc = 5007;
        
			x = 30 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 7 Info";
		};
	};
};

/* ================================================================================ */

class WarRoom5: WarRoomTemplate40by25
{
	idd = 14645;

	WR_uiScreenItemCount = 3;

	class Controls
	{
		class ScreenItem0: RscPicture
		{
			idc = 3000;

			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 30 * GUI_GRID_W;
			h = 20 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem0_1024x1024.paa";
		};

		class ScreenItem1: RscPicture
		{
			idc = 3001;

			x = 30 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 10 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem1_1024x1024.paa";
		};

		class ScreenItem2: RscPicture
		{
			idc = 3002;

			x = 30 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 10 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem2_1024x1024.paa";
		};

		class ScreenItem0Infobox: RscText
		{
			idc = 5000;
        
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 40 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
        
			text = "Screen Item 0 Info";
		};

		class ScreenItem1Infobox: RscText
		{
			idc = 5001;

			x = 30 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;

            colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 1 Info";
		};

		class ScreenItem2Infobox: RscText
		{
			idc = 5002;

			x = 30 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			
            colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 2 Info";
		};
	};
};

/* ================================================================================ */

class WarRoom7Mod1: WarRoomTemplate40by25Mod1
{
	idd = 14647;

	WR_uiScreenItemCount = 2;

	class Controls
	{
		class ScreenItem0: RscPicture
		{
			idc = 3000;

			x = 9 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 22 * GUI_GRID_W;
			h = 10 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem0_1024x1024.paa";
		};

		class ScreenItem0Infobox: RscText
		{
			idc = 5000;
        
			x = 9 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 22 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 0 Info";
		};

		class ScreenItem1: RscPicture
		{
			idc = 3001;

			x = 9 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 22 * GUI_GRID_W;
			h = 10 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem1_1024x1024.paa";
		};

		class ScreenItem1Infobox: RscText
		{
			idc = 5001;
        
			x = 9 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 22 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 1 Info";
		};
	};
};

/* ================================================================================ */

class WarRoom8Mod3: WarRoomTemplate40by25Mod3
{
	idd = 14648;

	WR_uiScreenItemCount = 4;

	class Controls
	{
		class ScreenItem0: RscPicture
		{
			idc = 3000;

			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 6 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem0_1024x1024.paa";
		};

		class ScreenItem0Infobox: RscText
		{
			idc = 5000;
        
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 0 Info";
		};

		class ScreenItem1: RscPicture
		{
			idc = 3001;

			x = 10 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 6 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem1_1024x1024.paa";
		};

		class ScreenItem1Infobox: RscText
		{
			idc = 5001;
        
			x = 10 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 1 Info";
		};

		class ScreenItem2: RscPicture
		{
			idc = 3002;

			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 6 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem2_1024x1024.paa";
		};

		class ScreenItem2Infobox: RscText
		{
			idc = 5002;
        
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 2 Info";
		};

		class ScreenItem3: RscPicture
		{
			idc = 3003;

			x = 30 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 6 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_ScreenItem3_1024x1024.paa";
		};

		class ScreenItem3Infobox: RscText
		{
			idc = 5003;
        
			x = 30 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
        
        	colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "Screen Item 3 Info";
		};
	};
};

/* ================================================================================ */