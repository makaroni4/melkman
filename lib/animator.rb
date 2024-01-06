class Animator
  def animate(images, delay = 30)
    animation = ImageList.new(*sort_images(images))
    animation.delay = delay
    animation.write(".README/animated.gif")
  end

  private
  def sort_images(images)
    images.sort_by{ |f| File.basename(f)[/\d+/].to_i }
  end
end
