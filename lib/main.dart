import 'package:flutter/material.dart';
import 'package:flutter_app/dashboard.dart';

import 'AppLocalizations.dart';
import 'app.dart';

void main() => runApp(new DashboardPage());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    var app =
        new App('app_title', MyHomePage(title: "dashboard_title"), context);

    return app.mtApp;
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    double fontSize = 35;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(locale.translate(widget.title)),
        elevation: 0.0,
        backgroundColor: Colors.blueAccent,
      ),
      body: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Container(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                        color: Colors.green,
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                print("click");
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "setting",
                                    style: TextStyle(fontSize: fontSize),
                                  ),
                                  Icon(
                                    Icons.settings,
                                    color: Colors.grey,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                    Container(
                        color: Colors.green,
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Row(
                          children: [
                            Text(
                              "profile",
                              style: TextStyle(fontSize: fontSize),
                            ),
                            Icon(
                              Icons.person,
                              color: Colors.grey,
                              size: 30,
                            )
                          ],
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
