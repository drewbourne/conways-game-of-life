package rules
{
    [DefaultProperty("rules")]
    
    /**
     * 
     */
    public class RuleSet
    {
        /**
         * Constructor.
         */
        public function RuleSet()
        {
        }

        public function get rules():Array
        {
            return _rules;
        }
        
        public function set rules(value:Array):void 
        {
            if (_rules != value)
            {
                _rules = value;
            }
        }
        
        private var _rules:Array;
    }
}