import 'dart:convert';
import 'dart:math';

class Request {

  static int _lastID = 0;

  // contents
  int id;
  String _module;
  String _function;
  //List _params;

  Request(String module, String function, {id}) {

    // automatic ID iteration
    if (id == null) {
      if (++_lastID >= pow(2, 32))
        _lastID = 1;
      id = _lastID;
    } else
      _lastID = id;

    // build contents
    this.id = id;
    this._module = module;
    this._function = function;
    //this._params = List();
  }

  String toJson() {
    return jsonEncode(
      {
        "id": this.id,
        "module": this._module,
        "function": this._function,
        //"params": this._params,
      }
    );
  }



/*
  void addParam(param) {
    this._params.add(param);
  }
*/
}
