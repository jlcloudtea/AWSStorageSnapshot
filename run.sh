#!/bin/bash

PS3='Please enter your choice or press 3 to quit: '
options=("Create Storage Management Stack" "Delete Storage Management Stack" "Quit")
select opt in "${options[@]}"
do
  case $opt in
	"Create Storage Management Stack")
	  echo "you chose choice 1"
	  echo '-------------------------------------------------------------'
	  echo ' 	Please wait 2-5 mins until new prompt message...           '
	  echo '-------------------------------------------------------------'
	  aws cloudformation create-stack --stack-name StorageMan --template-body "file://StorageMan.yaml" >/dev/null 2>&1
	  aws cloudformation wait stack-create-complete --stack-name StorageMan
 	  echo '-------------------------------------------------------------'
	  echo '	Setup Completed You can start the assessment tasks          '
	  echo '-------------------------------------------------------------'
	  echo "Below is the related information for your reference"
    	  aws cloudformation describe-stacks --stack-name StorageMan --query "Stacks[*].Outputs[*].{OutputKey: OutputKey, OutputValue: OutputValue, Description: Description}" --output table
	  break
	  ;;
	"Delete Storage Management Stack")
	  aws cloudformation delete-stack --stack-name StorageMan
	  echo '-------------------------------------------------------------'
	  echo '	Deleting Tag Management Stack may takes 2-5 mins    '
	  echo '-------------------------------------------------------------'
	  break
	  ;;
	"Quit")
	  break
	  ;;
   	*) echo "invalid option $REPLY";;
  esac
done
