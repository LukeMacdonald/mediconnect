class User {
  String email;
  String password;
  String role;

  User(this.email, this.password, this.role);

  bool emailValid(email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
  }
}
