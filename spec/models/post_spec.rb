require 'rails_helper'

RSpec.describe Post, type: :model do
  it { is_expected.to validate_presence_of(:title) }

  it { is_expected.to have_and_belong_to_many(:groups) }
  it { is_expected.to belong_to(:user) }
end
