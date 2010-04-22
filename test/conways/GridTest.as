package conways
{
    import org.flexunit.assertThat;
    import org.hamcrest.collection.arrayWithSize;
    
    public class GridTest
    {
        public var grid:Grid;
        public var cell:Cell;
        
        [Before]
        public function setup():void 
        {
            grid = new Grid(10, 10);
        }
        
        [Test]
        public function getNeighbours():void 
        {
            cell = new Cell();
            cell.row = 0;
            cell.column = 0;
            
            assertThat(grid.getNeighbours(cell), arrayWithSize(3));
        }
    }
}