import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app_2/components/image_container.dart';

import '../components/bottom_nav_bar.dart';
import '../models/article_model.dart';

class DiscoverPage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> tabs = ['Health', 'Politics', 'Art', 'Food', 'Science'];

    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(
              child: Text(
            "Hi ${user.email!}",
            style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Colors.black),
          )),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: signUserOut,
              icon: const Icon(Icons.logout),
              color: Colors.black,
            )
          ],
        ),
        bottomNavigationBar: const BottomNavBar(index: 1),
        // extendBodyBehindAppBar: true,

        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const _DiscoverNews(),
            _CategoryNews(tabs: tabs),
          ],
        ),
      ),
    );
  }
}

class _CategoryNews extends StatelessWidget {
  final List<String> tabs;
  const _CategoryNews({super.key, required this.tabs});

  @override
  Widget build(BuildContext context) {
    final articles = Article.articles;
    return Column(children: [
      TabBar(
        isScrollable: true,
        indicatorColor: Colors.black,
        tabs: tabs
            .map((tab) => Tab(
                  icon: Text(
                    tab,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ))
            .toList(),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height,
        child: TabBarView(
          children: tabs
              .map((tab) => ListView.builder(
                    shrinkWrap: true,
                    itemCount: articles.length,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, 'articlePage',
                              arguments: articles[index]);
                        },
                        child: Row(
                          children: [
                            ImageContainer(
                              imageUrl: articles[index].imageUrl,
                              width: 80,
                              height: 80,
                              margin: const EdgeInsets.all(10),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    articles[index].title,
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(Icons.schedule, size: 18),
                                      const SizedBox(width: 10),
                                      Text(
                                          '${DateTime.now().difference(articles[index].createdAt).inHours} hours ago',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                      const SizedBox(width: 20),
                                      const Icon(Icons.visibility, size: 18),
                                      const SizedBox(width: 5),
                                      Text(
                                        '${articles[index].views} views',
                                        style: const TextStyle(fontSize: 12),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ))
              .toList(),
        ),
      )
    ]);
  }
}

class _DiscoverNews extends StatelessWidget {
  const _DiscoverNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Discover',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.black, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 5),
          Text(
            'News from all over the world',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Search',
                fillColor: Colors.grey.shade200,
                filled: true,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                suffixIcon: const RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    Icons.tune,
                    color: Colors.grey,
                  ),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none)),
          )
        ],
      ),
    );
  }
}
