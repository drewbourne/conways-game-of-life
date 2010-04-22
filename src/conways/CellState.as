package conways
{
    /**
     * 
     */
    public class CellState
    {
        /**
         * Indicates the Cell is LIVE, yay!
         */
        public static const LIVE:CellState = new CellState("LIVE");
        
        /**
         * Indicates the Cell is DEAD, boo. 
         */
        public static const DEAD:CellState = new CellState("DEAD");
        
        /**
         * Constructor.
         */
        public function CellState(name:String)
        {
            _name = name;
        }
        
        /**
         * 
         */
        public function get name():String 
        {
            return _name;
        } 
        
        private var _name:String;
                
        /**
         * 
         */
        public function toString():String
        {
            return _name;
        }
    }
}