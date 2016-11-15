#Verifying elements of the user homepage

Given /I am on user homepage/ do
    #regexp = /Register to Play a Game/
    #expect page.body.to match(regexp)
    page.should have_content("Hello")
end