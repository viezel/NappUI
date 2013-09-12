# Napp UI

This module extends the native UI components provided by the Titanium Mobile SDK. We are more properties to a bunch of UI components, giving you more freedom for styling and functionality. 

This is not a set of new UI components. Instead, we are extending the existing framework.

See this module as a collection of extended functionality. I did not invent all of the below functionality, but want to put these together in one united module. 


## Add the module to your project

Simply add the following lines to your `tiapp.xml` file:
    
    <modules>
        <module platform="iphone">dk.napp.ui</module> 
    </modules>

## How to use

Instantiate the module through ```require();```  This will modify and override the native Titanium classes with the NappUI methods.  

Note: Creating a ```NappUI``` object is optional, but may be useful if methods, properties or custom proxy objects are defined.

```javascript
var NappUI = require("dk.napp.ui");
```

The following lists the UI components and its new extended functionality.

### Window

* Add a blur effect
  * 1.0: No blur effect
  * 0: Maximum blur effect


```javascript
var win = Ti.UI.createWindow({
    blur:0.2
});
```

### View

* Add drop shadow to your view
* Add a blur effect to the view

```javascript
var view = Ti.UI.createView({
    shadow:{
        shadowRadius:10,
        shadowOpacity:1,
        shadowOffset:{x:2, y:2}
    },
    blur:0.75
});
```

### ImageView

* Add pan, rotate or/and pinch control to your image view
* Eventlisteners for each new gesture control

```javascript
var image = Ti.UI.createImageView({
    image:"image.png",
    recognizeSimultaneously:"pinching,rotate",
    rotateGesture:true,
    pinchingGesture:true,
    panGesture:true
});

image.addEventListener('pan', function(e){});
image.addEventListener('panend', function(e){});

image.addEventListener('rotate', function(e){});
image.addEventListener('rotateend', function(e){});

image.addEventListener('pinching', function(e){});
image.addEventListener('pinchingend', function(e){});

image.addEventListener('pan', function(e){});
image.addEventListener('panend', function(e){});
```

### WebView

* Custom WebView scroll speed (Same TableView / ScrollView scroll speed)
* Remove scroll bounce shadow
* Remove scroll delay
* Communication between WebView and Titanium app
* Change UserAgent

```javascript
var webView = Ti.UI.createWebView({
    normalScrollSpeed: true,
    removeShadow: true,
    removeScrollDelay: true,
    userAgentForiOS: 'My Awesome Application UserAgent'
    url: 'http://www.appcelerator.com'
});
webView.addEventListener('fromWebView', function(){});
```

### ScrollableView

* Set the indicator color for the Paging Control
* Set the current indicator color for the Paging Control

```javascript
var scrollableView = Ti.UI.createScrollableView({
 	views:[view1,view2,view3],
 	showPagingControl:true,
	pagingControlCurrentIndicatorColor:"blue",
	pagingControlIndicatorColor: "red"
});
```

### TabGroup

* Custom active tab indicator image
* Custom active tab icon color
* Custom tab background image
* Custom tab background color (Same Ti.UI.TabGroup.tabsBackgroundColor property)

```javascript
var tabGroup = Ti.UI.createTabGroup({
    customBackgroundColor: "#151515",
    customBackgroundImage: "/images/tabbg.png",
    customActiveIndicator: "/images/activeIndicator.png",
    customActiveIconColor: "#FF3300"
});
```

### TextField

* Added hintTextColor

```javascript
var textfield = Ti.UI.createTextField({
	hintTextColor:"red"
});
```

### SearchBar

* SearchField BackgroundImage
* Custom Cancel button
  * barColor - background gradient of the button. (similar to navbar)
  * color - color of the button title
  * title - change the default *Cancel* text
  * font - set the font of the button
* Appearance of the keyboard
* Disable the search icon

```javascript
var searchBar = Ti.UI.createSearchBar({
	searchFieldBackgroundImage:"searchbg.png",
	showsScopeBar:true,
	scopeButtonTitles:["hello", "yes"],
	customCancel:{
		barColor:"#333",
		color:"#ddd",
		title:"Hit me",
		font:{
			fontSize:16,
			fontWeight:"bold",
			fontFamily:"Georgia"
		}
	},
	appearance:Titanium.UI.KEYBOARD_APPEARANCE_ALERT,
	barColor:"transparent",
	disableSearchIcon:true //disables the search icon in the left side
});
```

### Picker

* Mask the background to invisible. 

```javascript
var picker = Ti.UI.createPicker({
	mask:{
	  	left:14,
	  	top:10,
	  	width:293,
		height:196
  	}
});
```


### Toolbar

* TintColor

```javascript
var toolbar = Ti.UI.iOS.createToolbar({
    items:[send, flexSpace, camera],
    tintColor:"red"
});
```


### NavigationGroup

* Close all windows in the navigationGroup, and return to the very first window in the group.

```javascript
navGroup.popToRoot();
```


### Label

* attributed Text

~~~~
var string = "This is an example string";

var label = Ti.UI.createLabel({
	width: Ti.UI.FILL,
    text: string,
    font: {
		fontFamily: "Avenir-Roman",
		fontSize: 16
	},
	attributedText: {
		text: string, // String
		attributes: [ // Array
			{			// Object
				text: "example",
				color: "blue"
			},
			{
				text: "string",
				font: {
    				fontFamily: "Avenir-Medium",
    				fontSize: 16
    			}
			}
		]			 	
	}
});

win.add(label);
~~~~

A more extensive example is included in `/example/app.js`

## Changelog
* 1.1.4
    * Attributed Text: Fixed touch location bug causing application to crash
    * Attributed Text: Fixed highlight range bug
    * Attributed Text: ARC for memory management
    * Attributed Text: Lower memory consumption. Good to use in TiUITableViews \*wink\*
    
* 1.1.3
    * Attributed Text: Highlight links when selected
    * Attributed Text: LongPress event

* 1.1.2 
	* Attributed Text: Set range instead of text when defining attributes. Range can be useful when you get a predefined range eg. Twitter API
	* Attributed Text Links: Set links on specific text/range and listen to a tap event.
	
* 1.1.1 
	* Attributed Text: Bug Fixes
	* Attributed Text: Set base color for the text
	
* 1.1 
	* Attributed Text for TiUILabel - by @dezinezync 

* 1.0.4
	* Removed the need for requiring NappUI.js.  Modifed the symbol preloader file to a module asset.  See ticket [5](https://github.com/viezel/NappUI/issues/5).
	
* 1.0.3
  * Added `popToRoot()` to extend NavigationGroup. Feature request [#3](https://github.com/viezel/NappUI/issues/3)
  * Changed `setBlurred(true)` to `setBlur(0.2)`. Feature request [#1](https://github.com/viezel/NappUI/issues/1)

* 1.0.2
  * Aded NappUI.js for better use of this module. This is due to some limitations of the Titanium Module SDK.

* 1.0.1
  * Bugfix - invalid build, and some functions did not work as expected. 

* 1.0
  * Init commit, working module.

## Author

**Mads Møller**  
web: http://www.napp.dk  
email: mm@napp.dk  
twitter: @nappdev  


## License

    Copyright (c) 2010-2013 Mads Møller

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.