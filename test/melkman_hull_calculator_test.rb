require_relative '../test_helper'
require_relative '../lib/melkman_hull_calculator'

describe 'MelkmanHullCalculator' do
  let(:calculator) { MelkmanHullCalculator.new }

  describe '#calculate' do
    let(:point_1) { Point.new(1,1) }
    let(:point_2) { Point.new(1,5) }
    let(:point_3) { Point.new(5,5) }
    let(:point_4) { Point.new(5,1) }
    let(:point_5) { Point.new(2,2) }
    let(:points) { [point_1, point_2, point_3, point_4, point_5] }

    it 'calculates hull' do
      hull = calculator.calculate(points)
      hull.must_include(point_1)
      hull.must_include(point_2)
      hull.must_include(point_3)
      hull.must_include(point_4)
      assert_equal(hull.include?(point_5), false)
    end
  end
end
