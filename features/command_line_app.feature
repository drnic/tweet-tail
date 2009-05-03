Feature: Live twitter search results on command line
  In order to reduce cost of getting live search results
  As a twitter user
  I want twitter search results appearing in the console

  Scenario: Display current search results
    Given a safe folder
    And twitter has some search results for "jaoo"
    When I run local executable "tweet-tail" with arguments "jaoo"
    Then I should see
      """
      mattnhodges: Come speak with me at JAOO next week - http://jaoo.dk/
      Steve_Hayes: @VenessaP I think they went out for noodles. #jaoo
      theRMK: Come speak with Matt at JAOO next week
      drnic: reading my own abstract for JAOO presentation
      """
  