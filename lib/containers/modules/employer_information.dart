String _Name;
String _Title;
String _Email;
String _Description;
String _Category;

void setName(String name) {
  _Name = name;
}

void setTitle(String title) {
  _Title = title;
}

void setEmail(String email) {
  _Email = email;
}

void setDescription(String description) {
  _Description = description;
}

void setCategory(String category) {
  _Category = category;
}

String getName() {
  return _Name;
}

String getTitle() {
  return _Title;
}

String getEmail() {
  return _Email;
}

String getDescription() {
  return _Description;
}

String getCategory() {
  return _Category;
}

void ClearAllInfo() {
  setDescription(null);
  setEmail(null);
  setTitle(null);
  setName(null);
  setCategory(null);
}
