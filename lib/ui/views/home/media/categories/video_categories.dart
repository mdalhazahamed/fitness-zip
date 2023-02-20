import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class VideoCategories extends StatefulWidget {
  VideoCategories(this.categories);
  var categories;

  @override
  State<VideoCategories> createState() => _VideoCategoriesState();
}

class _VideoCategoriesState extends State<VideoCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {Navigator.pop(context);},
          icon: Icon(Icons.arrow_back_ios, size: 18),
        ),
        title: Text(
          "Category",
         
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            SizedBox(
              height: 650,
              child: InkWell(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("items")
                      .doc("video")
                      .collection("all")
                      .where("category", isEqualTo: widget.categories)
                      .snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasError)
                      return Text('Error = ${snapshot.error}');

                    if (snapshot.hasData) {
                      final docs = snapshot.data!.docs;

                      return GridView.builder(
                          itemCount: docs.length ?? 0,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                          ),
                          itemBuilder: (_, i) {
                            final data = docs[i].data();
                            return InkWell(
                              onTap: () {
                                // Get.to(VideoDetailsPage(detailsData: data,
                                //           category: 'video',
                                //           subCategory: "all-video",
                                //           documentId: docs[i].id,));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                margin: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage((data["thumbnail"])),
                                  ),
                                ),
                                
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
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
