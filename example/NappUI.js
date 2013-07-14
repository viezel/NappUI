// We need to add the following proxies to our project before Napp UI works.
// This is due to some limitations of the Titanium Module SDK
// Please run this after you require the

exports.init = function() {
	
	// require the module
	require('dk.napp.ui');	

	// window and tabs
	var win1 = Ti.UI.createWindow();
	var tb1 = Ti.UI.createTab({
		window : win1
	});
	var tabGr = Ti.UI.createTabGroup({
		tabs : [tb1]
	});
	
	// navGroup
	var win2 = Ti.UI.createWindow();
	var navGroup = Ti.UI.iPhone.createNavigationGroup({
		window: win2
	});
	
	// TextField
	var textf = Ti.UI.createTextField();

	// WebView
	var webV = Ti.UI.createWebView();

	// SearchBar
	var SBar = Ti.UI.createSearchBar();

	// ScrollableView
	var scroV = Ti.UI.createScrollableView();

	// Picker
	var picker = Ti.UI.createPicker();

	// Toolbar
	var toolBar = Ti.UI.iOS.createToolbar();

	// Lets remove this from memory
	win1 = null;
	tb1 = null;
	tabGr = null;
	win2 = null;
	navGroup = null;
	textf = null;
	webV = null;
	SBar = null;
	scroV = null;
	picker = null;
	toolBar = null;
}