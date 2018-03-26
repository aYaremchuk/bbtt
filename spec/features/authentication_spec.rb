require 'rails_helper'

feature 'authentication' do
  let(:user) { FactoryBot.create(:user, email: 'test@mail.com', password: '12345678') }
  let(:admin) { FactoryBot.create(:user, :admin, email: 'admin@mail.com', password: '12345678') }

  context 'login', js: true do
    context 'user' do
      before do
        user
        visit root_path
      end

      scenario 'check login' do
        fill_in 'user_email', with: 'test@mail.com'
        fill_in 'user_password', with: '12345678'

        find('input[type="submit"]').click

        expect(page).to have_css('span.user_name')
        expect(page).to have_text('test@mail.com')
        visit admin_path
        expect(page).to have_current_path(root_path)
      end
    end

    context 'admin' do
      before do
        admin
        visit root_path
      end

      scenario 'check login' do
        fill_in 'user_email', with: 'admin@mail.com'
        fill_in 'user_password', with: '12345678'

        find('input[type="submit"]').click

        expect(page).to have_css('span.user_name')
        expect(page).to have_text('admin@mail.com')

        visit admin_path
        expect(page).to have_current_path(admin_path)
        expect(page).to have_css('div.card-body.p-3.clearfix')
        expect(page).to have_text('Users')
      end
    end
  end
end
