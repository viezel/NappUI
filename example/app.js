
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
