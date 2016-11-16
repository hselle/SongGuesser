#Verifying elements of the user homepage

Given /I am on user homepage/ do
    page.should have_content("Hello")
end

Then /I should see: (.*)/ do |text|
  if page.respond_to? :should
    page.should have_content("Your games:")
  else
    assert page.has_content?(text)
  end
end

And /I should see: (.*)/ do |text|
  if page.respond_to? :should
    page.should have_content("Ranking")
  else
    assert page.has_content?(text)
  end
end

And /I should see: (.*)/ do |text|
  if page.respond_to? :should
    page.should have_content("Play")
  else
    assert page.has_content?(text)
  end
end