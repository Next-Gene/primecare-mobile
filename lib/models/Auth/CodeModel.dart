class CodeModel {
  String? _code;
  String? _email;

  CodeModel({String? code, String? email}) {
    if (code != null) {
      this._code = code;
    }
    if (email != null) {
      this._email = email;
    }
  }

  String? get code => _code;
  set code(String? code) => _code = code;
  String? get email => _email;
  set email(String? email) => _email = email;

  CodeModel.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['email'] = this._email;
    return data;
  }
}
