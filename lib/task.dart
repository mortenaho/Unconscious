import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dashboard.dart';
import 'package:flutter_app/main.adapter.g.m8.dart';
import 'package:flutter_app/models/independent/tasks.g.m8.dart';
import 'package:flutter_app/tasks.dart';
import 'app.dart';
import 'drawer.dart';

class Task extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var app = new App('app_title', TaskPage(title: "dashboard_title"), context);

    return app.mtApp;
  }
}

class TaskPage extends StatefulWidget {
  TaskPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final txtController = TextEditingController();
  DatabaseAdapter dbadapter = new DatabaseAdapter();
  DatabaseProvider dbProvider;
  String filePath = "";
  @override
  void initState() {
    super.initState();
    dbProvider = new DatabaseProvider(dbadapter);
  }

  @override
  Widget build(BuildContext context) {
    Future<void> selectFile() async {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      if (result != null) {
        filePath = result.files.first.path;
      } else {
        // User canceled the picker
      }
    }

    return Scaffold(
      drawer: DrawerMe(),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashboardPage()),
          );
        },
        child: Icon(Icons.home),
        backgroundColor: Colors.green,
      ),
      body: Scaffold(
        resizeToAvoidBottomInset: false,
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
            child: Column(children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                    0, AppBar().preferredSize.height, 0, 50),
                width: 80,
                height: 80,
                child: Center(
                  child: Image.asset("images/logo.png"),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: RaisedButton(
                  onPressed: () {
                    selectFile();
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            const Color(0xff13087D),
                            const Color(0xffD50080)
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(80.0))),
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Stack(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.audiotrack)),
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Add Voice",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                margin: EdgeInsets.all(10),
                //color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Container(
                    child: new TextField(
                      controller: txtController,
                      cursorColor: Colors.transparent,
                      onChanged: (String text) {
                        //print(text);
                      },
                      maxLines: 8,
                      decoration: InputDecoration.collapsed(
                        focusColor: Colors.transparent,
                        //labelText: "text",
                        hintText: 'Enter your term',
                        // enabledBorder: InputBorder.none)
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 120,
                height: 50,
                margin: EdgeInsets.only(top: 25),
                child: RaisedButton(
                    color: Color(0xff019DBE),
                    onPressed: () {
                      addTask();
                    },
                    child: Stack(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Save",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ))
                      ],
                    ),

                    // borderSide: new BorderSide(color: Colors.green),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0))),
              ),
            ])),
      ),
    );
  }

  void addTask() {
    dbProvider.saveTasks(TasksProxy.fromMap({
      "description": txtController.text,
      "audio": filePath,
    }));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Tasks()),
    );
  }
}
