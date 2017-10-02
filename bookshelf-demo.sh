#!/usr/bin/env bash

########################
# include the magic
########################
. ./demo-magic.sh -d


########################
# Configure the options
########################

#
# speed at which to simulate typing. bigger num = faster
#
# TYPE_SPEED=2000

#
# custom prompt
#
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
#
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W$ "

# hide the evidence
clear

# Run the gcloud init if you haven't done so
p "#Run gcloud init and call your configuration mercadona-workshop"

# Activate the already prepared configuration
pe "gcloud config configurations activate mercadona-workshop"

# Show that we're in the right region (should be Europe West1-d)
pe "gcloud config list compute/zone"

# Create a GKE cluster for the bookshelf application
pe "gcloud container clusters create bookshelf --scopes "cloud-platform" --num-nodes 2"

# Get the credentials for the cluster
pe "gcloud container clusters get-credentials bookshelf"

# get the project id in a shellscript var
pe "PROJECT_ID=$(gcloud config list --format 'value(core.project)' 2>/dev/null)"

# Create a Cloud Storage bucket to store image files
pe "gsutil mb gs://$PROJECT_ID"

# Change bucket URLS
pe "gsutil defacl set public-read gs://$PROJECT_ID"

# Update config.py
p "#Modify your config.py and enter your cloud project ID into PROJECT_ID and the right"
p "#cloud storage bucket into CLOUD_STORAGE_BUCKET"

pe "sed -i -e 's/your-project-id/mercadona-workshop/g' config.py"

pe "sed -i -e 's/your-cloud-storage-bucket/mercadona-workshop/g' config.py"

# show a prompt so as not to reveal our true nature after
# the demo has concluded
p ""
