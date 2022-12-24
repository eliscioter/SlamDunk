class Authentication {
  late String _name, _password;
  late bool flag;

  Authentication(String name, String password) {
    _name = name;
    _password = _password;
  }

  checkAuthentication(name, password) {
    if (name == 'admin' && password == 'admin123') {
      _name = name;
      _password = password;
      print('$name $password');
      flag = true;
      return true;
    }
    flag = false;
    return false;
  }

  Future<bool> isAuthenticated() async {
    print('$_name, $_password');
    return await checkAuthentication(_name, _password);
  }

  getCredentials() {
    return checkAuthentication(_name, _password) ? _name : null;
  }
}
