

RegExp Email_Exp = RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$");

RegExp CNIC_Exp = RegExp(r"^\d{5}[- .]?\d{7}[- .]?\d{1}$");

RegExp MobileNumber_Exp = RegExp(r"^(?:(([+]|00)92)|0)((3[0-6][0-9]))(\d{7})$");

RegExp Password_Exp= RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}$");


RegExp Name_Exp= RegExp(r"[A-Z][a-z]+");

