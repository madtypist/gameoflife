describe World do
  let(:world) { World.new }

  it "has a board" do
    expect(world.board).to be_a(Board)
  end
end