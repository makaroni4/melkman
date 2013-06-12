# TODO
# sometimes it generates chain with intersection
class SimpleChainGenerator
  def initialize(params = {})
    @image_size = params[:image_size] || 1000
    @center_point = Point.new(@image_size / 2, @image_size / 2)
    @scatter = params[:scatter] || 20
    @radius = (@image_size - 2 * @scatter) / 2
  end

  def draw_simple_polygonal_chain(number_of_points, arc_angle)
    angle_step = arc_angle.to_f / number_of_points.to_f

    (1..number_of_points).map do |i|
      angle = i * angle_step
      place_point(angle)
    end
  end

  private
  def scatter_point(point)
    point.x = point.x + rand(@scatter)
    point.y = point.y + [1, -1].sample * rand(@scatter)
    point
  end

  def place_point(angle)
    x = @center_point.x - @radius * Math.sin(angle)
    y = @center_point.y - @radius * Math.cos(angle)
    scatter_point(Point.new(x,y))
  end
end
