if [[ -z "$DB_DUMP_ARCHIVE_DAYS_TO_KEEP" ]]; then
    DB_DUMP_ARCHIVE_DAYS_TO_KEEP=31
fi
echo Removing Archives older than $DB_DUMP_ARCHIVE_DAYS_TO_KEEP days
find $DB_DUMP_TARGET -type f -mtime +$DB_DUMP_ARCHIVE_DAYS_TO_KEEP -exec echo "removing {}" \;
find $DB_DUMP_TARGET -type f -mtime +$DB_DUMP_ARCHIVE_DAYS_TO_KEEP -exec rm {} \;