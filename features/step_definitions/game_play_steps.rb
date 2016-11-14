#Verifying that elements of the game play page exists


Given /I am on the game play page/ do
    page.should have_content("Submit answer")
end



Then /I should see: (.*)/ do |text|
  if page.respond_to? :should
    page.should have_content("correct answer")
  else
    assert page.has_content?(text)
  end
end

When /I should see either "wrong" or "right"/ do
  expect(page.body).to match(/wrong|right/)
end

When /the following answer is incorrect: (.*)/ do |choose, answer|
  answer.split(' ').each do |field|
  if choose
    choose(answer)
  end
  end
end

Then /I should see: (.*)/ do |text|
  if page.respond_to? :should
    page.should have_content("incorrect answer")
  else
    assert page.has_content?(text)
  end
end