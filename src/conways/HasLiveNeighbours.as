package conways
{
	import org.hamcrest.Description;
	import org.hamcrest.Matcher;
	import org.hamcrest.mxml.BaseMXMLMatcher;
	
	public class HasLiveNeighbours extends BaseMXMLMatcher
	{
		public function HasLiveNeighbours()
		{
			super();
		}
		
		public function get num():Matcher 
		{
			return _num;
		}
		
		public function set num(value:Matcher):void 
		{
			_num = value;
			_matcher = new HasLiveNeighboursMatcher(num);
		}
		
		override public function describeTo(description:Description):void
		{
			description.appendText("cell has ");
			description.appendDescriptionOf(_num);
			description.appendText(" live neighbours");
		}
		
		private var _num:Matcher;
		private var _matcher:Matcher;
		
		override protected function createMatcher():Matcher
		{
			return _matcher;
		}
		
//		override protected function evaluateMatchTarget():void
//		{
//			var before:Boolean = matched;
//			
//			super.evaluateMatchTarget();
//			
//			trace("HasLiveNeighbours?", before, matched, target);
//		}
	}
}
import conways.Cell;
import conways.CellState;

import org.hamcrest.BaseMatcher;
import org.hamcrest.Matcher;

internal class HasLiveNeighboursMatcher extends BaseMatcher
{
	private var _num:Matcher; 
	
	public function HasLiveNeighboursMatcher(num:Matcher)
	{
		_num = num;
	}
	
	override public function matches(item:Object):Boolean
	{
		return item && _num.matches((item as Cell).numLiveNeighbours);
	}
}