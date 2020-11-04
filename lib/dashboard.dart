import 'package:flutter/material.dart';
import 'package:flutter_app/tasks.dart';

import 'app.dart';

class DashboardPage extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    var app =
        new App('app_title', Dashboard(title: "dashboard_title"), context);

    return app.mtApp;
  }
}

// ignore: must_be_immutable
class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.title}) : super(key: key);
  String title;
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment
              .bottomCenter, // 10% of the width, so there are ten blinds.
          colors: [
            const Color(0xffF500AB),
            const Color(0xff130061)
          ], // red to yellow
          tileMode: TileMode.clamp, // repeats the gradient over the canvas
        )),
        child: Center(
            child: Container(
          margin: EdgeInsets.only(top: AppBar().preferredSize.height * 2),
          child: Column(
            children: [
              Image.asset(
                "images/logo.png",
                width: 120,
                height: 120,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Tasks()),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10, top: 40),
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(80.0))),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Reminder",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(80.0))),
                padding: EdgeInsets.all(10),
                child: Text(
                  "Profile",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(80.0))),
                padding: EdgeInsets.all(10),
                child: Text(
                  "Setting",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
