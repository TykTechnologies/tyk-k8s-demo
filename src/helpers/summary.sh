summaries=();
SUMMARY_SEPARATOR="******************************************************************************************";

addSummary() {
  logger $DEBUG "addSummary: passed args ${@}";
  summaries+=("$@");
}

printSummaries() {
  for summary in "${summaries[@]}"; do
    logger $INFO "\n$SUMMARY_SEPARATOR\n$summary\n$SUMMARY_SEPARATOR";
  done
}
