import 'dart:async';
import 'dart:io';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'package:flutter_led_app/network/packet/request.dart';
import 'package:flutter_led_app/network/packet/response.dart';
import 'package:flutter_led_app/network/util/rc4.dart';


class Connection {

  // settings
  static const _TIMEOUT = Duration(seconds: 2);
  static const _BUFFER_SIZE = 1024 * 8;

  // state
  final String host, passphrase;
  final int port;
  var resource;
  List<int> _dataBuffer;
  List<Response> _responses;
  Socket _socket;
  RC4 _cipher;
  bool _disposed = false;
  int index;

  Connection(this.host, this.port, this.passphrase,
      {this.resource, bool refreshSession=false}) {

    // initialize
    _dataBuffer = List<int>();
    _responses = List<Response>();
    if (passphrase.length > 0)
      _cipher = RC4(utf8.encode(passphrase));

    // connect
    Socket.connect(host, port, timeout: _TIMEOUT).then((socket) async {

      // remember socket
      this._socket = socket;

      // listen to data
      socket.listen((data) {
        print(data);

        // cipher
        if (_cipher != null)
          _cipher.crypt(data);

        // add data to buffer
        _dataBuffer.addAll(data);

        // check buffer size
        if (_dataBuffer.length > _BUFFER_SIZE) {
          socket.destroy();
          return;
        }

        // check for completed message
        for (int i = 0; i < _dataBuffer.length; i++) {
          if (_dataBuffer[i] == 0) {

            // get message data and remove from buffer
            var msgData = List<int>.from(_dataBuffer.getRange(0, i));
            _dataBuffer.removeRange(0, i + 1);

            // check data length
            if (msgData.length > 0) {

              // convert to JSON
              var msgStr = utf8.decode(msgData, allowMalformed: false);

              // build response
              var res = Response.fromJson(msgStr);
              this._responses.add(res);
            }
          }
        }

      }, onError: (e) {

        // dispose on listen error
        this.dispose();

      }, onDone: () {

        // dispose on listen done
        this.dispose();

      });

    }, onError: (e) {

      // dispose on connection error
      this.dispose();
    });
  }

  void changePass(String pass) {
    if (pass.length > 0)
      _cipher = RC4(utf8.encode(pass));
    else
      _cipher = null;
  }

  void dispose() {
    if (_socket != null)
      _socket.destroy();
    this._disposed = true;
    this.free();
  }

  bool isDisposed() {
    return this._disposed;
  }

  void free() {

    // release optional resource
    if (this.resource != null) {
      this.resource.release();
      this.resource = null;
    }
  }

  bool isFree() {
    return this.resource == null;
  }

  bool isValid() {
    return this._socket != null && !this._disposed;
  }

  Response request(Request req) {

    print("send request");

    // write request
    _writeRequest(req);

    print("wrote request");
    // add response listener
    return _awaitResponse(req.id);

  }

  void _writeRequest(Request req) async {

    // convert to JSON
    var json = req.toJson() + "\x00";
    var jsonEncoded = utf8.encode(json);

    // cipher
    if (_cipher != null)
      _cipher.crypt(jsonEncoded);

    print("write request");
    print(jsonEncoded);

    // write to socket
    this._socket.add(jsonEncoded);
  }

  Response _awaitResponse(int id) {
    bool timeout = false;
    Timer(_TIMEOUT, () => timeout = true);
    while (_responses.length == 0 && !timeout) {
      print("wait");
    }
    Response response;
    if (_responses.length >= 1) {
      response = _responses[0];
      _responses = [];
    }
    print("response");
    print(response);
    return response;
  }
}
