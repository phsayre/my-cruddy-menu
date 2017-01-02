#!/bin/bash
#
#Copyright 2016 Philip Sayre <phsayre@gmail.com>
#Huge thanks to Christopher Kruzcek
#
#  This software is being distributed under the: 
#	GNU General Public License v3.
#	For full details of the license.
#	see: http://www.gnu.org/copyleft/gpl.html 
#
# Date : 12-15-2016
#
# Project:  Command line menu interface for custom MySQL database
#
#
#
#
#
#
#
#
#
displayMenu()
 {
	printf "Dorm Database Main Menu:"
	printf "\n\t 1. Create Options" 
	printf "\n\t 2. Read Options"
	printf "\n\t 3. Update Options"
	printf "\n\t 4. Delete Options"
	#etc....
	printf "\n\t q. Quit"
 }

menu()
 {
	displayMenu
	printf "\n\n"
	read -e -p "Pick an Option: " OPTION
 	case $OPTION in
 		[1] ) clear; menuOne;;
 		[2] ) clear; menuTwo;;
 		[3] ) clear; menuThree;;
		[4] ) clear; menuFour;;
 
 		[Qq] ) printf "Goodbye! \n"; exit 1;; #Terminate the Menu.
                ?* ) printf "Not a valid item! Please try something else!\n";;
 
 	esac
 	read -p "Press Enter to return to Main Menu...." NULL
        clear
        menu
 }

displayMenuOne()
 {
	printf "Menu One:\n"
	printf "\n\t 1. Create Student Record" 
	printf "\n\t 2. Create Hallroom Record"
	printf "\n\t 3. Create Assignment Record"
	printf "\n\t q. << Return to Main Menu"
	printf "\n"
 }

menuOne()
{
	displayMenuOne
	printf "\n"
	read -e -p "Pick an Option: " OPTION
 	case $OPTION in
 		[1] ) printf "Creating Student Record...\n\n";read -e -p "Enter student name: " inputVar1;read -e -p "Enter student gender (0 = female, 1 = male): " inputVar2; createStudent $inputVar1, $inputVar2;;
 		[2] ) printf "Creating Hallroom Record...\n\n";read -e -p "Enter Hallroom number (unique alphanumeric combo): " inputVar1;read -e -p "Enter hallroom capacity: " inputVar2; createHallroom $inputVar1, $inputVar2;;
 		[3] ) printf "Creating Assignment Record...\n\n";mysql --login-path=local -e "USE dorm; SELECT * FROM student;";printf "\n";read -e -p "Enter student id: " inputVar1;mysql --login-path=local -e "USE dorm; SELECT * FROM hallroom;";printf "\n";read -e -p "Enter hallroom id: " inputVar2; createAssignment $inputVar1, $inputVar2;;
 
 		[Qq] ) clear; menu;; # go back to main menu
                ?* ) printf "Not a valid item! Please try something else!\n";;
 
 	esac # End of case statment.
 	read -p "Press Enter to return to Menu...." NULL
        clear
	menuOne # Run menuOne Program again....



}



createStudent()
{
	printf "\n\nStudent Record Created!\n\n"
	mysql --login-path=local -s -e "USE dorm; INSERT INTO student VALUES (DEFAULT,'"$inputVar1"',"$inputVar2");"
	mysql --login-path=local -e "USE dorm; SELECT * FROM student WHERE s_id=(SELECT MAX(s_id) FROM student);"
	printf "\n"
}


createHallroom()
{
        printf "\n\nHallroom Record Created!\n\n"
        mysql --login-path=local -s -e "USE dorm; INSERT INTO hallroom VALUES (DEFAULT,'"$inputVar1"',"$inputVar2");"
        mysql --login-path=local -e "USE dorm; SELECT * FROM hallroom WHERE hr_id=(SELECT MAX(hr_id) FROM hallroom);"
        printf "\n"
}


createAssignment()
{
        printf "\n\nAssignment Record Created!\n\n"
        mysql --login-path=local -s -e "USE dorm; INSERT INTO assignment VALUES (DEFAULT,"$inputVar1","$inputVar2",DEFAULT);"
        mysql --login-path=local -e "USE dorm; SELECT * FROM assignment WHERE a_id=(SELECT MAX(a_id) FROM assignment);"
        printf "\n"
}



displayMenuTwo()
 {
        printf "Menu Two:\n"
        printf "\n\t 1. Read Student Table"
        printf "\n\t 2. Read Hallroom Table"
        printf "\n\t 3. Read Assignment Table"
        printf "\n\t q. << Return to Main Menu"
        printf "\n"
 }


