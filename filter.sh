#!/bin/bash

sections=("TITLE" "SUMMARY" "KEYWORDS" "MAIN_OBJETIVE" "METHOD" "RESULTS" "CONCLUSIONS" "RELEVANCE" "MULTISECTIONS")
regex=("[Cc][Oo]2" "*Amine*" "3" "4" "5" "6" "7" "8" "Custom")



#Functions
PRINTSECTION_FUNCT(){
        PARAM_NUM=$((SECTION_NUM_RETRN + 2))
	echo $PARAM_NUM
        echo "$1 - ${!PARAM_NUM}"
}




#Follow for sections where you need to search
echo "Choose a section for search"
for (( i=0; i<${#sections[@]}; i++ )); do
    echo "$((i+1))) ${sections[i]}"
done
read SECTION_NUM

if [[ $SECTION_NUM -eq 9 ]]; then
    echo "Insert the multi sections (Pending implement)"
    read SECTION
else
    SECTION="${sections[SECTION_NUM-1]}"
fi


#Follow for sections that you want that return if the regex match
echo "Choose your return section in case of matches"
for (( i=0; i<${#sections[@]}; i++ )); do
    echo "$((i+1))) ${sections[i]}"
done
read SECTION_NUM_RETRN

if [[ $SECTION_NUM_RETRN -eq 9 ]]; then
    echo "Insert the multi sections (Pending implement)"
    read SECTION_RTRN
else
    SECTION_RTRN="${sections[SECTION_NUM-1]}"
fi


#Follow for choose regex
echo "Choose a regex for search:"
for (( i=0; i<${#regex[@]}; i++ )); do
    echo "$((i+1))) ${regex[i]}"
done
read REGEX_NUM

if [[ $REGEX_NUM -eq 9 ]]; then
    echo "Insert the regex for search"
    read PATRON
else
    PATRON="${regex[REGEX_NUM-1]}"
fi

#Print Selections
echo "Patron $PATRON | section for search $SECTION | section for return $SECTION_RTRN"

#Search
cat text.csv | while IFS="," read -r TITLE SUMMARY KEYWORDS MAIN_OBJETIVE METHOD RESULTS CONCLUSIONS RELEVANCE; do
    case $SECTION in
        ${sections[0]}) #Modify if condition
            if [[ $TITLE =~ $PATRON ]]; then
                PRINTSECTION_FUNCT $SECTION_RTRN $SECTION_NUM_RETRN $TITLE $SUMMARY $KEYWORDS $MAIN_OBJETIVE $METHOD $RESULTS $CONCLUSIONS $RELEVANCE
            fi
            ;;
        ${sections[1]})
            if [[ $SUMMARY =~ $PATRON ]]; then
                PRINTSECTION_FUNCT $SECTION_RTRN $SECTION_NUM_RETRN $TITLE $SUMMARY $KEYWORDS $MAIN_OBJETIVE $METHOD $RESULTS $CONCLUSIONS $RELEVANCE
            fi
            ;;
        ${sections[2]})
            if [[ $KEYWORDS =~ $PATRON ]]; then
                PRINTSECTION_FUNCT $SECTION_RTRN $SECTION_NUM_RETRN $TITLE $SUMMARY $KEYWORDS $MAIN_OBJETIVE $METHOD $RESULTS $CONCLUSIONS $RELEVANCE
            fi
            ;;
        ${sections[3]})
            if [[ $MAIN_OBJETIVE =~ $PATRON ]]; then
                PRINTSECTION_FUNCT $SECTION_RTRN $SECTION_NUM_RETRN $TITLE $SUMMARY $KEYWORDS $MAIN_OBJETIVE $METHOD $RESULTS $CONCLUSIONS $RELEVANCE
            fi
            ;;
        ${sections[4]})
            if [[ $METHOD =~ $PATRON ]]; then
                PRINTSECTION_FUNCT $SECTION_RTRN $SECTION_NUM_RETRN $TITLE $SUMMARY $KEYWORDS $MAIN_OBJETIVE $METHOD $RESULTS $CONCLUSIONS $RELEVANCE
            fi
            ;;
        ${sections[5]})
            if [[ $RESULTS =~ $PATRON ]]; then
                PRINTSECTION_FUNCT $SECTION_RTRN $SECTION_NUM_RETRN $TITLE $SUMMARY $KEYWORDS $MAIN_OBJETIVE $METHOD $RESULTS $CONCLUSIONS $RELEVANCE
            fi
            ;;
        ${sections[6]})
            if [[ $CONCLUSIONS =~ $PATRON ]]; then
                PRINTSECTION_FUNCT $SECTION_RTRN $SECTION_NUM_RETRN $TITLE $SUMMARY $KEYWORDS $MAIN_OBJETIVE $METHOD $RESULTS $CONCLUSIONS $RELEVANCE
            fi
            ;;
        ${sections[7]})
            if [[ $RELEVANCE =~ $PATRON ]]; then
                PRINTSECTION_FUNCT $SECTION_RTRN $SECTION_NUM_RETRN $TITLE $SUMMARY $KEYWORDS $MAIN_OBJETIVE $METHOD $RESULTS $CONCLUSIONS $RELEVANCE
            fi
            ;;
        ${sections[8]})
            #CUSTOM SEARCH PENDING
            ;;
        *)
            echo "No section"
            ;;
    esac
done

