#Verifying that elements of the game play page exists


Given /I am on the game play page/ do
    page.should have_content("Submit answer")
end

Then /I should see (\d+) answer boxes$/ do |count, answer|
  expect(page).to have_css(answer, count: 4)
end

When /the following answer is correct: (.*)/ do |choose|
  answer.split(' ').each do |field|
  if choose
    choose(answer)
  end
  end
end

Then /I should see: (.*)/ do |text|
  if page.respond_to? :should
    page.should have_content("correct answer")
  else
    assert page.has_content?(text)
  end
end

When /the following answer is incorrect: (.*)/ do |choose|
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