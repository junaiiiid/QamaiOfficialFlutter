String _Timestart;
String _Timeend;

void setTimestart(String timestart) {
  _Timestart = timestart;
}

void setTimeend(String timeend) {
  _Timeend = timeend;
}

String getTime() {
  return '$_Timestart to $_Timeend';
}
