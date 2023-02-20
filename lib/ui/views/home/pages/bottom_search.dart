import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';


class BottomSearch extends StatefulWidget {
  const BottomSearch({Key? key}) : super(key: key);

  @override
  State<BottomSearch> createState() => _BottomSearchState();
}

class _BottomSearchState extends State<BottomSearch> {
  RxString userInput = "".obs;
  RxString category = 'video'.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20, left: 16, right: 16),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'write something here',
                ),
                onChanged: (value) {
                  userInput.value = value;
                  print(userInput.value);
                },
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: ToggleSwitch(
                  activeBgColor: [Colors.purple],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey[300],
                  inactiveFgColor: Colors.grey[900],
                  initialLabelIndex: 0,
                  totalSwitches: 3,
                  labels: ['Video', 'Blog', 'Podcast'],
                  onToggle: (index) {
                    index == 0
                        ? category.value = 'video'
                        : index == 1
                            ? category.value = 'blog'
                            : category.value = 'podcast';
                  },
                ),
              ),
              Expanded(
                  child: Obx(
                () => StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("items")
                        .doc(category.value)
                        .collection(category.value == 'video'
                            ? 'all'
                            : category.value == 'podcast'
                                ? 'all'
                                : 'all')
                        .where(
                            category.value == 'video'
                                ? 'video_title'
                                : category.value == 'podcast'
                                    ? 'podcast_title'
                                    : 'title',
                            isGreaterThanOrEqualTo: userInput.value)
                        .snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.hasError)
                        //return Text('Error = ${snapshot.error}');

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
                            itemCount: docs.length ?? 0,
                            itemBuilder: (_, i) {
                              final data = docs[i].data();
                              return InkWell(
                                onTap: () {
                                  // if (data['type'] == 'video') {
                                  //   print('clicked');
                                  //   Get.to(VideoDetailsPage(
                                  //     detailsData: data,
                                  //     category: 'video',
                                  //     subCategory: "all-video",
                                  //     documentId: data[i].id,
                                  //   ));
                                  // }
                                  // if (data['type'] == 'blog') {
                                  //   print('clicked');
                                  //   Get.to(BlogDetaials(
                                  //     detailsData: data,
                                  //     category: 'blog',
                                  //     subCategory: "all-blogs",
                                  //     documentId: data[i].id,
                                  //   ));
                                  // }

                                  // if (data['type'] == 'podcast') {
                                  //   print('clicked');
                                  //   Get.to(
                                  //     PodcastDetails(
                                  //       detailsData: data,
                                  //       category: 'podcast',
                                  //       subCategory: "all-podcast",
                                  //       documentId: data[i].id,
                                  //     ),
                                  //   );
                                  // }
                                },
                                child: Card(
                                  color: Color(0xFF202835),
                                  elevation: 5,
                                  child: Row(children: [
                                    SizedBox(width: 10),
                                    Container(
                                      height: 60,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                category.value == 'video'
                                                    ? data['thumbnail']
                                                    : category.value ==
                                                            'podcast'
                                                        ? data['thumbnail']
                                                        : data['thumbnail']
                                                            .toString())),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      category.value == 'video'
                                          ? data['video_title']
                                          : category.value == 'podcast'
                                              ? data['podcast_title']
                                              : data['title'].toString(),
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ]),
                                ),
                              );
                            });
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
              )),
            ],
          ),
        ),
      ),
    );
  }
}
