package org.aswing;

extern class LoadIcon extends AssetIcon {
	function new(url : Dynamic, ?width : Float, ?height : Float, ?scale : Bool, ?context : flash.system.LoaderContext) : Void;
	function getLoader() : flash.display.Loader;
}
