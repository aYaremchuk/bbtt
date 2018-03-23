require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should validate_presence_of(:title) }

  it { should have_and_belong_to_many(:groups) }
  it { should belong_to(:user) }
end
