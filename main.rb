require 'yaml'
require_relative 'lib/lunch_team'

def main
  all_members, team_num = load_team_config
  history = load_history

  LunchTeam.choice(all_members, team_num, history).each do |team|
    p team.map { |member| member[:name] }
  end
end

def load_team_config
  config = YAML.load_file('./team_config.yml')
  [config[:all_members], config[:team_number]]
end

def load_history
  YAML.load_file('./history.yml')
end

main()
