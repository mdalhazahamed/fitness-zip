import 'package:fitness/ui/views/home/media/screens/blog_screen.dart';
import 'package:fitness/ui/views/home/media/screens/podcast_screen.dart';
import 'package:fitness/ui/views/home/media/screens/video_screen.dart';
import 'package:flutter/material.dart';

import '../media/categories/blog_categories.dart';
import '../media/categories/podcast_categories.dart';
import '../media/categories/video_categories.dart';

class BottomMedia extends StatelessWidget {
  const BottomMedia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Media",
            style: TextStyle(fontSize: 18),
          ),
          automaticallyImplyLeading: false,
          toolbarHeight: 50,
          elevation: 0,
          bottom: TabBar(
            //labelColor: Colors.amber,
            unselectedLabelColor: Colors.grey,
            indicatorWeight: 2.5,
            indicatorColor: Colors.amber,
            labelStyle: TextStyle(fontSize: 14),
            tabs: [
              Tab(
                text: "Videos",
              ),
              Tab(
                text: "Pocdasts",
              ),
              Tab(
                text: "Blog",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              child: VideoPage(),
            ),
            Container(
              child: PodcastPage(),
            ),
            Container(
              child: BlogPage(),
            ),
          ],
        ),
      ),
    );
  }
}
