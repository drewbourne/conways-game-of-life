package rules
{
    import asx.array.invoke;
    import asx.string.formatToString;
    import asx.string.substitute;
    
    import flash.events.Event;
    
    import mx.core.IMXMLObject;
    
    import org.hamcrest.mxml.BaseMXMLMatcher;
    import org.hamcrest.mxml.MXMLMatcher;
    import org.hamcrest.mxml.core.AllOf;
    
    /**
     * Defines the conditions and actions of a Rule
     * 
     * @see #when
     * @see #then
     */
    public class Rule
    {
        /**
         * Constructor. 
         */
        public function Rule()
        {
        }
        
        [Bindable]
        /**
         * 
         */
        public function get name():String 
        {
            return _name;
        }
        
        public function set name(value:String):void 
        {
            _name = value;
        }
        
        private var _name:String;
        
        [ArrayElementType("org.hamcrest.mxml.MXMLMatcher")]
		[Bindable]
        /**
         * Conditions under which the actions will be triggered. 
         * 
         * Conditions are defined using Hamcrest Matchers.
         * 
         * @see #then
         */
        public function get when():Array
        {
            return _when;
        }
        
        public function set when(value:Array):void 
        {
            _when = value || [];

			_whenMatcher = new WhenMatcher();
			_whenMatcher.rule = this;
            _whenMatcher.matchers = value;
            _whenMatcher.addEventListener("matchedChanged", whenMatchedChanged);
        }
        
        private var _when:Array;
        private var _whenMatcher:WhenMatcher;
        
        protected function whenMatchedChanged(event:Event):void 
        {
//			trace("Rule.whenMatchedChanged", event, event.target);
			
            thenExecute();
        }
        
        //
        
        // [ArrayElementType("com.asfusion.mate.actions.IAction")]
		[Bindable]
        /**
         * Actions to perform when the conditions are fulfilled.
         * 
         * @see #when
         */
        public function get then():Array
        {
            return _then; 
        }
        
        public function set then(value:Array):void 
        {
            _then = value || [];
        }
        
        private var _then:Array;
        
        protected function thenExecute():void 
        {
//			trace("Rule.thenExecute");
			
            invoke(_then, 'execute');
        }
    }
}
import asx.array.pluck;

import org.hamcrest.Matcher;
import org.hamcrest.StringDescription;
import org.hamcrest.collection.everyItem;
import org.hamcrest.core.describedAs;
import org.hamcrest.mxml.BaseMXMLMatcherContainer;
import org.hamcrest.object.isTrue;

import rules.Rule;

internal class WhenMatcher extends BaseMXMLMatcherContainer
{
	public function WhenMatcher()
	{
		super();
	}
	
	public function get rule():Rule 
	{
		return _rule;
	}
	
	public function set rule(value:Rule):void 
	{
		_rule = value;
	}
	
	private var _rule:Rule;
	
	override protected function createMatcher():Matcher
	{
		return describedAs(rule.name, everyItem(isTrue()));
	}
	
	override protected function evaluateMatchTarget():void
	{
		var whenChildrenMatched:Array = pluck(matchers, "matched");
		var mismatchDescription:StringDescription = new StringDescription();
		var matchedTarget:Boolean = matches(whenChildrenMatched);
		if (!matchedTarget)
		{
			describeMismatch(whenChildrenMatched, mismatchDescription);
		}
		
//		trace("BaseMXMLMatcher.evaluateMatchTarget"
//			, this, description
//			, "[" + whenChildrenMatched.join(", ") + "]"
//			, matchedTarget);			
		
		setMismatchDescription(mismatchDescription.toString());
		setMatched(matchedTarget);
	}
}
