String _Timestart;
String _Timeend;

void setSearchTimestart(String timestart) {
  _Timestart = timestart;
}

void setSearchTimeend(String timeend) {
  _Timeend = timeend;
}

String getSearchTime() {
  return '$_Timestart to $_Timeend';
}
