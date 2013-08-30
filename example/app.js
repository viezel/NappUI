
var NappUI = require("dk.napp.ui");


var window = Ti.UI.createWindow({
	backgroundColor:"#FFF",
	blur:1
});


var blurSlider = Ti.UI.createSlider({
	top : 120,
	min : 0,
	max : 1,
	width : 280,
	value : 1
});
blurSlider.addEventListener('touchend', function(e) {
	window.setBlur(e.value);
});
window.add(blurSlider);

var view = Ti.UI.createView({
	backgroundColor: '#999',
    height: 50,
    width: 50,
    shadow: {
        shadowColor: '#000',
        shadowRadius: 10,
        shadowOffset: { x: 5, y: 5 },
        shadowOpacity: 1
    },
    top: 15
});

var picker = Ti.UI.createPicker({
	bottom: 5,
    mask:{
        left:14,
        top:10,
        width:293,
        height:196
    }
});

var data = [];
data[0]=Ti.UI.createPickerRow({title:'Bananas'});
data[1]=Ti.UI.createPickerRow({title:'Strawberries'});
data[2]=Ti.UI.createPickerRow({title:'Mangos'});
data[3]=Ti.UI.createPickerRow({title:'Grapes'});
picker.add(data);
picker.selectionIndicator = true;


var string = "Hello world. This is an addition by @dezinezync #winning. Coming soon to the NappUI module.";

var label = Ti.UI.createLabel({
	width: 290,
    top: 15,
	left: 15,
    text: string,
    font: {
		fontFamily: "Avenir-Roman",
		fontSize: 16
	},
    attributedText: {
    	text: string,
    	attributes: [{
			text: "@dezinezync",
    		font: {
    			fontFamily: "Avenir-Medium",
    			fontSize: 16
    		},
    		color: "#6161f2"
    	}, {
    		text: "#winning",
    		font: {
    			fontFamily: "Avenir-Light",
    			fontSize: 16
    		},
    		color: "blue"
    	}, {
    		text: "NappUI module",
    		font: {
    			fontFamily: "HelveticaNeue-Bold",
    			fontSize: 16
    		}
    	}, {
    		text: "Coming",
    		underline: 1, //single line,
    		font: {
    			fontFamily: "HelveticaNeue-BoldItalic",
    			// fontSize will get inheirted from the parent style
    		}
    	}, {
    		text: "soon",
    		underline: 2 //double line
    	}, {
    		text: "to",
    		underline: 3 //bold line
    	}, {
    		text: "the",
    		underline: 4, //bold(er) line
    		backgroundColor: "#aaaaaa"
    	}]
    }
});

window.add(label);


window.add(picker);
window.add(view);
window.open();


/*
// Navigation Group - popToRoot() test

function makeWindowTest(){
	count++;
	var backToRoot = Ti.UI.createButton({title:"Get Back"});
	backToRoot.addEventListener("click", letsGetAllBack);
	
	var newWin = Ti.UI.createWindow({
		backgroundColor:"white",
		title: "win " + count,
		rightNavButton:backToRoot
	});

	var push = Ti.UI.createButton({title:"Push new window"});
	push.addEventListener("click", makeWindowTest);
	newWin.add(push);
	navGroup.open(newWin);
}
function letsGetAllBack(){
	navGroup.popToRoot();
	count = 0;
}
var count = 0;
var base = Ti.UI.createWindow();
var win = Ti.UI.createWindow({
	title:"win "+count, 
	backgroundColor:"white"
});

var push = Ti.UI.createButton({title:"Push new window"});
push.addEventListener("click", makeWindowTest);
win.add(push);
var navGroup = Ti.UI.iPhone.createNavigationGroup({
	window:win
});
base.add(navGroup);
base.open();

*/
