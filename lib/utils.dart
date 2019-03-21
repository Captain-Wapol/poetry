import 'package:flutter/material.dart';
import 'dart:convert';

class UTILS {
  static String poetryReadList = "poetryReadList";
  static Widget fBuildFuture(
      BuildContext context, AsyncSnapshot snapshot, _createListView) {
    Widget loading = Center(
      child: CircularProgressIndicator(),
    );
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return loading;
      case ConnectionState.active:
        return loading;
      case ConnectionState.waiting:
        return loading;
      case ConnectionState.done:
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        Map<String, dynamic> data = json.decode(snapshot.data.toString());
        return _createListView(context, data);
      default:
        return null;
    }
  }
}
