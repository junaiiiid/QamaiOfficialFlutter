String _category;
String _Position;
String _Description;
String _Rate;
String _ratecategory;
String _Timestart;
String _Timeend;

void setCategory(String category) {
  _category = category;
}

void setPosition(String Position) {
  _Position = Position;
}

void setDescription(String Description) {
  _Description = Description;
}

void setRate(String rate) {
  _Rate = rate;
}

void setRateCategory(String category) {
  _ratecategory = category;
}

void setTimestart(String timestart) {
  _Timestart = timestart;
}

void setTimeend(String timeend) {
  _Timeend = timeend;
}

String getCategory() {
  return _category;
}

String getPosition() {
  return _Position;
}

String getRate() {
  return '$_Rate PKR / $_ratecategory';
}

String getDescription() {
  return _Description;
}

String getTime() {
  return '$_Timestart to $_Timeend';
}

/*void ClearAllinfo(){
  setCategory(null);
  setPosition(null);
  setDescription(null);
  setRate(null);
  setTimestart(null);
  setTimeend(null);
}*/
