Feature: Merge Articles
  As a blog administrator
  In order to avoid duplicate content on a topic
  I want to be able to merge two similar articles

  Background:
    Given the blog is set up
    And the following articles exist:
    | id    | title                     | body        | id_user |
    | 1     | My Article                | Lorem Ipsum | 2       |
    | 2     | Another Similar Article   | Ipsis Liris | 3       |
    And the following comments exist:
    | id    | content           | id_article |
    | 1     | Some comment      | 1          |
    | 2     | Another comment   | 2          |
    
  Scenario: When articles are merged, the merged article should contain the text of both previous articles
    Given I am logged as a blog administrator
    And I am on admin content page for article "1"
    When I fill in "merge_with" with "2"
    And I press "Merge"
    Then I should be on the admin content page
    When I go to the "3" article page
    Then I should see "Lorem Ipsum"
    And I should see "Ipsis Liris"
    And I should see "Anyone"
    And I should not see "Someone"
    And I should see "Some comment"
    And I should see "Another comment"
    
  Scenario: A non-admin cannot merge two articles
    Given I am logged as author "2"
    And I am on admin content page for article "1"
    When I fill in "merge_with" with "2"
    And I press "Merge"
    Then I should be on the admin content page
    And I should see "Non-admin cannot merge two articles"
