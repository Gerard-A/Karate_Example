Feature: Returning location data based on country and zip code
As a consumer of the Zippopotam.us API
I want to receive location data matching the country code and zip code I supply
So I can use this data to auto-complete forms on my web site

# Scenario: An existing country and zip code yields the correct place name
#     Given the country code 'us' and zip code '90210'
#     When I request the locations corresponding to these codes
#     Then the response contains the place name 'Beverly Hills'

# Scenario: An existing country and zip code yields the correct state name
#     Given the country code 'us' and zip code '90210'
#     When I request the locations corresponding to these codes
#     Then the response contains the state 'California'
#
#    Scenario: An existing country and zip code yields the correct HTTP status code
#        Given the country code 'us' and zip code '90210'
#        When I request the locations corresponding to these codes
#        Then the response has status code '200'
#
#    @NightTest
#    Scenario: A not existing country and zip code yields the correct HTTP status code
#        Given the country code 'xx' and zip code '90210'
#        When I request the locations corresponding to these codes
#        Then the response has status code '404'
#
#  Scenario: An existing country and not existing zip code yields the correct HTTP status code
#    Given the country code 'nl' and zip code '0000'
#    When I request the locations corresponding to these codes
#    Then the response has status code '404'
#
# Scenario Outline: Existing country and zip codes yield the correct place names
#     Given the country code '<country>' and zip code '<zip_code>'
#     When I request the locations corresponding to these codes
#     Then the response has status code '200'
#     And the response contains exactly '<nr_of_locations>' locations
#     And the response contains the place name '<place_name>'
#     And the response contains the state '<state_name>'
#
#     Examples:
#     | country | zip_code | place_name            | state_name    | nr_of_locations |
#     | us      | 90210    | Beverly Hills         | California    | 1               |
#     | ca      | B3M      | Halifax Bedford Basin | Nova Scotia   | 1               |
#     | nl      | 5653     | Eindhoven             | Noord-Brabant | 1               |


Scenario: An existing country and zip code yields the correct place name
    Given url 'https://api.zippopotam.us/'
    And path 'us', '90210'
    When method get
    Then match response.places[0].['place name'] == "Beverly Hills"

Scenario: An existing country and zip code yields the correct state name
    Given url 'https://api.zippopotam.us/'
    And path 'us', '90210'
    When method get
    Then match response.places[0].state == "California"

Scenario: An existing country and zip code yields the correct HTTP status code
    Given url 'https://api.zippopotam.us/'
    And path 'us', '90210'
    When method get
    Then status 200

Scenario: A not existing country and zip code yields the correct HTTP status code
    Given url 'https://api.zippopotam.us/'
    And path 'xx', '90210'
    When method get
    Then status 404

Scenario: An existing country and not existing zip code yields the correct HTTP status code
  Given url 'https://api.zippopotam.us/'
  And path 'nl', '0000'
  When method get
  Then status 404

Scenario Outline: Existing country '<country>' and zip codes '<zip_code>' yield the correct place names
    Given url 'https://api.zippopotam.us/'
    And path '<country>', '<zip_code>'
    When method get
    Then status 200
    And match response.places[*].['place name'] contains "<place_name>"
    And match response.places[*].state contains "<state_name>"
    And match response.places == '#[<nr_of_locations>]'

    Examples:
        | country | zip_code | place_name              | state_name    | nr_of_locations |
        | us      | 90210    | Beverly Hills           | California    | 1               |
        | ca      | B3M      | Halifax Bedford Basin   | Nova Scotia   | 1               |
        | nl      | 5653     | Eindhoven               | Noord-Brabant | 1               |
        | de      | 01067    | Dresden                 | Sachsen       | 3               |
        | de      | 01067    | Dresden Friedrichstadt  | Sachsen       | 3               |
        | de      | 01067    | Dresden Innere Altstadt | Sachsen       | 3               |
