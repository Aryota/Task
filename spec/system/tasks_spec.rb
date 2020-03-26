require 'rails_helper'
# User.create!(name: 'admin', email: 'admin@aaa.com', password: 'password', password_confirmation: 'password', admin: true)
describe 'task_management', type: :system do
    let(:user_a) { create(:user, name: 'user_A', email: 'a@example.com') }
    let(:user_b) { create(:user, name: 'user_B', email: 'b@example.com') }
    let!(:task_a) { create(:task, name: 'first_task', user: user_a) }

    before do
        visit login_path
        fill_in 'session[email]', with: login_user.email
        fill_in 'session[password]', with: login_user.password
        click_button 'commit'
    end

    shared_examples_for 'task created by user A is displayed' do
        it { expect(page).to have_content 'first_task' }
    end

    describe 'list_fanction' do
        context 'when userA is logged in' do
            let(:login_user) { user_a }

            it_behaves_like 'task created by user A is displayed'
        end

        context 'when userB is logged in' do
            let(:login_user) { user_b }
            it 'Tasks created by user A are not displayed' do
                expect(page).to have_no_content 'first_task'
            end
        end
    end

    describe 'Detailed display function' do
        context 'when userA is logged in' do
            let(:login_user) { user_a }

            before { visit task_path(task_a) }

            it_behaves_like 'task created by user A is displayed'
        end
    end

    describe 'new create function' do
        let(:login_user) { user_a }

        before do
            visit new_task_path
            fill_in 'task[name]', with: task_name
            click_button 'Create Task'
        end

        context 'When entering a name on the new creation screen' do
            let(:task_name) { 'new task create' }

            it 'registered normally' do
                expect(page).to have_selector '.alert-success', text: 'new task create'
            end
        end

        context 'when no mname is fectered the new creation screen' do
            let(:task_name) { '' }

            it 'error' do
                within '#error_explanation' do
                    expect(page).to have_content 'Name can\'t be blank'
                end
            end
        end
    end
end
