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

Scenario: An existing country and zip code yields the correct place name
    Given url 'https://api.zippopotam.us/'
    And path 'us', '90210'
    When method get
    Then status 200
    And print response
    And match response.places[0].['place name'] == "Beverly Hills"

Scenario: An existing country and zip code yields the correct state name
    Given url 'https://api.zippopotam.us/'
    And path 'us', '90210'
    When method get
    Then status 200
    And print response
    And match response.places[0].state == "California"
