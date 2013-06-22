
var NappUI = require('dk.napp.ui');


var window = Ti.UI.createWindow();

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
window.open();