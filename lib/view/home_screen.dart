import 'package:flutter/material.dart';
import 'package:hive_exam_project/controller/home_controller.dart';
import 'package:hive_exam_project/model/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController designation = TextEditingController();
  List<UserModel> data = [];
  final controller = HomeController();

  loadData() async {
    final getData = await controller.getdata();
    setState(() {
      data = getData;
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: data.isEmpty
          ? Center(
              child: Text('NO DATA'),
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index].name.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.black),
                              ),
                              Text(
                                data[index].age.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                              Text(
                                data[index].designation.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    name.text = data[index].name.toString();
                                    age.text = data[index].age.toString();
                                    designation.text =
                                        data[index].designation.toString();
                                    addeditdata(context,
                                        isEdit: true, index: index);
                                  },
                                  icon: Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    controller.deletedata(index: index);
                                    loadData();
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.delete))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemCount: data.length,
              )
              //  ListView.builder(
              //     itemCount: data.length,
              //     itemBuilder: (context, index) {
              //       return ListTile(
              //         title: Text(
              //           data[index].name.toString(),
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               fontSize: 24,
              //               color: Colors.black),
              //         ),
              //         subtitle: Text(
              //           data[index].age.toString(),
              //         ),
              //         trailing: Row(
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             IconButton(
              //                 onPressed: () {
              //                   name.text = data[index].name.toString();
              //                   age.text = data[index].age.toString();
              //                   addeditdata(context,
              //                       isEdit: true, index: index);
              //                 },
              //                 icon: Icon(Icons.edit)),
              //             IconButton(
              //                 onPressed: () {
              //                   controller.deletedata(index: index);
              //                   loadData();
              //                   setState(() {});
              //                 },
              //                 icon: Icon(Icons.delete))
              //           ],
              //         ),
              //       );
              //     }),
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          name.clear();
          age.clear();
          designation.clear();
          addeditdata(context);
        },
        // backgroundColor: Colors.red,
        child: Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> addeditdata(BuildContext context,
      {bool isEdit = false, int index = 0}) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                      hintText: 'Name', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: age,
                  decoration: InputDecoration(
                      hintText: 'Age', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: designation,
                  decoration: InputDecoration(
                      hintText: 'Designation', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (isEdit) {
                        controller.editdata(
                            index: index,
                            data: UserModel(
                                name: name.text,
                                age: age.text,
                                designation: designation.text));
                      } else {
                        controller.adddata(UserModel(
                            name: name.text,
                            age: age.text,
                            designation: designation.text));
                      }

                      loadData();
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: Text('SAVE'))
              ]),
            ),
          );
        });
  }
}
