import 'package:qamai_official/modules/strings/other_strings.dart';
import 'package:qamai_official/screens/starting_screens/signup_screen.dart';
import 'package:qamai_official/screens/starting_screens/signup_screen2.dart';

String _FirstName;
String _LastName;
String _DOB;
String _CNIC;
String _Email;
String _PhoneNumber;
String _Password;
String _RecoveryMail;
String story=storytext;
String imageURL;
String _gender;


void setGender(String gender){
  _gender=gender;
}

void setimageURL(String url){
  imageURL=url;
}

void setRecoveryMail(String mail) {
  _RecoveryMail = mail;
}

void setFirstName(String Fname) {
  _FirstName = Fname;
}

void setLastName(String Lname) {
  _LastName = Lname;
}

void setDOB(String dob) {
  _DOB = dob;
}

void setCNIC(String CNIC) {
  _CNIC = CNIC;
}

void setEmail(String Email) {
  _Email = Email;
}

void setPhone(String Phone) {
  _PhoneNumber = Phone;
}

void setPass(String Pass) {
  _Password = Pass;
}

String getimageURL(){
  return imageURL;
}

String getPass() {
  return _Password;
}

String getFirstName() {
  return _FirstName;
}

String getLastName() {
  return _LastName;
}

String getDOB() {
  return _DOB;
}

String getCNIC() {
  return _CNIC;
}

String getEmail() {
  return _Email;
}

String getPhone() {
  return _PhoneNumber;
}

String getRecoveryMail() {
  return _RecoveryMail;
}

String getStory() {
  return story;
}

String getGender(){
  return _gender;
}

void setStory(String Story) {
  story = Story;
}


void ClearAllInfo()
{
  setPass(null);
  setEmail(null);
  setCNIC(null);
  DateOfBirth=DOB;
  setFirstName(null);
  setLastName(null);
  setPhone(null);
  PasswordMatcher=null;
  setRecoveryMail(null);
}
