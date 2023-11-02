import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/components/changelog/changelog.dart';
import 'package:topictimer_flutter_application/components/website/navbar.dart';
import 'package:topictimer_flutter_application/components/website/news_page/news_item.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});
  
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Map<String, dynamic>> changelog = [];

  @override
  void initState() {
    super.initState();
    loadChangelogData();
  }

  void loadChangelogData() async {
    final parsedChangelog = await ChangeLog.get();

    setState(() {
      changelog = parsedChangelog;
    });
  }

  List<NewsItem> newsItems() {
    List<NewsItem> items = [];
    for (var version in changelog) {
      items.add(
        NewsItem(
          versionInformation: version,
        ),
      );
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(
        activeLink: '/news',
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Column(
                children: newsItems(),
              ),
            ),
          ),
        ),
      ), 
    );
  }
}
