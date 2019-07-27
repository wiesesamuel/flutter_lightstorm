part of ledapi;

Future<void> controlRefreshSession(Connection con) {
  var rnd = new Random();
  var req = Request("control", "session_refresh", id: rnd.nextInt(pow(2, 32)));
  return con.request(req).then((res) {
    con.changePass(res.getData()[0]);
  });
}

Future<Response> getStripes(Connection con) {
  var rnd = new Random();
  var req = Request("led", "getStripes", id: rnd.nextInt(pow(2, 32)));
  return con.request(req).then((res) {
    return res;
  });
}
