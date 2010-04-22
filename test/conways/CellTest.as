package conways
{
	import mockolate.runner.MockolateRunner; MockolateRunner;
    import mockolate.mock;
    
    import org.flexunit.assertThat;
    import org.hamcrest.object.equalTo;
    
    [RunWith("mockolate.runner.MockolateRunner")]
    public class CellTest
    {
        public var cell:Cell;
        
        [Mock]
        public var grid:Grid;
        
        public function createCell(cellState:CellState, row:int=0, column:int=0):Cell 
        {
            var cell:Cell = new Cell();
            cell.grid = grid;
            cell.row = row;
            cell.column = column;
            cell.queueNextCellState(cellState);
            cell.update();
            return cell;
        }
        
        [Before]
        public function setup():void 
        {
            cell = new Cell();
        }

        [Test]
        public function rowAndColumn():void 
        {
            cell.row = 1;
            assertThat(cell.row, equalTo(1));
            
            cell.column = 1;
            assertThat(cell.row, equalTo(1));
        }
        
        [Test]
        public function numLiveNeighbours():void 
        {
            cell.grid = grid;
            
            mock(grid).method('getNeighbours').returns([ createCell(CellState.LIVE), createCell(CellState.LIVE), createCell(CellState.DEAD) ]);
            
            assertThat(cell.numLiveNeighbours, equalTo(2));
        }
    }
}