class SimpleChainGenerator
  def initialize(params = {})
    @image_size = params[:image_size] || 1000
    @center_point = Point.new(@image_size / 2, @image_size / 2)
    @radius = (@image_size - 50) / 2
  end

  def draw_simple_polygonal_chain(number_of_points, arc_angle)
    angle_step = arc_angle.to_f / number_of_points

    (1..number_of_points).map do |i|
      angle = rand_angle(angle_step, i)
      place_point(angle)
    end
  end

  private

  def rand_angle(angle_step, step)
    (step - 1) * angle_step + rand(angle_step)
  end

  def place_point(angle)
    x = @center_point.x + rand(@radius) * Math.cos(angle * 3.14 / 180)
    y = @center_point.y + rand(@radius) * Math.sin(angle * 3.14 / 180)

    Point.new(x,y)
  end
end
