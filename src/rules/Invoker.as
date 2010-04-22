package rules
{
    public class Invoker
    {
        public function Invoker()
        {
        }
        
        [Bindable]
        public var method:Function;
        
        [Bindable]
        public var arguments:Array;
        
        /**
         * 
         */
        public function execute():void 
        {
            method.apply(null, this.arguments);
        }
    }
}