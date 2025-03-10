#!/bin/bash
SSH_QUIZ_PATH="${SSH_QUIZ_PATH:-/quiz}"
SSH_QUIZ_PARTICIPANTS_PATH="${SSH_QUIZ_PATH}/participants"

#Prompt the user for handle, remove any special characters, convert to lowercase, append PID to guarantee uniqueness
echo -e "Welcome Quiz Participant!\n\nEnter your handle (up to 7 letters, no spaces or special characters)--> \c"
read ANSWER
export HANDLE=$(echo $ANSWER | tr -dc '[:alnum:]\n\r' | tr '[:upper:]' '[:lower:]')$$
touch "${SSH_QUIZ_PARTICIPANTS_PATH}/$HANDLE"
echo -e "Thankyou $HANDLE, get ready to start the quiz!\n\nYou must answer each question before you can answer the next one.\nAnswers provided after the results are shown will not be counted.\nGood Luck!\n\n"
sleep 4

#This loops through the number of questions (20 in this example) and
#allows the participant to answer. Modify "20" to reflect the actual
#number of quiz questions.

for QUESTION in $(seq 1 20); do
  export QUESTION
  CHOICE=""
  RESULT=""
  FILENAME=""
  while true; do
    SECONDS=0
    echo -e "Please enter your choice for QUESTION $QUESTION (enter 1, 2, 3, or 4 only!)--> \c"
    read CHOICE
    export RESULT=$HANDLE-$SECONDS-$CHOICE
    export FILENAME="${SSH_QUIZ_PATH}/$QUESTION/$RESULT"
    if touch $FILENAME; then
      break
    else
      echo -e "You must wait for the question to be presented before you answer!"
      sleep 2
    fi 2>/dev/null
  done
done

echo -e "CONGRATULATIONS! You have successfully completed this quiz.\nYou have won a free copy of Fedora Linux that you can redeem using this personalized link: https://getfedora.org\n\nPress Enter to quit."
read DUMMY
