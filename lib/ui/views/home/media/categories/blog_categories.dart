import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class BlogCategories extends StatefulWidget {
  BlogCategories(this.categories);
  var categories;

  @override
  State<BlogCategories> createState() => _BlogCategoriesState();
}

class _BlogCategoriesState extends State<BlogCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 18),
        ),
        centerTitle: true,
        title: Text(
          "Category",
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          InkWell(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("items")
                  .doc("blog")
                  .collection("all")
                  .where("category", isEqualTo: widget.categories)
                  .snapshots(),
              builder: (_, snapshot) {
                if (snapshot.hasError) return Text('Error = ${snapshot.error}');

                if (snapshot.hasData) {
                  final docs = snapshot.data!.docs;

                  return GridView.builder(
                      itemCount: docs.length ?? 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (_, i) {
                        final data = docs[i].data();
                        return InkWell(
                          onTap: () {
                            // Get.to(BlogDetaials(detailsData: data,
                            //           category: 'blog',
                            //           subCategory: "all-blogs",
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
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 48, left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(data['title'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      )),
                                ],
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
        ],
      ),
    );
  }
}
