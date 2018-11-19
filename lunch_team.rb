ENGLISH = []
JAPANESE = []
TEAMS = []
SQUAD = []
members = [
    { "name" => "やまぐち", "japanese" => "true" },
    { "name" => "はすみ", "japanese" => "true" },
    { "name" => "みとも", "japanese" => "true" },
    { "name" => "タイン", "japanese" => "false" },
    { "name" => "ポール", "japanese" => " false" },
    { "name" => "ハー", "japanese" => "false" },
    { "name" => "シヴァン", "japanese" => "false" },
    { "name" => "おしだ", "japanese" => "true" },
    { "name" => "えび", "japanese" => "true" }
]

members.each do |member|
  if member["japanese"]=="true"
    JAPANESE << member["name"]
  else
    ENGLISH << member["name"]
  end
  TEAMS << member["name"]
end


def valid_teams
  valid_squad = []
  squad = TEAMS.combination(3).to_a
  squad.each do |x|
    if (x & ENGLISH).size != x.size
      valid_squad<<x
    end
  end
  valid_squad
end

def print_groups(teams)
  teams.each do |first|
    teams.each do |second|
      if(first & second).empty?
        find_third(first,second,teams)
      end
    end
  end
end

def find_third(first,second,teams)
  teams.each do |third|
    if(first & third).empty?
      if(second & third).empty?
        find_redundant(first,second,third)
      end
    end
  end
end

def find_redundant(first,second,third)
  k=[]
  k<<first<<second<<third
  #include wont work (repeating)
  if SQUAD.include?(k)
  else
    SQUAD<<k
    p k
  end
end


teams = valid_teams
print_groups(teams)
p SQUAD.count
