import 'package:flutter/material.dart';

class HomeAbout {
  static Container container = Container(
    color: Colors.white,
    width: double.infinity,
    padding: const EdgeInsetsDirectional.all(30),
    child: Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Stack(
          children: <Widget>[
            const Image(
              image: AssetImage('assets/images/TopicTimerEmblemWhite.png'),
              height: 50,
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 12,
                left: 12,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                      bottom: 15,
                    ),
                    width: double.infinity,
                    child: const Text.rich(
                      TextSpan(
                        text: 'About the creators',
                      ),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    child: Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'Meet the Team Behind TopicTimer At TopicTimer, we\'re driven by a passion for education and a commitment to making a positive impact on the '
                                'way students learn and grow. Our journey began at Fontys University of Applied Sciences, where four students came together to tackle a pressing'
                                'challenge in the realm of education. Allow us to introduce ourselves:\n\n',
                          ),
                          TextSpan(
                            text: 'Michel',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                ': With a keen eye for detail and a knack for innovation, Michel, now '
                                'in his 7th semester, brings his extensive experience in technology to the table. His vision was instrumental in shaping the core concept of TopicTimer.\n\n',
                          ),
                          TextSpan(
                            text: 'Rick',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                ': Rick, currently in his 6th semester, is a creative problem solver with a deep understanding of educational dynamics. His insights have been '
                                'invaluable in crafting a solution that resonates with both students and educators.\n\n',
                          ),
                          TextSpan(
                            text: 'Vid',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                ': Vid, also in his 6th semester, is a forward-thinker and a '
                                'technology enthusiast. His dedication to improving the educational landscape drove the development of TopicTimer\'s user-friendly interface.\n\n',
                          ),
                          TextSpan(
                            text: 'Tycho',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                ': Tycho, like Michel, is in his 7th semester and possesses a remarkable ability to translate ideas into actionable plans. His leadership skills have kept the '
                                'team motivated and on track.\n\n',
                          ),
                          TextSpan(
                            text:
                                'Our journey began in the EdTech minor at Fontys University, where we were challenged to identify an issue of significance in '
                                'education and devise a technological solution. As soon as the idea of TopicTimer was conceived, enthusiasm permeated our team.',
                          ),
                        ],
                      ),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
