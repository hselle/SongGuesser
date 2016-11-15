#Verifying elements of the user homepage

Given /I am on user homepage/ do
    page.should have_content("Hello")
end