<<<<<<< HEAD
#!/bin/bash
=======
#!/usr/bin/env bash
>>>>>>> 08a8b248fce60d7bb5595c1e42460e0968f382f1

##############################################
# Usage: bash generate_task_library_items.sh #
##############################################

export PYTHONWARNINGS="ignore:Unverified HTTPS request"
IFS=$(echo -en "\n\b")

<<<<<<< HEAD
if [[ -z "${PC_IP}" ]]; then
   read -p "Enter Prism Central IP: " pc_ip
else
   pc_ip=${PC_IP}
fi
if [[ -z "${PC_USER}" ]]; then
   read -p "Enter Prism Central User: " pc_user
else
   pc_user=${PC_USER}
fi
if [[ -z "${PC_PASSWORD}" ]]; then
   read -s -p "Enter Prism Central Password: " pc_password
   # echo blank line to cleanup terminal
   # using "-s" stops BASH from displaying \n after enter password
   echo ""
else
   pc_password=${PC_PASSWORD}
fi
if [[ -z "${PC_PROJECT}" ]]; then
   read -p "Enter Prism Central Project: " pc_project
else
   pc_project=${PC_PROJECT}
fi

# grab some info about how many scripts will be imported
# not mandatory but just gives the user an idea of how much there is to do
PUBLISHED_SCRIPT_COUNT=`find  ../../library/task-library -type f -print | wc | awk '{print $1}'`
COMMUNITY_SCRIPT_COUNT=`find  ../../task-library -type f \( -name "*.ps1" -o -name "*.sh" -o -name "*.py" \) -print | wc | awk '{print $1}'`

#Seed nutanix calm published scripts
echo "$PUBLISHED_SCRIPT_COUNT published scripts to import."
for items in `find  ../../library/task-library -type f -print` ; do
    python generate_task_library.py --pc $pc_ip --user $pc_user --password $pc_password --project $pc_project --script $items
done

#Seed community published scripts
echo "$COMMUNITY_SCRIPT_COUNT community scripts to import."
for items in `find  ../../task-library -type f \( -name "*.ps1" -o -name "*.sh" -o -name "*.py" \) -print` ; do
    python generate_task_library.py --pc $pc_ip --user $pc_user --password $pc_password --project $pc_project --script $items
=======
# shellcheck disable=SC2153
if [[ -z ${PC_IP} ]]; then
  read -p -r "Enter Prism Central IP: " PC_IP
fi
# shellcheck disable=SC2153
if [[ -z ${PC_USER} ]]; then
  read -p -r "Enter Prism Central User: " PC_USER
fi
# shellcheck disable=SC2153
if [[ -z ${PC_PASSWORD} ]]; then
  read -p -r -s "Enter Prism Central Password: " PC_PASSWORD
  # using "-s" stops BASH from displaying \n after enter password
  echo "" # echo blank line to cleanup terminal
fi
# shellcheck disable=SC2153
if [[ -z ${PC_PROJECT} ]]; then
  read -p -r "Enter Prism Central Project: " PC_PROJECT
fi

echo "Counting resources and seeding to ${PC_IP}..."

for source_directory in ../../library/task-library ../../task-library; do
  count=0 # reset

  case "${source_directory}" in
    '../../library/task-library')
      source_type='Nutanix Calm'
      ;;
    '../../task-library')
      source_type='community'
      ;;
  esac

  SCRIPT_COUNT=$(find "${source_directory}" \
    -type f \( -name "*.escript" \
    -o -name "*.ps1" \
    -o -name "*.py" \
    -o -name "*.sh" \) -print \
    | wc | awk '{print $1}') \
    && echo -e "\nFound ${SCRIPT_COUNT} items in ${source_type:-unknown type}" \
      " directory: ${source_directory}\n" \
    && while IFS= read -r -d '' item; do
      ((count++))
      echo "- ${count} of ${SCRIPT_COUNT} ($((count * 100 / SCRIPT_COUNT))%): $(basename "${item}")"
      python generate_task_library.py --script "${item}" \
        --pc "${PC_IP}" --user "${PC_USER}" --password "${PC_PASSWORD}" --project "${PC_PROJECT}"
    done < <(find "${source_directory}" \
      -type f \( -name "*.escript" \
      -o -name "*.ps1" \
      -o -name "*.py" \
      -o -name "*.sh" \) -print0)
>>>>>>> 08a8b248fce60d7bb5595c1e42460e0968f382f1
done
