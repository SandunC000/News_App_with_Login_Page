import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app_2/components/custom_tag.dart';
import 'package:news_app_2/components/image_container.dart';
import 'package:news_app_2/models/article_model.dart';

class ArticlePage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    final article = ModalRoute.of(context)!.settings.arguments as Article;

    return ImageContainer(
        imageUrl: article.imageUrl,
        width: double.infinity,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Center(
                child: Text(
              "Hi ${user.email!}",
              style:
                  const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
            )),
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            ),
            actions: [
              IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))
            ],
          ),
          extendBodyBehindAppBar: true,
          body: ListView(
            children: [
              Column(
                children: [
                  _NewsHeadline(article: article),
                  _NewsBody(article: article),
                ],
              )
            ],
          ),
        ));
  }
}

class _NewsBody extends StatelessWidget {
  final Article article;
  const _NewsBody({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white),
      child: Column(
        children: [
          Row(
            children: [
              CustomTag(backgroundColor: Colors.black, children: [
                CircleAvatar(
                  radius: 10,
                  backgroundImage: NetworkImage(article.authorImageUrl),
                ),
                const SizedBox(width: 10),
                Text(
                  article.author,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                )
              ]),
              const SizedBox(width: 10),
              CustomTag(backgroundColor: Colors.grey.shade200, children: [
                const Icon(
                  Icons.timer,
                  color: Colors.grey,
                ),
                const SizedBox(width: 5),
                Text(
                    '${DateTime.now().difference(article.createdAt).inHours} hours ago',
                    style: Theme.of(context).textTheme.bodyMedium)
              ]),
              const SizedBox(width: 10),
              CustomTag(backgroundColor: Colors.grey.shade200, children: [
                const Icon(
                  Icons.remove_red_eye,
                  color: Colors.grey,
                ),
                const SizedBox(width: 5),
                Text(
                  '${article.views}',
                  style: const TextStyle(fontSize: 12),
                )
              ])
            ],
          ),
          const SizedBox(height: 20),
          Text(
            article.body,
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.5),
          ),
          const SizedBox(height: 20),
          GridView.builder(
              shrinkWrap: true,
              itemCount: 2,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1.25),
              itemBuilder: (context, index) {
                return ImageContainer(
                    imageUrl: article.imageUrl,
                    margin: const EdgeInsets.only(right: 5, bottom: 5),
                    width: MediaQuery.of(context).size.width * 0.42);
              })
        ],
      ),
    );
  }
}

class _NewsHeadline extends StatelessWidget {
  final Article article;
  const _NewsHeadline({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          CustomTag(backgroundColor: Colors.grey.withAlpha(150), children: [
            Text(article.category),
          ]),
          const SizedBox(height: 10),
          Text(
            article.title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold, color: Colors.white, height: 1.25),
          ),
          const SizedBox(height: 10),
          Text(
            article.subtitle,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold, color: Colors.white, height: 1.25),
          ),
        ],
      ),
    );
  }
}
