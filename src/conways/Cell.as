package conways
{
    import asx.array.filter;
    import asx.string.formatToString;
    
    import flash.events.Event;
    import flash.events.EventDispatcher;
    
    import org.hamcrest.object.hasProperty;
    
    /**
     * 
     */
    public class Cell extends EventDispatcher
    {
        public var row:int;
        
        public var column:int;
        
        public var grid:Grid; 
		
		public var neighbours:Array;
        
        /**
         * Constructor 
         */
        public function Cell()
        {
           super();
        }
                
        public function get liveNeighbours():Array
        {
            return filter(neighbours, isCellLive);    
        }
        
        public function get deadNeighbours():Array
        {
            return filter(neighbours, isCellDead);
        }
        
		[Bindable("cellStateChanged")]
        public function get numLiveNeighbours():int 
        {
            return liveNeighbours.length;
        }
		
		[Bindable("cellStateChanged")]
		public function isCellLive(cell:Cell):Boolean
		{
			return cell.cellState == CellState.LIVE;
		}
		
		[Bindable("cellStateChanged")]
		public function isCellDead(cell:Cell):Boolean
		{
			return cell.cellState == CellState.DEAD;
		}
           
		[Bindable("cellStateChanged")]
        /**
         * 
         */
        public function get cellState():CellState
        {
            return _cellState;
        }
        
        private var _cellState:CellState;
        
		[Bindable("nextCellStateChanged")]
        /**
         * 
         */
        public function get nextCellState():CellState
        {
            return _nextCellState;
        }
        
        private var _nextCellState:CellState;
		
		[Bindable("cellStateChanged")]
		/**
		 *
		 */
		public function get previousCellState():CellState 
		{
			return _previousCellState;
		}
		
		private var _previousCellState:CellState;
        
        /**
         * 
         */
        public function update():void 
        {
			if (_nextCellState)
			{
				_previousCellState = _cellState;
	            _cellState = _nextCellState;
	            _nextCellState = null;
				dispatchEvent(new Event("cellStateChanged"));
			}
        }
        
        public function queueNextCellState(value:CellState):void
        {
			if (_nextCellState != value)
			{
            	_nextCellState = value;
            	dispatchEvent(new Event("nextCellStateChanged"));
			}
        } 
    
//        public function toString():String 
//        {
//            return formatToString(this, "Cell", ["row", "column", "cellState", "nextCellState", "numLiveNeighbours"]);
//        }
    }
}