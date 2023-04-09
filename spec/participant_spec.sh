#shellcheck shell=bash

Describe "Participant Script"

  Mock sleep
    # No time for sleep, we're testing here!
    echo sleep $@
  End

  BeforeEach "setup"
  AfterEach "cleanup"

  It "gives a welcome message"
    When call quiz
    The status should be success
    The output should include "Welcome Quiz Participant!"
  End

  It "asks for your handle"
    When call quiz
    The status should be success
      The output line "4" should include "Enter your handle (up to 7 letters, no spaces or special characters)--> TestUser"
      The status should be success
  End

  It "congratulate users for finishing the quiz"
    When call quiz
    The status should be success
      The output line "33" should include "CONGRATULATIONS! You have successfully completed this quiz."
      The status should be success
  End

  It "should refer people to fedora"
    When call quiz
    The status should be success
      The output line "34" should include "https://getfedora.org"
      The status should be success
  End
End
