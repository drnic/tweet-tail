Feature: Live twitter search results on command line
  In order to reduce cost of getting live search results
  As a twitter user
  I want twitter search results appearing in the console

  Scenario: Display some search results
    Given twitter has some search results for "jaoo"
    When I run local executable "tweet-tail" with arguments "jaoo"
    Then I should see some twitter messages
  
  Scenario: Display explicit search results
    Given twitter has some search results for "jaoo"
    When I run executable internally with arguments "jaoo"
    Then I should see
      """
      mattnhodges: Come speak with me at JAOO next week - http://jaoo.dk/
      Steve_Hayes: @VenessaP I think they went out for noodles. #jaoo
      theRMK: Come speak with Matt at JAOO next week
      drnic: reading my own abstract for JAOO presentation
      """
  
  Scenario: Poll for results until app cancelled
    Given twitter has some search results for "jaoo"
    When I run executable internally with arguments "jaoo -f" and wait 1 sleep cycle and quit
    Then I should see
      """
      mattnhodges: Come speak with me at JAOO next week - http://jaoo.dk/
      Steve_Hayes: @VenessaP I think they went out for noodles. #jaoo
      theRMK: Come speak with Matt at JAOO next week
      drnic: reading my own abstract for JAOO presentation
      CaioProiete: Wish I could be at #JAOO Australia...
      """
  
  Scenario: Show help if no search query passed
    When I run local executable "tweet-tail" with arguments ""
    Then I should see help option "-f"
  
  
  
