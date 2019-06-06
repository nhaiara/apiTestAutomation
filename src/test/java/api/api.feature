Feature: Dummy API

  Background: Precondition
    # Function for uuid generation
    Given def uuid = function(){ return java.util.UUID.randomUUID() + '' }
    # Function for random string generation
    And def random = function(max){ return Math.floor(Math.random() * max) + '' }

  Scenario: Use Case - Create, Validate, Delete, Validate

    # Define employee
    Given def employee = {"name":"#(uuid())","salary":"#(random(99999))","age":"#(random(99))"}

    # Create employee
    Given url "http://dummy.restapiexample.com/api/v1"
    And path "create"
    And request employee
    When method post

    Then status 200
    And match response contains employee
    And match response.id == "#string"

    Then def employee = response


    # Validate employee creation
    Given url "http://dummy.restapiexample.com/api/v1"
    And path "employee/" + employee.id
    When method get

    Then status 200
    Then match response == {"id":"#(employee.id)", "employee_name":"#(employee.name)", "employee_salary":"#(employee.salary)", "employee_age":"#(employee.age)", "profile_image":""}


    # Delete employee
    Given url "http://dummy.restapiexample.com/api/v1"
    And path "delete/" + employee.id
    When method delete

    Then status 200
    And match response == {"success":{"text":"successfully! deleted Records"}}


    # Validate employee deletion
    Given url "http://dummy.restapiexample.com/api/v1"
    And path "employee/" + employee.id
    When method get

    Then status 200
    And match response == "false"