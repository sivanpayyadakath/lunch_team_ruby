class LunchTeam
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
end