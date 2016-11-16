#Verifying elements of the login / register page


Given /I am on the login page/ do
    #regexp = /Register to Play a Game/
    #expect page.body.to match(regexp)
    page.should have_content("Register to Play a Game")
end


When /the following user is in the database: (.*) (.*)$/ do |name, password| 
    user = User.create!(username: name, pasword: password)
    user.wins ||= ""
    user.losses ||= ""
    user.songs ||= ""
    user.records ||= ""
    user.save!
end
    
When /I log in with the following user: (.*) (.*)/ do |name, pass|
    fill_in 'usernameSignIn', :with => name
    fill_in 'passwordSignIn', :with => pass
end
    
When /I enter the following username: (.*)$/ do |name|
    fill_in 'usernameSignUp', :with => name
end

When /I enter the following password: (.*)$/ do |pass|
    fill_in 'passwordSignUp', :with => pass
end
    
Then /I should see (.*) text box and (.*) text box/ do |username, password|
    regexp = /#{username}.*#{password}/m
    expect(page.body).to match(regexp)
end


And /I should see (.*) button/ do
    regexp = /register/
    expect(page.body).to match(regexp)
end


And /I should see (.*) button/ do
    regexp = /login/
    expect(page.body).to match(regexp)
end