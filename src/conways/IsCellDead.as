package conways
{
	import org.hamcrest.Description;
	import org.hamcrest.Matcher;
	import org.hamcrest.mxml.BaseMXMLMatcher;
	
	public class IsCellDead extends BaseMXMLMatcher
	{
		private var _matcher:IsCellDeadMatcher;
		
		public function IsCellDead()
		{
			super();
			
			_matcher = new IsCellDeadMatcher();
		}
		
		override public function describeTo(description:Description):void
		{
			description.appendText("is Cell Dead");
		}
		
//		override protected function evaluateMatchTarget():void
//		{
//			var before:Boolean = matched;
//			
//			super.evaluateMatchTarget();
//			
//			trace("IsCellDead?", before, matched, target);
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

internal class IsCellDeadMatcher extends BaseMatcher
{
	override public function matches(item:Object):Boolean
	{
		return item && (item as Cell).cellState == CellState.DEAD;
	}
}