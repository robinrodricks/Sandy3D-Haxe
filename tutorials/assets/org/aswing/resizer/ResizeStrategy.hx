package org.aswing.resizer;

extern interface ResizeStrategy {
	function getBounds(com : org.aswing.Component, movedX : Int, movedY : Int) : org.aswing.geom.IntRectangle;
}
