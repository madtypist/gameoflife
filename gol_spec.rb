class Cell
  attr_accessor :state, :next_state
  def be_alive
    @state = 1
  end

  def next_tick(state)
    @next_state = state
  end

  def tick
    @state = @next_state
  end

  def eval_next_state(neighbors)
    if (neighbors == 3 || @state == 1 && neighbors == 2)
      @next_state = 1
    else
      @next_state = 0
    end
  end
end  

class Board
  attr_accessor :cells,:next_cells
  def initialize
    @cells = Hash.new
    @next_cells = Hash.new
  end

  def make_alive(location)
    if @cells.keys.include? location
      @cells[location].be_alive
    else
      @cells[location] = Cell.new.be_alive
    end
  end

  def get(location)
    if @cells[location]
  end

  def tick
    @cells = @next_cells
    @next_cells = Hash.new
  end

  def eval
    @cells.keys.each do |cell|
      (-1..1).each do |x|
        (-1..1).each do |y|
          unless x == 0 and y == 0
            this_neighbor = [cell[0] + x , cell[1] + y]
            if @cells[this_neighbor] == nil
              @next_cells[this_neighbor] = 1
            else
              @next_cells[this_neighbor] += 1
            end
          end
        end
      end
    end
  end


#Rspec.define Cell do
  describe "cell state" do
    let (:cell) {Cell.new}
    it "should be alive" do
      cell.be_alive
      expect(cell.state).to eq 1
    end

    it "can change its state next tick" do
      cell.be_alive
      cell.next_tick(0)
      expect(cell.state).to eq 1
      cell.tick
      expect(cell.state).to eq 0
    end

    it "should die if underpopulated" do
      cell.be_alive
      num_neighbors = 1
      cell.eval_next_state(num_neighbors)
      cell.tick
      expect(cell.state).to eq 0
    end

  end

  describe "world" do
    let (:board) {Board.new}

    it "can tell cells what their neighbor status is" do
      board.make_alive([0,0])
      board.make_alive([0,1])
      board.make_alive([1,0])
      board.eval
      board.tick
      expect(board.cells.include? [1,1]).to be true
    end 
  end
#end