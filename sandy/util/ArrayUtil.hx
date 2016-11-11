package sandy.util;

/**
* Static methods for cross platform use of Array's and TypedArray's. [array]
* parameters are Dynamic, so use with caution.
*
* @author		Russell Weir
* @version		3.2
**/
class ArrayUtil {

	public static inline var CASEINSENSITIVE : Int = 1;
	public static inline var DESCENDING : Int = 2;
	public static inline var NUMERIC : Int = 16;
	public static inline var RETURNINDEXEDARRAY : Int = 8;
	public static inline var UNIQUESORT : Int = 4;

	public static inline function indexOf(array:Dynamic, searchElement:Dynamic, fromIndex:Null<Int>=0) : Int
	{
		#if (flash || js)
			return untyped array.indexOf(searchElement, fromIndex);
		#else
			var idx = -1;
			for(i in fromIndex...untyped array.length) {
				if(untyped array[i] == searchElement) {
					idx = i;
					break;
				}
			}
			return idx;
		#end
	}

	public static inline function lastIndexOf(array:Dynamic, searchElement:Dynamic, fromIndex:Null<Int>=0x7FFFFFFF) : Int
	{
		#if (flash || js)
			return untyped array.lastIndexOf(searchElement, fromIndex);
		#else
		if(fromIndex > untyped array.length)
			fromIndex = untyped array.length;
		var idx : Int = -1;
		while(--fromIndex > -1) {
			if(untyped array[fromIndex] == searchElement) {
				idx = fromIndex;
				break;
			}
		}
		return idx;
		#end
	}

	/**
	* Makes an array 0 length, in the faster way possible per platform
	*/
	public static inline function truncate(array:Dynamic) : Void {
		#if (flash || js)
		untyped array.length = 0;
		#else
		untyped array.splice(0, untyped array.length);
		#end
	}

// 	public static inline function sortOn<AT>(array:AT, fieldName:String, flags:Int=0) {
// 		#if flash
// 			if(Std.is(array, Array))
// 				untyped array.sortOn( fieldName, flags );
// 			else
//
// 		#elseif js
// 		#error // does js have this?
// 		#else
//
// 		#end
// 	}

}