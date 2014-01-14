@javascript
Feature: Access student data
  In order to interact with Student data
  As a FitQik web service client
  I wish to be able to create, fetch, modify and delete records
  
  Scenario: Show all users
    Given A credentialed user
    When They visit the students url
    Then The api service will return a list of all Students

