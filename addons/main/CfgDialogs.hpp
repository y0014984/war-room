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
class RscMapControl;
class RscPicture;

/* ================================================================================ */

class WarRoom5
{
	idd = 14642;
	enableSimulation = true;

	class controlsBackground
	{
        class Background: RscText
        {
            idc = 1001;

            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 0 * GUI_GRID_H + GUI_GRID_Y;
            w = 40 * GUI_GRID_W;
            h = 25 * GUI_GRID_H;

            colorBackground[] = {0, 0, 0, 1}; // opaque black
        };
	};

	class controls
	{
        class Headline: RscText
        {
            idc = 2001;

            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 0 * GUI_GRID_H + GUI_GRID_Y;
            w = 40 * GUI_GRID_W;
            h = 3 * GUI_GRID_H;

            colorBackground[] = {0.2, 0.2, 0.2, 1}; // opaque dark grey
            sizeEx = 1.5 * GUI_GRID_H;
            text = "War Room"; //--- ToDo: Localize;
        };

		//class Map: RscMapControl
		//{
		//	idc = 3001;
//
		//	x = 0 * GUI_GRID_W + GUI_GRID_X;
		//	y = 3 * GUI_GRID_H + GUI_GRID_Y;
		//	w = 30 * GUI_GRID_W;
		//	h = 20 * GUI_GRID_H;
		//};

		//class UAV1: RscPicture
		//{
		//	idc = 3002;
//
		//	x = 30 * GUI_GRID_W + GUI_GRID_X;
		//	y = 3 * GUI_GRID_H + GUI_GRID_Y;
		//	w = 10 * GUI_GRID_W;
		//	h = 10 * GUI_GRID_H;
		//};

		//class UAV2: RscPicture
		//{
		//	idc = 3003;
//
		//	x = 30 * GUI_GRID_W + GUI_GRID_X;
		//	y = 13 * GUI_GRID_H + GUI_GRID_Y;
		//	w = 10 * GUI_GRID_W;
		//	h = 10 * GUI_GRID_H;
		//};

		class Placeholder1: RscPicture
		{
			idc = 3001;

			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 30 * GUI_GRID_W;
			h = 20 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_Placeholder1_1024x1024.paa";
		};

		class Placeholder2: RscPicture
		{
			idc = 3002;

			x = 30 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 10 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_Placeholder2_1024x1024.paa";
		};

		class Placeholder3: RscPicture
		{
			idc = 3003;

			x = 30 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 10 * GUI_GRID_H;

            text = "\y\wr\addons\main\ui\WarRoom_Placeholder3_1024x1024.paa";
		};



		//class MapHeadline: RscText
		//{
		//	idc = 5001;
        //
		//	x = 0 * GUI_GRID_W + GUI_GRID_X;
		//	y = 1.5 * GUI_GRID_H + GUI_GRID_Y;
		//	w = 24 * GUI_GRID_W;
		//	h = 1 * GUI_GRID_H;
        //
        //  colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
        //
		//	text = "Map";
		//};

		class UAV1Headline: RscText
		{
			idc = 5002;

			x = 30 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;

            colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "UAV 1";
		};

		class UAV2Headline: RscText
		{
			idc = 5003;

			x = 30 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			
            colorBackground[] = {0.2, 0.2, 0.2, 0.5}; // translucent grey
			text = "UAV 2";
		};

        class Subheadline: RscText
        {
            idc = 6001;

            x = 0 * GUI_GRID_W + GUI_GRID_X;
            y = 23 * GUI_GRID_H + GUI_GRID_Y;
            w = 40 * GUI_GRID_W;
            h = 2 * GUI_GRID_H;

            colorBackground[] = {0.2, 0.2, 0.2, 1}; // opaque dark grey
            text = "Mod v0.1.0 by y0014984"; //--- ToDo: Localize;
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