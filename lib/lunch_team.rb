# frozen_string_literal: true

require_relative 'pair_counter'

class LunchTeam
  def self.choice(all_members, team_num, history)
    all_member_names = all_members.map { |x| x[:name] }
    counter = PairCounter.new(all_member_names)
    counter.count(history)

    teams_and_variances = (1..100).map do
      calc_new_teams_and_variance(all_members, team_num, counter)
    end
    teams_and_variances.sort_by! { |x| x[:variance] }

    teams_and_variances.first[:teams]
  end

  def self.classificate(all_members, team_num)
    raise ArgumentError, 'メンバー数よりグループ数の方が大きいです' if all_members.size < team_num
    raise ArgumentError, '日本人の数が足りません' if japanese_count(all_members) < team_num

    payers, rest = divide_payers(all_members.shuffle, team_num)
    divide(rest.shuffle, team_num).map do |group|
      group << payers.shift
    end
  end

  def self.japanese?(member)
    member[:japanese]
  end

  def self.japanese_count(all_members)
    all_members.count(&method(:japanese?))
  end

  def self.divide_payers(all_members, team_num)
    japanese, others = all_members.partition(&method(:japanese?))
    payers = japanese.slice!(0, team_num)
    rest = others.push(*japanese)
    [payers, rest]
  end

  def self.divide(arr, number)
    result = []
    rest = arr.dup
    num_per_group = arr.size.fdiv(number).round

    number.times do
      result << rest.slice!(0, num_per_group)
    end
    result.last.push(*rest)

    result
  end

  private

  def self.calc_new_teams_and_variance(all_members, team_num, counter)
    teams = classificate(all_members, team_num)
    team_names = teams.map { |team| team.map { |x| x[:name] } }
    new_counter = counter.dup
    new_counter.count([team_names])
    { teams: teams, variance: new_counter.variance }
  end
end
