extension Validations on String{
  bool isValidEmail(){
    return (contains("@") && length > 5 && endsWith(".com"));
  }
  bool isValidPass(){
    return (trim().length > 8);
  }
}