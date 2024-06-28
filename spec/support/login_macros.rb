# spec/support/login_macros.rb

module LoginMacros
  def login_as(user)
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: 'password'
    click_button 'サインイン'
  end
end
