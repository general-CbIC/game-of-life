class GameField
  require './cell'

  def initialize(sort_variant, width, height)
    @cells = []
    @width = width
    @height = height
    case sort_variant
    when 1
      fill_random
    when 2
      fill_stable
    when 3
      fill_glider
    end
  end

  def fill_random
    @height.times do
      line = []
      @width.times do
        line.push Cell.new(rand > 0.5)
      end
      @cells.push line
    end
  end

  def fill_stable
    cells = [
      [0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 1, 0, 0, 0, 1, 0],
      [0, 1, 0, 1, 0, 1, 0, 1],
      [0, 1, 0, 1, 0, 1, 0, 1],
      [0, 0, 1, 0, 0, 0, 1, 0],
      [0, 0, 0, 0, 0, 0, 0, 0]
    ]
    fill_like cells
  end

  def fill_glider
    glider = [
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 1, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 1, 0, 0, 0],
      [0, 0, 0, 0, 1, 1, 1, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    ]
    fill_like glider
  end

  def fill_like(figure)
    @height = figure.length
    @width = figure[0].length

    figure.each do |row|
      line = []
      row.each do |val|
        if val == 1
          line.push Cell.new(true)
        else
          line.push Cell.new(false)
        end
      end
      @cells.push line
    end
  end

  def show_field
    system 'clear'
    @height.times do |i|
      @width.times do |j|
        print @cells[i][j].show + ' '
      end
      puts
    end
  end

  def life_round
    to_kill = []
    to_born = []
    @height.times do |i|
      @width.times do |j|
        neighbors = 0

        neighbors += 1 if @cells[i - 1][j - 1].alive?
        neighbors += 1 if @cells[i - 1][j].alive?
        neighbors += 1 if @cells[i - 1][(j + 1) % @width].alive?
        neighbors += 1 if @cells[i][j - 1].alive?
        neighbors += 1 if @cells[i][(j + 1) % @width].alive?
        neighbors += 1 if @cells[(i + 1) % @height][j - 1].alive?
        neighbors += 1 if @cells[(i + 1) % @height][j].alive?
        neighbors += 1 if @cells[(i + 1) % @height][(j + 1) % @width].alive?

        to_kill.push [i, j] if neighbors != 2 && neighbors != 3
        to_born.push [i, j] if neighbors == 3
      end
    end
    to_kill.each { |point| @cells[point[0]][point[1]].kill}
    to_born.each { |point| @cells[point[0]][point[1]].born }
  end
end