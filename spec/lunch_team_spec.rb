require 'rspec'
require './lib/lunch_team'

describe 'LunchTeam.classificate' do
  subject(:actual) { LunchTeam.classificate(all_members, team_num) }

  context 'invalid cases' do
    context 'when team number is more than members count' do
      let(:team_num) { 2 }
      let(:all_members) { [{ name: 'えび', japanese: true }] }
      it { expect { actual }.to raise_error ArgumentError }
    end
    context 'when Japanese count is fewer than team number' do
      let(:team_num) { 2 }
      let(:all_members) do
        [{ name: 'えび', japanese: true }, { name: 'Sivan', japanese: false }]
      end
      it { expect { actual }.to raise_error ArgumentError }
    end
  end

  context 'valid cases' do
    let(:team_num) { 3 }
    let(:all_members) do
      [
        { name: 'やまぐち', japanese: true },
        { name: 'はすみ', japanese: true },
        { name: 'みとも', japanese: true },
        { name: 'タイン', japanese: false },
        { name: 'ポール', japanese: false },
        { name: 'ハー', japanese: false },
        { name: 'シヴァン', japanese: false },
        { name: 'おしだ', japanese: true },
        { name: 'えび', japanese: true }
      ]
    end

    it 'team count should be eq team_num' do
      expect(actual.size).to eq team_num
    end
    it 'each team members count should be eq all_members.size / team_num' do
      expect(actual[0].size).to eq 3
      expect(actual[1].size).to eq 3
      expect(actual[2].size).to eq 3
    end
    it 'each team should have at least one Japanese' do
      100.times do
        actual = LunchTeam.classificate(all_members, team_num)
        expect(actual.all? { |team| team.any? { |x| x[:japanese] } }).to be_truthy
      end
    end
  end
end
