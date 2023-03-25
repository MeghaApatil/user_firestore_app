import 'package:email_validator/email_validator.dart';

class ValidateFields{

  static String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'Enter Valid Email';
    } else {
      return '';
    }
  }

 static String validateEmailId(String? val) {
    if(val!.isEmpty){
    return "Email can not be empty";
    }else if(!EmailValidator.validate(val, true)){
      return "Invalid Email Address";
    }else{
        return   "";
    }
  }
  
 static String? validateName(String? val) {
    if (val == null || val.isEmpty) {
                          return 'can\'t be empty';
                        } else {
                          return '';
                        }
    
  }
}