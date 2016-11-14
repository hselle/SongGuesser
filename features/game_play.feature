Feature: game play multiple choice selection
  
  As a music lover seeking a challenge
  So that I can test my ability to guess a song title
  I want to be able to choose an answer from a multiple choice list
 
 Given I am on the game play page
 
 Scenario: there are 4 choices on the page
   Given I am on the games page
   Then I should see 4 answer boxes
 
 Scenario: I select the correct answer
   Given I am on the games page
   When the following answer is correct: Formation
   And I select the following answer: Formation
   When I press "submit answer" button
   Then I should be on the games page
   And I should see "correct answer"
 
 Scenario: I select the wrong answer
   Given I am on the games page
   When the following answer is correct: Gold
   But I select the following answer: Caroline
   When I press "submit answer" button
   Then I should be on the games page
   And I should see "incorrect answer"