class User {
  String email;
  String password;
  String role;

  User(this.email, this.password, this.role);

  bool emailValid(email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
  }

  // Extended 'full' user
  String firstName = "";
  String lastName = "";
  String phoneNumber = "";
  String dob = "";

  // For debugging
  void printUser() {
    print("User Details: ");
    print("Name: " + firstName + lastName);
    print("Email: " + email);
    print("Password: " + password);
    print("Phone Number: " + phoneNumber);
    print("Role: " + role);
    print("Date Of Birth: " + dob);
  }
}
