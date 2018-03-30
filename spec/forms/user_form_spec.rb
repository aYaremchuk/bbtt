require 'rails_helper'

describe UserForm do
  let(:user) { FactoryBot.create(:user) }
  describe 'initialize' do
    subject(:new) { UserForm.new }
    subject(:new_filled) { UserForm.new(attributes_for(:user).except(:password, :password_confirmation)) }
    subject(:existing) { UserForm.new(id: user.id) }

    it 'empty user' do
      expect(new.id).to be_nil
      expect(new.email).to be_nil
      expect(new.first_name).to be_nil
    end

    it 'new user filled' do
      expect(new_filled.email).to_not be_nil
      expect(new_filled.first_name).to_not be_nil
      expect(new_filled.last_name).to_not be_nil
    end

    it 'set variable to existing user' do
      expect(existing.instance_variable_get(:@user)).to eq user
    end
  end

  describe 'save' do
    context 'failure' do
      subject { UserForm.new(attributes_for(:user).except(:password, :password_confirmation, :email)).save }

      it 'returns false' do
        expect(subject).to eq false
      end
    end

    context 'success' do
      let(:group) { FactoryBot.create(:group) }
      let(:group1) { FactoryBot.create(:group, name: 'Group1') }

      subject(:user_without_group) do
        UserForm.new(attributes_for(:user)
                                                      .except(:password, :password_confirmation))
                .save
      end
      subject(:user_with_group) do
        UserForm.new(attributes_for(:user)
                         .except(:role, :password, :password_confirmation)
                         .merge(group_ids: [group.id]))
                .save
      end

      it 'returns true and creates user record' do
        expect(User.count).to eq 0
        expect(user_without_group).to eq true
        expect(User.count).to eq 1
        expect(User.first.groups).to be_empty
      end

      it 'returns true and creates user with group' do
        expect(User.count).to eq 0
        expect(user_with_group).to eq true
        expect(User.count).to eq 1
        expect(User.first.groups.count).to eq 1
        expect(User.first.groups).to include(group)
      end
    end
  end

  describe 'update' do
    subject do
      UserForm.new(id: user.id,
                   role: 'admin',
                   first_name: 'new first name',
                   last_name: 'new last name')
              .update
    end

    it 'updates attributes' do
      expect(subject).to eq true
      user.reload
      expect(user.role).to eq 'admin'
      expect(user.first_name).to eq 'new first name'
      expect(user.last_name).to eq 'new last name'
    end
  end
end
