class SignupModel {
  String? _email;
  String? _fname;
  String? _lname;
  String? _password;
  String? _phoneNumber;
  String? _repassword;
  String? _userName;

  SignupModel(
      {String? email,
        String? fname,
        String? lname,
        String? password,
        String? phoneNumber,
        String? repassword,
        String? userName}) {
    if (email != null) {
      this._email = email;
    }
    if (fname != null) {
      this._fname = fname;
    }
    if (lname != null) {
      this._lname = lname;
    }
    if (password != null) {
      this._password = password;
    }
    if (phoneNumber != null) {
      this._phoneNumber = phoneNumber;
    }
    if (repassword != null) {
      this._repassword = repassword;
    }
    if (userName != null) {
      this._userName = userName;
    }
  }

  String? get email => _email;
  set email(String? email) => _email = email;
  String? get fname => _fname;
  set fname(String? fname) => _fname = fname;
  String? get lname => _lname;
  set lname(String? lname) => _lname = lname;
  String? get password => _password;
  set password(String? password) => _password = password;
  String? get phoneNumber => _phoneNumber;
  set phoneNumber(String? phoneNumber) => _phoneNumber = phoneNumber;
  String? get repassword => _repassword;
  set repassword(String? repassword) => _repassword = repassword;
  String? get userName => _userName;
  set userName(String? userName) => _userName = userName;

  SignupModel.fromJson(Map<String, dynamic> json) {
    _email = json['email'];
    _fname = json['fname'];
    _lname = json['lname'];
    _password = json['password'];
    _phoneNumber = json['phoneNumber'];
    _repassword = json['repassword'];
    _userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this._email;
    data['fname'] = this._fname;
    data['lname'] = this._lname;
    data['password'] = this._password;
    data['phoneNumber'] = this._phoneNumber;
    data['repassword'] = this._repassword;
    data['userName'] = this._userName;
    return data;
  }
}
