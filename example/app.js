var NappUI = require("dk.napp.ui");

var window = Ti.UI.createWindow({
    backgroundColor: "#FFF",
    blur: 1
});

var blurSlider = Ti.UI.createSlider({
    top: 120,
    min: 0,
    max: 1,
    width: 280,
    value: 1
});
blurSlider.addEventListener('touchend', function(e) {
    window.setBlur(e.value);
});
window.add(blurSlider);

//Static Blur
var staticBlurIndex = 0,
    staticBlurButton = Ti.UI.createButton({
        title: "Apply Static Blur",
        top: 160
    });

staticBlurButton.addEventListener("click", function() {

    if (staticBlurIndex > 4) { //We only have 4 possible values and a neutral value
        staticBlurIndex = 0; //Reset our counter back to 0
    }

    var type;

    if (staticBlurIndex < 4) {
        if (staticBlurIndex == 0) type = "light";
        else if (staticBlurIndex == 1) type = "extra light";
        else if (staticBlurIndex == 2) type = "dark";
        else if (staticBlurIndex == 3) type = "tint";

        window.setStaticBlur({
            enabled: true,
            type: type,
            tint: staticBlurIndex == 3 ? "#00ff00" : null //Green tint 
            //(note that alpha value for the tint doesn't work. It's wrapped to use full alpha) 
            //(Release the HULK!)
        });
    } else {

        //Reset it
        window.setStaticBlur({
            enabled: false
        });

    }

    //Increment our blur counter
    staticBlurIndex++;

});

window.add(staticBlurButton);

var view = Ti.UI.createView({
    backgroundColor: '#999',
    height: 50,
    width: 50,
    shadow: {
        shadowColor: '#000',
        shadowRadius: 10,
        shadowOffset: {
            x: 5,
            y: 5
        },
        shadowOpacity: 1
    },
    top: 10
});


/*
//
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
*/

/*
var webview = Ti.UI.createWebView({
	url: 'https://github.com/viezel/NappUI',
	scalesPageToFit: true
});

webview.setCustomHeaders({"x-custom-1": "custom-value-1", "x-custom-2": "custom-value-2"});
*/

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




// example of the pan gesture.. 

/*var image = Ti.UI.createImageView({
	image:'/Default.png',
	width:160,
	height:240,
	left:10,
	top:10,
	panGesture:true, //custom property from Napp UI
	pinchGesture: true, //custom property from Napp UI
	recognizeSimultaneously:"pinching,panning" //custom property from Napp UI
});
window.add(image);

var currentTranslation = {x:0.0, y:0.0};
var lastTranslation = {x:0.0, y:0.0};
var transform = Ti.UI.create2DMatrix();

function updateTransform(image){
	transform.tx = lastTranslation.x+currentTranslation.x;
	transform.ty = lastTranslation.y+currentTranslation.y;
	image.transform = transform;
};

image.addEventListener('pan', function(e){
	currentTranslation.x = e.translation.x;
	currentTranslation.y = e.translation.y;
	//Ti.API.info("x: " + currentTranslation.x + " y: " + currentTranslation.y);
	updateTransform(image);
});

image.addEventListener('panend', function(e){
	lastTranslation.x = lastTranslation.x + currentTranslation.x;
	lastTranslation.y = lastTranslation.y + currentTranslation.y;
	currentTranslation.x = 0.0;
	currentTranslation.y = 0.0;
});

image.addEventListener('pinching', function(e){
	console.log(e);
});
image.addEventListener('pinchingend', function(e){
	console.log(e);
});*/