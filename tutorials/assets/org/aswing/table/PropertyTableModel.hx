package org.aswing.table;

extern class PropertyTableModel extends AbstractTableModel, implements org.aswing.event.ListDataListener {
	function new(listModel : org.aswing.ListModel, names : Array<Dynamic>, properties : Array<Dynamic>, translators : Array<Dynamic>) : Void;
	function contentsChanged(e : org.aswing.event.ListDataEvent) : Void;
	function getList() : org.aswing.ListModel;
	function intervalAdded(e : org.aswing.event.ListDataEvent) : Void;
	function intervalRemoved(e : org.aswing.event.ListDataEvent) : Void;
	function setList(listModel : org.aswing.ListModel) : Void;
	private var list : org.aswing.ListModel;
	private var names : Array<Dynamic>;
	private var properties : Array<Dynamic>;
	private var translators : Array<Dynamic>;
}
