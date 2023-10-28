import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

void goToRoute(String route) {
  Navigator.of(navigatorKey.currentContext!).pushNamed(
    route,
  );
}

void goBack() {
  Navigator.of(navigatorKey.currentContext!).pop();
}

void goBackTo(String route) {
  Navigator.of(navigatorKey.currentContext!)
      .popUntil(ModalRoute.withName(route));
}

void goToAndRemoveUntil(String route) {
  Navigator.of(navigatorKey.currentContext!)
      .pushNamedAndRemoveUntil(route, (route) => false);
}

void goToAndReplace(String route) {
  Navigator.of(navigatorKey.currentContext!).pushReplacementNamed(
    route,
  );
}

void goToTicketView(String id) {
  Navigator.push(
    navigatorKey.currentContext!,
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => TicketView(
        ticketID: id,
      ),
    ),
  );
}
