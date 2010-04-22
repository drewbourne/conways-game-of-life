package conways
{
	import org.hamcrest.Description;
	import org.hamcrest.Matcher;
	import org.hamcrest.mxml.BaseMXMLMatcher;
	
	public class IsCellAlive extends BaseMXMLMatcher
	{
		private var _matcher:IsCellAliveMatcher;
		
		public function IsCellAlive()
		{
			super();
			
			_matcher = new IsCellAliveMatcher();
		}
		
		override public function describeTo(description:Description):void
		{
			description.appendText("is Cell Alive");
		}
		
//		override protected function evaluateMatchTarget():void
//		{
//			var before:Boolean = matched;
//			
//			super.evaluateMatchTarget();
//			
//			trace("IsCellAlive?", before, matched, target);
//		}
		
		override protected function createMatcher():Matcher
		{
			return _matcher;
		}
	}
}
import conways.Cell;
import conways.CellState;

import org.hamcrest.BaseMatcher;

internal class IsCellAliveMatcher extends BaseMatcher
{
	override public function matches(item:Object):Boolean
	{
		return item && (item as Cell).cellState == CellState.LIVE;
	}
}