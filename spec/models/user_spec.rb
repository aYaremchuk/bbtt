require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }

  it { is_expected.to have_many(:posts) }
  it { is_expected.to have_and_belong_to_many(:groups) }

  describe 'default role' do
    it 'sets role to user by default' do
      expect(described_class.new.role).to eq 'user'
    end

    it 'allows to overwrite role' do
      expect(described_class.new(role: 'admin').role).to eq 'admin'
    end
  end
end
