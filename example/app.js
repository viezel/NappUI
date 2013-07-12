
// We need to use the NappUI.js to init this module
var NappUI = require("NappUI");
NappUI.init();


// NOW - Start using Napp UI

var window = Ti.UI.createWindow({
	backgroundColor:"#FFF"
});

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


/*
// example of the pan gesture.. 

var image = Ti.UI.createImageView({
    image:'/Default.png',
    width:160,
    height:240,
    left:10,
    top:10,
    panGesture:true //custom property from Napp UI
});
window.add(image);

var currentTranslation = {x:0.0, y:0.0};
var lastTranslation = {x:0.0, y:0.0};

function updateTransform(image){
    var transform = Ti.UI.create2DMatrix();
    transform.tx = lastTranslation.x+currentTranslation.x;
    transform.ty = lastTranslation.y+currentTranslation.y;
	image.transform = transform;
};

image.addEventListener('pan', function(e){
	currentTranslation.x = e.translation.x;
	currentTranslation.y = e.translation.y;
	Ti.API.info("x: " + currentTranslation.x + " y: " + currentTranslation.y);
	updateTransform(image);
});

image.addEventListener('panend', function(e){
    lastTranslation.x = lastTranslation.x + currentTranslation.x;
    lastTranslation.y = lastTranslation.y + currentTranslation.y;
    currentTranslation.x = 0.0;
    currentTranslation.y = 0.0;
});
*/


window.open();