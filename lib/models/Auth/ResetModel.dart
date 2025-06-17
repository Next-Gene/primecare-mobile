class ResetModel {
  String? _confirmPassword;
  String? _email;
  String? _password;

  ResetModel({String? confirmPassword, String? email, String? password}) {
    if (confirmPassword != null) {
      this._confirmPassword = confirmPassword;
    }
    if (email != null) {
      this._email = email;
    }
    if (password != null) {
      this._password = password;
    }
  }

  String? get confirmPassword => _confirmPassword;
  set confirmPassword(String? confirmPassword) =>
      _confirmPassword = confirmPassword;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get password => _password;
  set password(String? password) => _password = password;

  ResetModel.fromJson(Map<String, dynamic> json) {
    _confirmPassword = json['confirmPassword'];
    _email = json['email'];
    _password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confirmPassword'] = this._confirmPassword;
    data['email'] = this._email;
    data['password'] = this._password;
    return data;
  }
}
