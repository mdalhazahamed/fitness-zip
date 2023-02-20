import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../categories/blog_categories.dart';



class BlogPage extends StatefulWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          SizedBox(
            height: 650,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("items")
                  .doc("blog")
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
                  
                  var docs = snapshot.data!.data()!['categories'];
                  //Center(child: CircularProgressIndicator());
                  //print('111111111111111 $docs');

                  return GridView.builder(
                      itemCount: docs.length ?? 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (_, i) {
                        // final data = docs[i].data();
                        return InkWell(
                          onTap: () {
                            Get.to(BlogCategories(docs[i]["category_name"]));
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
                                image: NetworkImage(docs[i]['category_img']),
                              ),
                            ),
                          
                          ),
                        );
                      });
                }

                return Center(
                         );
              },
            ),
          ),
        ],
      ),
    );
  }
}
