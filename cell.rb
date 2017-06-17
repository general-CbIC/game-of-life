class Cell
  def initialize(is_alive)
    @is_alive = is_alive
  end

  def show
    @is_alive ? '*' : ' '
  end

  def kill
    @is_alive = false
  end

  def born
    @is_alive = true
  end

  def alive?
    @is_alive
  end
end