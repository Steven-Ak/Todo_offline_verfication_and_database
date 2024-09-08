import 'package:task_5/widgets/extentions.dart';

String? validateName(String? value){
  if (value == null || value.isEmpty){
    return "Name cannot be empty!";
  }
  return null;
}

String? validateEmail(String? value){
  if (value == null || value.isEmpty){
    return "Email cannot be empty!";
  }
  else if (!value.isValidEmail()){
    return "Enter a valid email address!";
  }
  return null;
}

String? validatePass(String? value){
  if (value == null || value.isEmpty){
    return "password cannot be empty!";
  }
  else if (!value.isValidPass()){
    return "Password must be more than 8 characters!";
  }
  return null;
}