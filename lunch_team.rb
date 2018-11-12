team_number = 3
TEAMS = []
SQUAD = []       #final valid groups

#input array of hash

members = [
    { "name" => "やまぐち", "japanese" => "true" },
    { "name" => "はすみ", "japanese" => "true" },
    { "name" => "みとも", "japanese" => "true" },
    { "name" => "タイン", "japanese" => "false" },
    { "name" => "ポール", "japanese" => " false" },
    { "name" => "ハー", "japanese" => "false" },
    { "name" => "シヴァン","japanese" => "false" },
    { "name" => "おしだ", "japanese" => "true" },
    { "name" => "えび", "japanese" => "true" }
]

def make_group(team_number,members)             #random groups
  members.each do |a|
    TEAMS << a["name"]
  end
  TEAMS.combination(team_number).to_a
end

def print_groups(array_of_arrays)                 #print list
  j=1
  #array_of_arrays= array_of_arrays.each_slice(3).to_a
  while array_of_arrays.size > 3
    puts "DAY #{j}"
    j+=1
    puts "-------------------------------------------------------------------------------------------------------"
    p array_of_arrays[0..2]
    array_of_arrays.slice!(0..2)
  end
end


def lunch_team(groups,members)                  #finding valid squad
  groups.each do |group|
    flag = 1
    k = []
    group.each do |person|
      members.each do |member|
        if person == member["name"]
          if member["japanese"] == "true"
            flag = 0
          end
        end
      end
      k << person
    end
    if flag == 0 && k.size == 3
      SQUAD << k
    end
  end
end


groups = make_group(team_number,members)
lunch_team(groups,members)
print_groups(SQUAD)
