require_relative "../lib/graph.rb"

describe "graph" do
  let!(:matrix) do
    matrix = [
			["0", "1", 2],
			["0", "4", 3],
			["1", "3", 8],
			["1", "5", 9],
			["1", "6", 6],
			["2", "5", 3],
			["2", "6", 7],
			["3", "7", 6],
			["4", "6", 5],
			["4", "7", 9],
			["5", "6", 4],
			["5", "7", 5],
			["6", "7", 5],
			]
  end

  let!(:graph) do
    graph = Graph.new(matrix)
  end

  let!(:start) { "0" }

  it "test some values on graph" do
    stop = "1"
    path, cost = graph.calc_min_path(start, stop)
    puts "#{stop}, #{cost}, #{path.join('->')}"
    expect(cost).to eq(2)

    stop = "7"
    path, cost = graph.calc_min_path(start, stop)
    puts "#{stop}, #{cost}, #{path.join('->')}"
    expect(cost).to eq(12)

    stop = "5"
    path, cost = graph.calc_min_path(start, stop)
    puts "#{stop}, #{cost}, #{path.join('->')}"
    expect(cost).to eq(11)

    stop = "6"
    path, cost = graph.calc_min_path(start, stop)
    puts "#{stop}, #{cost}, #{path.join('->')}"
    expect(cost).to eq(8)

  end
end
