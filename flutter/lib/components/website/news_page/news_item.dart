import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/theme/color_themes.dart';

class NewsItem extends StatelessWidget {
  final Map<String, dynamic> versionInformation;

  const NewsItem({required this.versionInformation, super.key});

  Text formattedVersionInfo() {
    final added = versionInformation['added'] as List<dynamic>;
    final changed = versionInformation['changed'] as List<dynamic>;
    final removed = versionInformation['removed'] as List<dynamic>;
    final fixed = versionInformation['fixed'] as List<dynamic>;

    final List<TextSpan> textSpans = [];

    if (added.isNotEmpty) {
      textSpans.add(const TextSpan(
        text: '\nAdded:\n',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ));
      for (final item in added) {
        textSpans.add(
          TextSpan(text: '- ${item.toString().replaceAll(': ', ':\n')}\n\n'),
        );
      }
    }

    if (changed.isNotEmpty) {
      textSpans.add(const TextSpan(
        text: '\nChanged:\n',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ));
      for (final item in changed) {
        textSpans.add(
          TextSpan(text: '- ${item.toString().replaceAll(': ', ':\n')}\n\n'),
        );
      }
    }

    if (removed.isNotEmpty) {
      textSpans.add(const TextSpan(
        text: '\nRemoved:\n',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ));
      for (final item in removed) {
        textSpans.add(
          TextSpan(text: '- ${item.toString().replaceAll(': ', ':\n')}\n\n'),
        );
      }
    }

    if (fixed.isNotEmpty) {
      textSpans.add(const TextSpan(
        text: '\nFixed:\n',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ));
      for (final item in fixed) {
        textSpans.add(
          TextSpan(text: '- ${item.toString().replaceAll(': ', ':\n')}\n\n'),
        );
      }
    }

    return Text.rich(
      TextSpan(
        children: textSpans,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 190, 190, 190).withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0.8, 0.8), // changes position of shadow
          ),
        ],
      ),
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        children: [
          Container(
            constraints: const BoxConstraints(
              minHeight: 50,
              maxHeight: 300,
            ),
            width: 150,
            child: const RotationTransition(
              turns: AlwaysStoppedAnimation(-45 / 360),
              child: Image(
                image: AssetImage('assets/images/TopicTimerFullLogo.png'),
                height: 50,
              ),
            ),
          ),
          Container(
            constraints: const BoxConstraints(
              minHeight: 50,
              maxHeight: 300,
            ),
            width: 850,
            child: Scrollbar(
              controller: scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Version ${versionInformation['version']}',
                            ),
                          ],
                          style: TextStyle(
                            color: ColorThemes.get()?['text'],
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: formattedVersionInfo(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
