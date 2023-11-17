import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app_2/components/custom_tag.dart';
import 'package:news_app_2/components/image_container.dart';
import 'package:news_app_2/models/article_model.dart';
import 'package:news_app_2/pages/article_page.dart';
import '../components/bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    Article article = Article.articles[0];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
            child: Text(
          "Hi ${user.email!}",
          style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
        )),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))
        ],
      ),
      bottomNavigationBar: const BottomNavBar(index: 0),
      extendBodyBehindAppBar: true,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _NewsOfTheDay(article: article),
          _BreakingNews(articles: Article.articles),
        ],
      ),
    );
  }
}

class _BreakingNews extends StatelessWidget {
  const _BreakingNews({Key? key, required this.articles}) : super(key: key);
  final List<Article> articles;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Breaking News',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'More',
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 250,
            child: ListView.builder(
              itemCount: articles.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  margin: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {Navigator.pushNamed(context, 'articlePage', arguments: articles[index]);} ,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageContainer(
                            imageUrl: articles[index].imageUrl,
                            width: MediaQuery.of(context).size.width * 0.5),
                        const SizedBox(height: 10),
                        Text(
                          articles[index].title,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold, height: 1.5),
                        ),
                        const SizedBox(height: 5),
                        Text(
                            '${DateTime.now().difference(articles[index].createdAt).inHours} hours ago',
                            style: Theme.of(context).textTheme.bodySmall),
                        const SizedBox(height: 5),
                        Text(
                            'by ${articles[index].author}',
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _NewsOfTheDay extends StatelessWidget {
  const _NewsOfTheDay({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return ImageContainer(
      imageUrl: article.imageUrl,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTag(backgroundColor: Colors.grey.withAlpha(150), children: [
            Text(
              'News of the Day',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white),
            )
          ]),
          const SizedBox(height: 10),
          Text(
            article.title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  height: 1.25,
                ),
          ),
          TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Row(
                children: [
                  Text(
                    'Learn More',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          height: 1.25,
                        ),
                  ),
                  // const SizedBox(width: 10),
                  const Icon(
                    Icons.arrow_right_alt,
                    color: Colors.white,
                  )
                ],
              ))
        ],
      ),
    );
  }
}
