require 'rails_helper'
require 'capybara/rspec'
describe 'Post controller and view spec', type: :feature do
  before :each do
    a = User.new(name: 'gajksj', email: 'user@example.com', password: 'password1234')
    a.save
    b = User.new(name: 'gfdgsj', email: 'ali@example.com', password: 'password1234')
    b.save
    c = Friendship.new(user_id: 1, friend_id: 2, confirmed: false)
    c.save
    visit '/users/sign_in'
    within('form') do
      fill_in 'user[email]', with: 'user@example.com'
      fill_in 'user[password]', with: 'password1234'
    end
    click_button 'commit'
  end
  it 'post creation' do
    visit '/posts'
    within('form') do
      fill_in 'post[content]', with: 'blah blah blah'
    end
    click_button 'commit'
    expect(page).to have_content 'blah blah blah'
  end
  it 'like' do
    visit '/posts'
    within('form') do
      fill_in 'post[content]', with: 'blah blah blah'
    end
    click_button 'commit'
    expect(page).to have_content('Like!')
  end
  it 'like a post' do
    visit '/posts'
    within('form') do
      fill_in 'post[content]', with: 'blah blah blah'
    end
    click_button 'commit'
    click_link 'Like!'
    expect(page).to have_content('You liked a post.')
  end
  it 'commments' do
    visit '/posts'
    within('form') do
      fill_in 'post[content]', with: 'blah blah blah'
    end
    click_button 'commit'
    within('#new_comment') do
      fill_in 'comment[content]',	with: '1st comment'
    end
    click_button 'cmt'
    expect(page).to have_content '1st comment'
  end
end
