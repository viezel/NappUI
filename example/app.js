
var NappUI = require('dk.napp.ui');


var window = Ti.UI.createWindow({
	backgroundColor:"#FFF"
});

/*var view = Ti.UI.createView({
	backgroundColor: '#999',
    height: 100,
    shadow: {
        shadowColor: '#000',
        shadowRadius: 10,
        shadowOffset: { x: 5, y: 5 },
        shadowOpacity: 1
    },
    top: 50,
    width: 100
});

window.add(view);*/



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
    	color: '#757572',
    	highlightColor: "#6060bf",

    	attributes: [/*{
    		text: "Hello world.",
    		shadow: {
				shadowColor: "#000000",
				shadowOffset: {
					x: 0,
					y: 2
				},
				shadowRadius: 1.0
			}
    	},*/ {
    		text: "@dezinezync",
    		font: {
    			fontFamily: "Avenir-Heavy",
    			fontSize: 16
    		},
    		color: "#6161f2",
    		link: "http://twitter.com/dezinezync"
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
    		//text: "Coming",
    		range: [58, 6], //Starting index for the word "Coming", length of the word "coming"
    						//Useful for when you have ready-made indexes (eg. Twitter API), 
    						//or multiple occurences of the same word
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
    		underline: 3, //bold line,
    		backgroundColor: "green"
    	}, {
    		text: "the",
    		underline: 4, //bold(er) line
    		backgroundColor: "#aaaaaa"
    	}]
    }
});

//If you're assigning links, you might want to add this event

//label.addEventListener('click', function() {}); 
//If you forget setting this, you won't be able to catch the url event.

label.addEventListener('url', function(e) {

	if(e.url) {
		
		Ti.API.info("Got URL");

		if(Ti.Platform.canOpenURL(e.url)) {
			Ti.Platform.openURL(e.url);
		}

	}

});

label.addEventListener('longpress', function(e) {

	if(e.url) {

		Ti.API.info("Got URL: LongPressed");

		if(Ti.Platform.canOpenURL(e.url)) {
			Ti.Platform.openURL(e.url);
		}

	}

});

window.add(label);

window.open();