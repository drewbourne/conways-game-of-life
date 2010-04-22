package conways
{
    import asx.array.compact;
    import asx.array.invoke;
    import asx.array.map;
    import asx.array.random;
    
    import flash.events.Event;
    import flash.events.EventDispatcher;
    
    /**
     * 
     */
    public class Grid extends EventDispatcher
    {
        private var _rows:int;
        private var _columns:int;
        private var _cells:Array;
        private var _cellsByRow:Array;
        
        /**
         * Constructor. 
         */
        public function Grid(rows:int = 10, columns:int = 10)
        {
            _rows = rows;
            _columns = columns;         
            _cells = [];
            _cellsByRow = [];
            
            var cell:Cell;
            var rowOfCells:Array = [];
            for (var row:int = 0; row < rows; row++)
            {
                _cellsByRow[row] = rowOfCells = [];
                
                for (var column:int = 0; column < columns; column++)
                {
                    cell = new Cell();
                    cell.row = row;
                    cell.column = column;
                    cell.grid = this;
                    cell.queueNextCellState(CellState(random([ CellState.LIVE, CellState.DEAD ])));
                    cell.update();
                    
                    rowOfCells[column] = cell;
                    _cells[_cells.length] = cell;
                }
            } 
			
			// prime neighbours
			for each (cell in _cells)
			{
				cell.neighbours = getNeighbours(cell);
			}
        }
        
        [Bindable("cellsChanged")]
        public function get cells():Array 
        {
            return _cells;
        }
        
        [Bindable("rowsChanged")]
        public function get rows():int
        {
            return _rows;
        }
        
        [Bindable("columnsChanged")]
        public function get columns():int 
        {
            return _columns;
        }
        
        /**
         * 
         */
        public function getNeighbours(cell:Cell):Array 
        {			
            var offsets:Array = [ 
                [-1, -1], [-1, 0], [-1, 1], 
                [0, -1], /*[0, 0],*/ [0, 1],
                [1, -1], [1, 0], [1, 1],
                ];
            
			var neighbours:Array = [];
			var neighbour:Cell;
			var row:int;
			var col:int;
			var rowOfCells:Array
			
			for each (var offset:Array in offsets)
			{
//				row = (rows + cell.row + offset[0]) % rows;
//				col = (columns + cell.column + offset[1]) % columns;

				row = (cell.row + offset[0]);
				col = (cell.column + offset[1]);
				
				if (row >= 0 && row < rows 
					&& col >= 0 && col < columns)
				{
					neighbour = _cellsByRow[row][col];
					neighbours[neighbours.length] = neighbour;
				}
			}

            return compact(neighbours);
        }
        
        public function update():void 
        {
            invoke(_cells, 'update');
			
			dispatchEvent(new Event("cellsChanged"));
        }
    }
}