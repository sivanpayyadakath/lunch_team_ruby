team_number = 3
TEAMS = []

members =
  [
      { "name"=>"やまぐち", "japanese"=>"true" },
      { "name"=>"はすみ", "japanese"=>"true" },
      { "name"=>"みとも", "japanese"=>"true" },
      { "name"=>"タイン", "japanese"=>"false" },
      { "name"=>"ポール", "japanese"=>" false" },
      { "name"=>"ハー", "japanese"=>"false" },
      { "name"=>"シヴァン","japanese"=>"false" },
      { "name"=>"おしだ", "japanese"=>"true" },
      { "name"=>"えび", "japanese"=>"true" }
  ]

def make_group(team_number,members)
  members.each do |a|
    TEAMS << a["name"]
  end
  TEAMS.permutation(team_number).to_a

end

def lunch_team(groups,members)
  groups.each do |ar|
    flag=1
    k=[]
    ar.each do |a|
      members.each do |m|
        if a == m["name"]
          if m["japanese"] == "true"
            flag = 0
          end
        end
      end
      unless flag != 0
        k << a
        p k if k.size == 3
      end
    end
  end
end




groups = make_group(team_number,members)
lunch_team(groups,members)