menuTwo()
{
        displayMenuTwo
        printf "\n"
        read -e -p "Pick an Option: " OPTION
        case $OPTION in
                [1] ) mysql --login-path=local -e "USE dorm; SELECT * FROM student;";;
                [2] ) mysql --login-path=local -e "USE dorm; SELECT * FROM hallroom;";;
                [3] ) mysql --login-path=local -e "USE dorm; SELECT * FROM assignment;";;

                 [Qq] ) clear; menu;; # go back to main menu
                 ?* ) printf "Not a valid item! Please try something else!\n";;
        esac # End of case statment.
        read -p "Press Enter to return to Menu...." NULL
        clear
        menuTwo # Run menuTwo Program again....

}



displayMenuThree()
 {
        printf "Menu Three:\n"
        printf "\n\t 1. Update Student Record"
        printf "\n\t 2. Update Hallroom Record"
        printf "\n\t q. << Return to Main Menu"
        printf "\n"
 }


menuThree()
{
        displayMenuThree
        printf "\n"
        read -e -p "Pick an Option: " OPTION
        case $OPTION in
                [1] ) mysql --login-path=local -e "USE dorm; SELECT * FROM student;";printf "\n";printf "Updating Student Record...\n\n";read -e -p "Enter student id: " inputVar1;read -e -p "Update student name: " inputVar2; updateStudent $inputVar1, $inputVar2;;
                [2] ) mysql --login-path=local -e "USE dorm; SELECT * FROM hallroom;";printf "\n";printf "Updating Hallroom Record...\n\n";read -e -p "Enter hallroom id: " inputVar1;read -e -p "Update hallroom number (unique alphanumeric combo): " inputVar2;read -e -p "Update hallroom capacity: " inputVar3; updateHallroom $inputVar1, $inputVar2, $inputVar3;;
                [Qq] ) clear; menu;; # go back to main menu
                ?* ) printf "Not a valid item! Please try something else!\n";;
        esac # End of case statment.
        read -p "Press Enter to return to Menu...." NULL
        clear
        menuThree # Run menuThree Program again....

}


updateStudent()
{
        printf "\n\nStudent Record Updated!\n\n"
        mysql --login-path=local -s -e "USE dorm; UPDATE student SET s_name='"$inputVar2"' WHERE s_id='"$inputVar1"';"
        mysql --login-path=local -e "USE dorm; SELECT * FROM student WHERE s_id="$inputVar1";"
        printf "\n"
}


updateHallroom()
{
        printf "\n\nHallroom Record Updated!\n\n"
        mysql --login-path=local -s -e "USE dorm; UPDATE hallroom SET hr_number='"$inputVar2"', hr_capacity='"$inputVar3"' WHERE hr_id="$inputVar1";"
        mysql --login-path=local -e "USE dorm; SELECT * FROM hallroom WHERE hr_id="$inputVar1";"
        printf "\n"
}



displayMenuFour()
{
        printf "Menu Four:\n"
        printf "\n\t 1. Delete Student Record"
        printf "\n\t 2. Delete Hallroom Record"
        printf "\n\t 3. Delete Assignment Record"
        printf "\n\t q. << Return to Main Menu"
        printf "\n"
}

menuFour()
{
        displayMenuFour
        printf "\n"
        read -e -p "Pick an Option: " OPTION
        case $OPTION in
                 [1] ) mysql --login-path=local -e "USE dorm; SELECT * FROM student;";printf "\n";read -e -p "Enter student id: " inputVar1; deleteStudent $inputVar1;;
                 [2] ) mysql --login-path=local -e "USE dorm; SELECT * FROM hallroom;";printf "\n";read -e -p "Enter hallroom id: " inputVar1; deleteHallroom $inputVar1;;
                 [3] ) mysql --login-path=local -e "USE dorm; SELECT * FROM assignment;";printf "\n";read -e -p "Enter assignment id: " inputVar1; deleteAssignment $inputVar1;;
                 [Qq] ) clear; menu;; # go back to main menu
                 ?* ) printf "Not a valid item! Please try something else!\n";;
        esac # End of case statment.
        read -p "Press Enter to return to Menu...." NULL
        clear
        menuFour # Run menuFour Program again....

}


deleteStudent()
{
        printf "\n\nStudent Record Deleted!\n\n"
        mysql --login-path=local -s -e "USE dorm; DELETE from student WHERE s_id="$inputVar1";"
        mysql --login-path=local -e "USE dorm; SELECT * FROM student;"
        printf "\n"
}


deleteHallroom()
{
        printf "\n\nHallroom Record Deleted!\n\n"
        mysql --login-path=local -s -e "USE dorm; DELETE from hallroom WHERE hr_id="$inputVar1";"
        mysql --login-path=local -e "USE dorm; SELECT * FROM hallroom;"
        printf "\n"
}


deleteAssignment()
{
        printf "\n\nAssignment Record Deleted!\n\n"
        mysql --login-path=local -s -e "USE dorm; DELETE from assignment WHERE a_id="$inputVar1";"
        mysql --login-path=local -e "USE dorm; SELECT * FROM assignment;"
        printf "\n"
}



clear # Clear the screen before displaying the main menu.
menu # Run the Main Menu function after all of the other functions.

