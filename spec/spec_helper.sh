# shellcheck shell=bash

# Defining variables and functions here will affect all specfiles.
# Change shell options inside a function may cause different behavior,
# so it is better to set them here.
# set -eu

# This callback function will be invoked only once before loading specfiles.
spec_helper_precheck() {
  # Available functions: info, warn, error, abort, setenv, unsetenv
  # Available variables: VERSION, SHELL_TYPE, SHELL_VERSION
  : minimum_version "0.29.0"
}

# This callback function will be invoked after a specfile has been loaded.
spec_helper_loaded() {
  :
}

# This callback function will be invoked after core modules has been loaded.
spec_helper_configure() {
  # Available functions: import, before_each, after_each, before_all, after_all
  : import 'support/custom_matcher'
}

# Add setup and necessary mocks
setup() {
  SSH_QUIZ_PATH="$(mktemp -d quiz.test.XXXX)"
  export SSH_QUIZ_PATH
  mkdir -p "${SSH_QUIZ_PATH}/participants"
  mkdir -p "${SSH_QUIZ_PATH}/"{1..20}
}

# Add cleanup function to delete files and directories created during the test
cleanup() {
  rm -rf "$SSH_QUIZ_PATH"
}

# # Add mocks for built-in commands
# read() {
#   echo $@
#   echo "$ANSWER"
#   sleep 1
# }

# Wrap quiz into a function
quiz() {
  ./spec/simulate_participant.exp
}