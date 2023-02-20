import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BottomHome extends StatefulWidget {
  BottomHome({super.key});

  @override
  State<BottomHome> createState() => _BottomHomeState();
}

class _BottomHomeState extends State<BottomHome> {
  RxBool darkMode = false.obs;
  final box = GetStorage();
  changeTheme(context) {
    if (darkMode.value == false) {
      print('action triggerd');
      Get.changeThemeMode(ThemeMode.light);
    } else {
      print('action triggerd 2');
      Get.changeThemeMode(ThemeMode.dark);
    }
    // Get.changeTheme(
    //   darkMode.value == false
    //       ? AppTheme().lightTheme(context)
    //       : AppTheme().darkTheme(context),
    // );
    // print(darkMode.value);
    box.write('theme', darkMode.value == false ? 'light' : 'dark');
    // print(box.read('theme'));
  }

  @override
  void initState() {
    var theme = box.read('theme');
    if (theme == null) {
      darkMode.value = false;

      print(theme);
    } else if (theme == 'dark') {
      darkMode.value = true;
      print(theme);
    } else {
      darkMode.value = false;
      print(theme);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Obx(
            () => DayNightSwitcher(
              isDarkModeEnabled: darkMode.value,
              onStateChanged: (isDarkModeEnabled) {
                darkMode.value = isDarkModeEnabled;
                changeTheme(context);
              },
            ),
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {},
            icon: IconTheme(
              data: Theme.of(context).copyWith().iconTheme,
              child: Icon(
                Icons.favorite_outline,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recommanded Videos',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
              ),
              SizedBox(
                height: 230,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('items')
                        .doc('video')
                        .collection("all")
                        .orderBy("time_stamp", descending: true)
                        .snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.hasError)
                        // return Text('Error = ${snapshot.error}');
                        return Center(
                          child: Transform.scale(
                              scale: 0.9,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.purple,
                              )),
                        );

                      if (snapshot.hasData) {
                        final docs = snapshot.data!.docs;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5 ?? 0,
                          itemBuilder: (_, i) {
                            final data = docs[i].data();
                            return homeItem(
                              220,
                              220,
                              data["thumbnail"],
                              data["title"],
                            );
                          },
                        );
                      }

                      return Center(
                        child: Transform.scale(
                            scale: 0.9,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.purple,
                            )),
                      );
                    }),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Newest Podcast',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
              ),
              SizedBox(
                height: 150,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('items')
                        .doc('podcast')
                        .collection("all")
                        .orderBy("time_stamp", descending: true)
                        .snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.hasError)
                        // return Text('Error = ${snapshot.error}');
                        return Center(
                          child: Transform.scale(
                              scale: 0.9,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.purple,
                              )),
                        );

                      if (snapshot.hasData) {
                        final docs = snapshot.data!.docs;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5 ?? 0,
                          itemBuilder: (_, i) {
                            final data = docs[i].data();
                            return homeItem(
                              250,
                              140,
                              data["thumbnail"],
                              data["title"],
                            );
                          },
                        );
                      }

                      return Center(
                        child: Transform.scale(
                            scale: 0.9,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.purple,
                            )),
                      );
                    }),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Newest Blogs',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
              ),
              SizedBox(
                height: 190,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('items')
                        .doc('blog')
                        .collection("all")
                        .orderBy("time_stamp", descending: true)
                        .snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.hasError)
                        // return Text('Error = ${snapshot.error}');
                        return Center(
                          child: Transform.scale(
                              scale: 0.9,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.purple,
                              )),
                        );

                      if (snapshot.hasData) {
                        final docs = snapshot.data!.docs;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5 ?? 0,
                          itemBuilder: (_, i) {
                            final data = docs[i].data();
                            return homeItem(
                              240,
                              180,
                              data["thumbnail"],
                              data["title"],
                            );
                          },
                        );
                      }

                      return Center(
                        child: Transform.scale(
                            scale: 0.9,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.purple,
                            )),
                      );
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
}

homeItem(double width, double height, String image, String title) {
  return Column(
    children: [
      SizedBox(
        height: 10,
      ),
      Container(
        width: width,
        height: height,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(image),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 12, top: 12),
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    ],
  );
}
