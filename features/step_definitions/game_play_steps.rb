#Verifying that elements of the game play page exists


Given /I am on the games page/ do
    page.should have_content("Submit answer")
end

Then /I should see four answers: (.*) (.*) (.*) (.*)/ do |answer_list|
  page.should have_content(answer_list)
end

When /I choose the following correct answer: (.*)/ do |choose, answer_list|
  answer_list.split(', ').each do |field|
  if choose
    choose("answer_#{list}")
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

When /I choose the following incorrect answer: (.*)/ do |choose, answer_list|
  answer_list.split(', ').each do |field|
  if choose
    choose("answer_#{list}")
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