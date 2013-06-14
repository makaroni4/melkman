class Snapshooter
  SNAPSHOTS_DIR = 'snapshots'

  def initialize
    FileUtils.rm_rf(SNAPSHOTS_DIR)
    Dir.mkdir(SNAPSHOTS_DIR) unless Dir.exists?(SNAPSHOTS_DIR)
  end

  def snapshot!(points, deque, pointer)
    drawer = HullDrawer.new(
      points: points,
      hull_points: deque.compact,
      img_name: "#{SNAPSHOTS_DIR}/#{pointer}.jpg"
    )
    drawer.draw
  end
end
