part of ledapi;

Future<void> controlRefreshSession(Connection con) {
  var rnd = new Random();
  var req = Request("control", "session_refresh", id: rnd.nextInt(pow(2, 32)));
  return con.request(req).then((res) {
    con.changePass(res.getData()[0]);
  });
}

Future<void> updateModule(Connection con, var member) {
  if (member is Pin)
    return updatePin(con, member);
  else
    if (member is Stripe)
      return updateStripe(con, member);
    else
      return null;
}

Future<void> updatePin(Connection con, Pin pin) {
  var rnd = new Random();
  var req = Request("led", "setPin", id: rnd.nextInt(pow(2, 32)));

  print("update pin " + pin.pin_nr.toString() + " - " + pin.id.toString());

  req.addParam(pin.toJson());
  return con.request(req).then((res) {
    return res;
  });
}

Future<void> updateStripe(Connection con, Stripe stripe) {
  var rnd = new Random();
  var req = Request("led", "setStripe", id: rnd.nextInt(pow(2, 32)));
  req.addParam(stripe.toJson());
  return con.request(req).then((res) {
    return res;
  });
}

Future<Response> getStripes(Connection con) {
  var rnd = new Random();
  var req = Request("led", "getStripes", id: rnd.nextInt(pow(2, 32)));
  return con.request(req).then((res) {
    return res;
  });
}
