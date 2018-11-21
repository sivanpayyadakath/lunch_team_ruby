# frozen_string_literal: true

require 'rspec'
require './lib/pair_counter'

describe PairCounter do
  describe '#new' do
    let(:all_member_name) { %w[えび みとも やまぐち] }
    subject { PairCounter.new(all_member_name) }
    it { expect(subject[:えび_みとも]).to eq 0 }
    it { expect(subject[:えび_やまぐち]).to eq 0 }
    it { expect(subject[:みとも_やまぐち]).to eq 0 }
  end

  describe '#count' do
    let(:all_member_name) { %w[やまぐち はすみ みとも タイン ポール ハー シヴァン おしだ えび] }
    let(:history) do
      [
        [%w[やまぐち みとも えび], %w[はすみ タイン シヴァン], %w[おしだ ポール ハー]],
        [%w[ポール はすみ シヴァン], %w[やまぐち タイン ハー], %w[おしだ みとも えび]]
      ]
    end
    let(:counter) { PairCounter.new(all_member_name) }
    before { counter.count(history) }
    it { expect(counter[:えび_ポール]).to eq 0 }
    it { expect(counter[:えび_やまぐち]).to eq 1 }
    it { expect(counter[:えび_みとも]).to eq 2 }
  end

  describe '#dup' do
    let(:all_member_name) { %w[やまぐち はすみ みとも タイン ポール ハー シヴァン おしだ えび] }
    let(:history) do
      [
        [%w[やまぐち みとも えび], %w[はすみ タイン シヴァン], %w[おしだ ポール ハー]],
        [%w[ポール はすみ シヴァン], %w[やまぐち タイン ハー], %w[おしだ みとも えび]]
      ]
    end
    let(:counter) { PairCounter.new(all_member_name) }
    before { counter.count(history) }
    it do
      dup_counter = counter.dup
      dup_counter.count(history)

      expect(counter[:えび_みとも]).to eq 2
      expect(dup_counter[:えび_みとも]).to eq 4
    end
  end

  describe 'Statistics' do
    describe '#mean' do
      let(:all_member_name) { %w[やまぐち はすみ みとも タイン ポール ハー シヴァン おしだ えび] }
      let(:history) do
        [
          [%w[やまぐち みとも えび], %w[はすみ タイン シヴァン], %w[おしだ ポール ハー]],
          [%w[ポール はすみ シヴァン], %w[やまぐち タイン ハー], %w[おしだ みとも えび]]
        ]
      end
      let(:counter) { PairCounter.new(all_member_name) }
      before { counter.count(history) }
      it { expect(counter.mean).to eq 0.5 }
      it { expect(counter.variance).to eq 0.3611111111111111 }
    end
  end
end
