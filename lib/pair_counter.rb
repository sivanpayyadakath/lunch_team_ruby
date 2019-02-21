# frozen_string_literal: true

class PairCounter
  def initialize(all_member_name)
    @map = {}
    all_member_name.combination(2).to_a
                   .map(&method(:to_pair_sym))
                   .each { |pair| @map[pair] = 0 }
  end

  def count(history)
    history.flatten(1)
           .flat_map { |team| team.combination(2).to_a }
           .map(&method(:to_pair_sym))
           .each { |pair| @map[pair] += 1 if @map.has_key?(pair) }
  end

  def [](pair)
    @map[pair]
  end

  private

  def initialize_copy(original_obj)
    @map = original_obj.instance_variable_get('@map').dup
  end

  def to_pair_sym(name_array)
    a, b = name_array.sort
    "#{a}_#{b}".to_sym
  end

  module Statistics
    def mean
      @map.values.sum.fdiv(@map.size)
    end

    def variance
      mean_x = mean
      @map.values.map { |x| (x - mean_x)**2 }.sum / @map.size
    end
  end
  include Statistics
end
