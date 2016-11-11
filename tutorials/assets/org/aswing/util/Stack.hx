package org.aswing.util;

extern class Stack extends Vector {
	function new() : Void;
	function empty() : Bool;
	function peek() : Dynamic;
	function push(item : Dynamic) : Dynamic;
	function search(o : Dynamic) : Int;
}
