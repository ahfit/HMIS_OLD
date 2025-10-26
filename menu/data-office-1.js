/*
   Deluxe Menu Data File
   Created by Deluxe Tuner v2.4
   http://deluxe-menu.com
*/


// -- Deluxe Tuner Style Names
var itemStylesNames=["Individual Style",];
var menuStylesNames=["Individual Style",];
// -- End of Deluxe Tuner Style Names

//--- Common
var isHorizontal=1;
var smColumns=1;
var smOrientation=0;
var smViewType=0;
var dmRTL=0;
var pressedItem=-2;
var itemCursor="pointer";
var itemTarget="_self";
var statusString="link";
var blankImage="images/blank.gif";

//--- Dimensions
var menuWidth="";
var menuHeight="";
var smWidth="";
var smHeight="";

//--- Positioning
var absolutePos=0;
var posX="10";
var posY="10";
var topDX=0;
var topDY=1;
var DX=1;
var DY=0;

//--- Font
var fontStyle="normal 11px Tahoma";
var fontColor=["#000000","#FFFFFF"];
var fontDecoration=["none","none"];
var fontColorDisabled="#AAAAAA";

//--- Appearance
var menuBackColor="";
var menuBackImage="";
var menuBackRepeat="repeat";
var menuBorderColor="";
var menuBorderWidth=0;
var menuBorderStyle="solid";

//--- Item Appearance
var itemBackColor=["",""];
var itemBackImage=["",""];
var itemBorderWidth=0;
var itemBorderColor=["#FCEEB0","#4C99AB"];
var itemBorderStyle=["solid","solid"];
var itemSpacing=1;
var itemPadding="3";
var itemAlignTop="left";
var itemAlign="left";
var subMenuAlign="";

//--- Icons
var iconTopWidth=16;
var iconTopHeight=16;
var iconWidth=18;
var iconHeight=18;
var arrowWidth=20;
var arrowHeight=15;
var arrowImageMain=["",""];
var arrowImageSub=["images/nav-arrow-right.gif","images/nav-arrow-right-hover.gif"];

//--- Separators
var separatorImage="images/sep_grey.gif";
var separatorWidth="80%";
var separatorHeight="3";
var separatorAlignment="right";
var separatorVImage="";
var separatorVWidth="3";
var separatorVHeight="100%";

//--- Floatable Menu
var floatable=0;
var floatIterations=6;
var floatableX=1;
var floatableY=1;

//--- Movable Menu
var movable=0;
var moveWidth=12;
var moveHeight=20;
var moveColor="#DECA9A";
var moveImage="";
var moveCursor="move";
var smMovable=0;
var closeBtnW=15;
var closeBtnH=15;
var closeBtn="";

//--- Transitional Effects & Filters
var transparency="100";
var transition=24;
var transOptions="";
var transDuration=350;
var transDuration2=200;
var shadowLen=1;
var shadowColor="#B1B1B1";
var shadowTop=0;

//--- CSS Support (CSS-based Menu)
var cssStyle=1;
var cssSubmenu="submenu1";
var cssItem=["item1","item2"];
var cssItemText=["text1","text2"];

//--- Advanced
var dmObjectsCheck=0;
var saveNavigationPath=1;
var showByClick=0;
var noWrap=1;
var pathPrefix_img="";
var pathPrefix_link="";
var smShowPause=200;
var smHidePause=1000;
var smSmartScroll=1;
var smHideOnClick=1;
var dm_writeAll=0;

//--- AJAX-like Technology
var dmAJAX=0;
var dmAJAXCount=0;

//--- Dynamic Menu
var dynamic=0;

//--- Keystrokes Support
var keystrokes=1;
var dm_focus=1;
var dm_actKey=113;

var itemStyles = [
    ["CSS=topitem1,topitem2","CSSText=toptext1,toptext2"],
];
var menuStyles = [
    ["CSS=topsubmenu"],
];

var menuItems = [

    ["Home","javascript:changeIframeSrc('holder1', 'Reception_Main.aspx')", , , , , "0", "0", , ],
    ["Administration Structure","", , , , , "0", "0", , ],
   
    ["|Facilities","javascript:changeIframeSrc('holder1', 'Reception_Main.aspx')", , , , , , , , ],
    ["|Facilities","", , , , , , , , ],
    ["|Facilities","", , , , , , , , ],   
    ["|Facilities","", , , , , , , , ],
	  
	



];

dm_init();
