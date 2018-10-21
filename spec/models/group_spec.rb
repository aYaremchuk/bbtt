require 'rails_helper'

RSpec.describe Group, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).ignoring_case_sensitivity }

  it { is_expected.to have_and_belong_to_many(:users) }
  it { is_expected.to have_and_belong_to_many(:posts) }
end
