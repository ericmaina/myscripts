#!/bin/sh
# variables for vault name, timestamp, and output file
VAULT="sandbox-02"
NOW=$(date +%s)
IDFILE="archive-ids-${NOW}.json"

# make sure we can write the output file
touch $IDFILE || exit 1

# upload all tar files in forbackup directory, writing
# results to the output file
#
# the archive-description string in the filename prefixed
# with the timestamp. this information may be of great
# help when/if we later retrieve the file.
for F in /home/myproject/forbackup/*.tar; do
  echo "# $F" >> $IDFILE
  aws glacier upload-archive \
    --vault-name "$VAULT" \
    --account-id - \
    --archive-description "${NOW}/$F" \
    --body "$F" >> $IDFILE
done
