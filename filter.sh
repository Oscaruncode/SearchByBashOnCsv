#!/bin/bash	

sections=("TITLE" "SUMMARY" "KEYWORDS" "MAIN_OBJETIVE" "METHOD" "RESULTS" "CONCLUSIONS" "RELEVANCE" "MULTISECTIONS" "ALL")
regex=("[Cc][Oo]2" "[Aa][Mm][Ii][Nn]" "[Nn][Aa][Nn][Oo]" "[Ii][Oo][Nn][Ii][Cc]" "[Mm][Ii][Nn][Ee][Rr]" "[Cc][Aa][Pp][Tt][Uu][Rr]" "[Aa][Bb][Ss][Oo][Rr]" "[[Ff][Ll][Uu][Ii]" "Custom" "[Mm][Ee][Mm]")

#$TITLE $SUMMARY $KEYWORDS $MAIN_OBJETIVE $METHOD $RESULTS $CONCLUSIONS $RELEVANCE

#Function show return section in case that match info // **PENDING*** Pending replace this for pull into a file.txt with the results of the query
PRINTSECTION_FUNCT(){  
	echo $SECTION_RTRN
	 case $SECTION_RTRN in
        ${sections[0]}) echo "$TITLE" ;;
          ${sections[1]}) echo "$SUMMARY" ;;
            ${sections[2]}) echo "$KEYWORDS" ;;
              ${sections[3]}) echo "$MAIN_OBJETIVE" ;;
                ${sections[4]}) echo "$METHOD" ;;
                  ${sections[5]}) echo "$RESULTS" ;;
                    ${sections[6]}) echo "$CONCLUSIONS" ;;
                      ${sections[7]}) echo "$RELEVANCE" ;;
                        ${sections[8]}) echo "MULTI-RETURN" ;; #**PENDING***
                         ${sections[9]}) echo "$ALLTEXT";;
               		*) echo "Non-Case" ;;
	esac
}




#Follow for sections where you need to search
echo "Choose a section for search"
for (( i=0; i<${#sections[@]}; i++ )); do
    echo "$((i+1))) ${sections[i]}"
done
read SECTION_NUM

if [[ $SECTION_NUM -eq 9 ]]; then
    echo "Insert the multi sections (Pending implement)"  #**PENDING***
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
    SECTION_RTRN="${sections[SECTION_NUM_RETRN-1]}"
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

#Print options selected
echo "Patron $PATRON | section for search $SECTION | section for return $SECTION_RTRN"

#Search
cat archivo.csv | while IFS="," read -r TITLE SUMMARY KEYWORDS MAIN_OBJETIVE METHOD RESULTS CONCLUSIONS RELEVANCE; do
ALLTEXT="$TITLE $SUMMARY $KEYWORDS $MAIN_OBJETIVE $METHOD $RESULTS $CONCLUSIONS $RELEVANCE"
    case $SECTION in
        ${sections[0]}) #Could be implement the place where program match the Info with grep  **PENDING***   ALSO CAN REPLACE IF WITH A GREP 
            if [[ $TITLE =~ $PATRON ]]; then
                PRINTSECTION_FUNCT $SECTION_RTRN $TITLE $SUMMARY $KEYWORDS $MAIN_OBJETIVE $METHOD $RESULTS $CONCLUSIONS $RELEVANCE $ALLTEXT
            fi
            ;;
        ${sections[1]})
            if [[ $SUMMARY =~ $PATRON ]]; then
                PRINTSECTION_FUNCT $SECTION_RTRN $TITLE $SUMMARY $KEYWORDS $MAIN_OBJETIVE $METHOD $RESULTS $CONCLUSIONS $RELEVANCE $ALLTEXT
            fi
            ;;
        ${sections[2]})
            if [[ $KEYWORDS =~ $PATRON ]]; then
                PRINTSECTION_FUNCT $SECTION_RTRN $TITLE $SUMMARY $KEYWORDS $MAIN_OBJETIVE $METHOD $RESULTS $CONCLUSIONS $RELEVANCE $ALLTEXT
            fi
            ;;
        ${sections[3]})
            if [[ $MAIN_OBJETIVE =~ $PATRON ]]; then
                PRINTSECTION_FUNCT $SECTION_RTRN $TITLE $SUMMARY $KEYWORDS $MAIN_OBJETIVE $METHOD $RESULTS $CONCLUSIONS $RELEVANCE $ALLTEXT
            fi
            ;;
        ${sections[4]})
            if [[ $METHOD =~ $PATRON ]]; then
                PRINTSECTION_FUNCT $SECTION_RTRN $TITLE $SUMMARY $KEYWORDS $MAIN_OBJETIVE $METHOD $RESULTS $CONCLUSIONS $RELEVANCE $ALLTEXT
            fi
            ;;
        ${sections[5]})
            if [[ $RESULTS =~ $PATRON ]]; then
                PRINTSECTION_FUNCT $SECTION_RTRN $TITLE $SUMMARY $KEYWORDS $MAIN_OBJETIVE $METHOD $RESULTS $CONCLUSIONS $RELEVANCE $ALLTEXT
            fi
            ;;
        ${sections[6]})
            if [[ $CONCLUSIONS =~ $PATRON ]]; then
                PRINTSECTION_FUNCT $SECTION_RTRN $TITLE $SUMMARY $KEYWORDS $MAIN_OBJETIVE $METHOD $RESULTS $CONCLUSIONS $RELEVANCE $ALLTEXT
            fi
            ;;
        ${sections[7]})
            if [[ $RELEVANCE =~ $PATRON ]]; then
                PRINTSECTION_FUNCT $SECTION_RTRN $TITLE $SUMMARY $KEYWORDS $MAIN_OBJETIVE $METHOD $RESULTS $CONCLUSIONS $RELEVANCE $ALLTEXT
            fi
            ;;
        ${sections[8]})
            #CUSTOM SEARCH PENDING
            ;;
         ${sections[9]})
            #Search in all the article info (line of csv)
		  if [[ $ALLTEXT =~ $PATRON ]]; then
		  	echo $ALLTEXT | grep --color=always $PATRON
                	 PRINTSECTION_FUNCT $SECTION_RTRN $TITLE $SUMMARY $KEYWORDS $MAIN_OBJETIVE $METHOD $RESULTS $CONCLUSIONS $RELEVANCE $ALLTEX
            fi           
            ;;
        *)
            echo "No section"
            ;;
    esac
done

