require 'rails_helper'

RSpec.describe UserPolicy do
  subject(:policy) { described_class }

  permissions :show? do
    it 'is denied for not logged' do
      is_expected.not_to permit(nil, create(:user))
    end

    it 'is denied to show a foreign user' do
      is_expected.not_to permit(build(:user), create(:user))
    end

    it 'is granted to show itself' do
      a_user = create(:user, id: '1')
      expect(policy).to permit(a_user, a_user)
    end
  end
end
