require 'spec_helper'

feature 'User authentication' do
  scenario "when user already exists, signs in" do
    user = create(:user)
    stub_repo_requests(AuthenticationHelper::GITHUB_TOKEN)

    sign_in_as(user)

    expect(page).to have_content user.github_username
    expect(analytics).to have_tracked("Signed In").for_user(user)
  end

  scenario "when user doesn't exist, signs up" do
    github_username = "croaky"
    user = build(:user, github_username: github_username)
    stub_repo_requests(AuthenticationHelper::GITHUB_TOKEN)

    sign_in_as(user)

    user = User.where(github_username: github_username).first
    expect(page).to have_content(github_username)
  end

  scenario 'user signs out' do
    user = create(:user)
    stub_repo_requests(AuthenticationHelper::GITHUB_TOKEN)
    sign_in_as(user)

    find('a[href="/sign_out"]').click

    expect(page).not_to have_content user.github_username
  end
end
