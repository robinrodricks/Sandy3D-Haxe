package org.aswing.resizer;

extern class ResizeStrategyImp implements ResizeStrategy {
	function new(wSign : Float, hSign : Float) : Void;
	function getBounds(com : org.aswing.Component, movedX : Int, movedY : Int) : org.aswing.geom.IntRectangle;
}
