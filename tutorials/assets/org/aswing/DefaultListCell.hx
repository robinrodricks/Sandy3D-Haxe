package org.aswing;

extern class DefaultListCell extends AbstractListCell {
	function new() : Void;
	private function __resized(e : org.aswing.event.ResizedEvent) : Void;
	private function getJLabel() : JLabel;
	private function initJLabel(jlabel : JLabel) : Void;
}
