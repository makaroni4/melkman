require 'RMagick'
include Magick

class HullDrawer
  def initialize(params)
    @points = params[:points]
    @hull_points = params[:hull_points]
    @point_size = params[:point_size] || 3
    @img_name = params[:img_name] || 'img.jpg'
    @draw = Draw.new
    @draw.font('Helvetica')
    @image = init_image
  end

  def draw
    @draw.fill('red')
    draw_points
    @draw.fill('black')
    draw_hull
    draw_arrow(@hull_points[-2], @hull_points[0]) if @hull_points.first == @hull_points.last
    output
  end

  private
  def init_image
    max_x = @points.max { |a,b| a.x <=> b.x }.x
    max_y = @points.max { |a,b| a.y <=> b.y }.y

    Image.new(max_x + 100, max_y + 100)
  end

  def draw_point point, index = nil
    @draw.rectangle(
      point.x - @point_size,
      point.y - @point_size,
      point.x + @point_size,
      point.y + @point_size
    )

    if index
      @draw.text(
        point.x - 15,
        point.y - 15,
        index.to_s
      )
    end
  end

  def draw_points
    @points.each_with_index do |point, index|
      draw_point(point, index)
    end
  end

  def draw_dashed_line(point_1, point_2)
    dash_size = 5
    dy = point_2.y - point_1.y
    dx = point_2.x - point_1.x
    hyp = Math.sqrt(dy ** 2 + dx ** 2)
    ax = dash_size * dx / hyp
    ay = dash_size * dy / hyp
    @draw.fill('blue')

    number_of_dashes = (hyp / dash_size).to_i
    1.upto(number_of_dashes) do |i|
      next if i.even?

      @draw.line(
        point_2.x - ax * i,
        point_2.y - ay * i,
        point_2.x - ax * (i + 1),
        point_2.y - ay * (i + 1)
      )
    end
  end

  def draw_arrow(point_1, point_2)
    arrow_size = 10
    dy = point_2.y - point_1.y
    dx = point_2.x - point_1.x
    hyp = Math.sqrt(dy ** 2 + dx ** 2)
    dy = - dy / hyp
    dx = - dx / hyp

    draw = Magick::Draw.new
    draw.fill('blue')

    ax = dx * Math.sqrt(3)/2 - dy * 1/2
    ay = dx * 1/2 + dy * Math.sqrt(3)/2
    bx = dx * Math.sqrt(3)/2 + dy * 1/2
    by =  - dx * 1/2 + dy * Math.sqrt(3)/2

    draw.line(
      point_2.x,
      point_2.y,
      point_2.x + arrow_size * ax,
      point_2.y + arrow_size * ay
    )

    draw.line(
      point_2.x,
      point_2.y,
      point_2.x + arrow_size * bx,
      point_2.y + arrow_size * by
    )
    draw.draw(@image)
  end

  def draw_hull
    @hull_points.each_cons(2).each do |p1, p2|
      draw_dashed_line(p1, p2)
    end
  end

  def output
    @draw.draw(@image)
    @image.write(@img_name)
  end
end
