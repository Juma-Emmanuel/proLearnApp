class RegistrationModel {
  final String email;
  final String password;
  final String first_name;
  final String last_name;

  const RegistrationModel({
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.password,
  });
}
