require 'yaml'
require_relative 'lib/lunch_team'

def main
  all_members, team_num = load_team_config

  LunchTeam.classificate(all_members, team_num).each do |team|
    p team.map { |member| member[:name] }
  end
end

def load_team_config
  config = YAML.load_file('./team_config.yml')
  [config[:all_members], config[:team_number]]
end

main()
