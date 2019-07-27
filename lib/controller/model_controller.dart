import 'package:flutter/material.dart';
import 'package:flutter_led_app/ledapi/ledapi.dart';
import 'package:flutter_led_app/models/button_gen.dart';
import 'package:flutter_led_app/models/group_controller.dart';
import 'package:flutter_led_app/models/stripe_controller.dart';
import 'package:flutter_led_app/pin/stripe.dart';
import 'package:synchronized/synchronized.dart';

class ModelController {
  // children
  //final Client client = new Client("192.168.0.11", 5000);

  List<Widget> content = [];

  List<GroupController> groups = [
    GroupController([PinGroup.W, PinGroup.R, PinGroup.G, PinGroup.B]),
  ];

  List<Stripe> stripes = [];

  List<StripeController> stripeController = [];

  final lock = new Lock();
  bool updateMemebersInProgress = false;

  Future<void> updateMembers() {
    print("updateMembers");
    print(stripeController);

    if (updateMemebersInProgress)
      return null;
    updateMemebersInProgress = true;

    return lock.synchronized(() {
      return ConnectionPool.inst.get().then((con) {
        return getStripes(con).then((res) {

          // update local stripes
          stripes = [];
          print("rsv");
          print(res.getData());
          res.getData().forEach((stripe) {
            stripes.add(Stripe.fromJson(stripe));
          });

          // check if each stripes exists an controller
          List<int> found = [];
          for (var controller in stripeController) {
            if (controller == null) continue;
            print("controller");
            print(controller);
            print("from");
            print(stripeController);

            bool exists = false;
            for (int i = 0; i < stripes.length; i++) {
              exists = controller.updateStripe(stripes[i]);
              if (exists) {
                found.add(i);
                return;
              }
            }
            if (!exists) {
              stripeController.remove(controller);
            }
          }

          // add new controller for non existing stripe controller
          if (found.length != stripes.length) {
            for (int i = 0; i < stripes.length; i++) {
              if (!found.contains(i)) {
                print("add controller");
                stripeController.add(StripeController(stripe: stripes[i]));
              }
            }

            // update content
            updateContent();
          }
        }, onError: (e) {}
        ).whenComplete(() {
          con.free();
        });
      }, onError: (e) {});
    }).whenComplete(() {
      updateMemebersInProgress = false;

      print("updated");
      print(stripes);
      print(stripeController);
    });
  }

  void updateAllMembers() {
    stripeController.forEach((stripe) {
      stripe.updateAllMembers();
    });
  }

  void updateUI() {
    stripeController.forEach((stripe) {
      stripe.updateUI();
    });
  }

  List<Widget> getAllMembers() {
    return content;
  }

  void unifyPinGroupState(int pinGroup) {
    // get group members states
    List<bool> states = [];
    stripeController.forEach((stripe) {
      states.addAll(stripe.getGroupMembersStates(pinGroup));
    });

    // no group members
    if (states.length == 0) return;

    // compute resulting state
    bool resultingState;
    bool state = states[0];
    states.forEach((groupState) {
      if (state != groupState) {
        resultingState = false;
        return;
      }
    });

    if (resultingState == null) resultingState = !state;

    // set unified state
    stripeController.forEach((stripe) {
      stripe.setGroupMembersStates(pinGroup, resultingState);
    });
  }

  void updateContent() {
    content = [];
    for (int i = 0; i < groups.length; i++) {
      if (groups[i] != null)
        content.add(groups[i]);
    }
    for (int i = 0; i < stripeController.length; i++) {
      if (stripeController[i] != null)
        content.add(stripeController[i]);
    }
    print(content);
  }
}
