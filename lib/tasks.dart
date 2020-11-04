import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/models/independent/tasks.g.m8.dart';
import 'package:flutter_app/task.dart';

import 'app.dart';
import 'drawer.dart';
import 'main.adapter.g.m8.dart';

class Tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var app =
        new App('app_title', TasksPage(title: "dashboard_title"), context);

    return app.mtApp;
  }
}

class TasksPage extends StatefulWidget {
  TasksPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  DatabaseAdapter dbadapter = new DatabaseAdapter();
  DatabaseProvider dbProvider;
  var taskListData;
  AudioPlayer advancedPlayer = AudioPlayer();
  bool isRuning = false;
  @override
  void initState() {
    super.initState();
    dbProvider = new DatabaseProvider(dbadapter);
    setState(() {
      taskListData = dbProvider.getTasksProxiesAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Scaffold(
            drawer: DrawerMe(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Task()),
                );
              },
              child: Icon(Icons.navigation),
              backgroundColor: Colors.green,
            ),
            //  resizeToAvoidBottomInset: false,
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
                  tileMode:
                      TileMode.clamp, // repeats the gradient over the canvas
                )),
                child: Center(
                  child: Container(
                      margin: EdgeInsets.all(20),
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
                        Expanded(
                          child: FutureBuilder<List<TasksProxy>>(
                            future: taskListData,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.all(10),
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) => Container(
                                      margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                      decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: <Color>[
                                              const Color(0xff13087D),
                                              const Color(0xffD50080)
                                            ],
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(80.0))),
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 10, 20, 10),
                                      height: 80,
                                      child: Stack(children: <Widget>[
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              snapshot.data[index].description,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            width: 60,
                                            child: Row(
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      if (!isRuning) {
                                                        isRuning = true;
                                                        advancedPlayer.play(
                                                            snapshot.data[index]
                                                                .audio,
                                                            volume: 0.2);
                                                      } else {
                                                        isRuning = false;
                                                        advancedPlayer.stop();
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons.volume_down,
                                                      size: 30,
                                                    )),
                                                InkWell(
                                                    onTap: () {
                                                      remove(snapshot
                                                          .data[index].id);
                                                    },
                                                    child: Image.asset(
                                                      "images/remove.png",
                                                      height: 30,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        )
                                      ])),
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        )
                      ])),
                ))));
  }

  void remove(int id) {
    dbProvider.deleteTasks(id);
    setState(() {
      taskListData = dbProvider.getTasksProxiesAll();
    });
  }
}
