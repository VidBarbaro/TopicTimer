import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:sizer/sizer.dart';
import 'package:topictimer_flutter_application/bll/topic_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/models/topic_model.dart';
import 'package:topictimer_flutter_application/theme/custom_color.dart';
import 'package:topictimer_flutter_application/theme/color_provider.dart';

class TopicWidget extends StatefulWidget {
  TopicWidget({super.key, required this.topic, required this.callback});
  TopicModel topic;
  Function() callback;
  @override
  State<TopicWidget> createState() =>
      _TopicWidgetState(topic: topic, callback: callback);
}

class _TopicWidgetState extends State<TopicWidget> {
  _TopicWidgetState({required this.topic, required this.callback});
  TopicModel topic;
  Function() callback;
  bool _isVisible = false;
  final TextEditingController topicnameController = TextEditingController();
  Color pickerColor = Color(0xff029eff);
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  Future updateTopic() {
    topicnameController.text = topic.name;
    pickerColor = topic.color;
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                'Edit Topic',
                style: TextStyle(color: ColorProvider.get(CustomColor.text)),
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                  child: Column(
                children: [
                  Text(
                    'The topic name',
                    style: TextStyle(
                      color: ColorProvider.get(CustomColor.text),
                      fontSize: 5.w,
                    ),
                  ),
                  TextField(
                    controller: topicnameController,
                    textAlign: TextAlign.center,
                    decoration:
                        InputDecoration(hintText: 'Enter the topic name'),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(7, 10, 7, 7),
                    child: Text(
                      'The topic color',
                      style: TextStyle(
                        color: ColorProvider.get(CustomColor.text),
                        fontSize: 5.w,
                      ),
                    ),
                  ),
                  ColorPicker(
                    pickerColor: pickerColor,
                    onColorChanged: changeColor,
                    colorPickerWidth: 200,
                    paletteType: PaletteType.hueWheel,
                    enableAlpha: false,
                    labelTypes: [],
                  ),
                ],
              )),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: ColorProvider.get(CustomColor.primary)),
                    )),
                TextButton(
                    onPressed: () {
                      if (topicnameController.text.isEmpty) {
                        TopicModel returntopic =
                            TopicModel('No Name', pickerColor);
                        returntopic.id = topic.id;
                        TopicProvider.updateTopic(returntopic);
                      } else {
                        TopicModel returntopic =
                            TopicModel(topicnameController.text, pickerColor);
                        returntopic.id = topic.id;
                        TopicProvider.updateTopic(returntopic);
                      }
                      Navigator.of(context).pop();
                      callback();
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                          color: ColorProvider.get(CustomColor.primary)),
                    ))
              ],
            ));
  }

  Future deleteTopicAP() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                'Delete Topic',
                style: TextStyle(color: ColorProvider.get(CustomColor.text)),
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                  child: Column(
                children: [
                  Text(
                    "Are you sure you want to delete '" + topic.name + "' ? ",
                    style: TextStyle(
                      color: ColorProvider.get(CustomColor.text),
                      fontSize: 5.w,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'This action is irreversible!',
                        style: TextStyle(
                            color: ColorProvider.get(CustomColor.secondary),
                            fontSize: 5.5.w,
                            decoration: TextDecoration.underline),
                        textAlign: TextAlign.center,
                      )),
                ],
              )),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: ColorProvider.get(CustomColor.primary)),
                    )),
                TextButton(
                    onPressed: () {
                      setState(() {
                        TopicProvider.deleteTopic(topic.id);
                      });
                      Navigator.of(context).pop();
                      callback();
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(
                          color: ColorProvider.get(CustomColor.primary)),
                    ))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ColorProvider.get(CustomColor.background),
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Column(children: [
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      _isVisible = !_isVisible;
                    });
                  },
                  style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.zero),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  child: Row(children: [
                    Container(
                        padding: const EdgeInsets.all(10),
                        width: 15.w,
                        color: topic.color,
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Text(
                              topic.name[0],
                              style: TextStyle(
                                fontSize: 20,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 3
                                  ..color = ColorProvider.get(CustomColor.background)!,
                              ),
                            ),
                            Text(
                              topic.name[0],
                              style: TextStyle(
                                fontSize: 20,
                                color: ColorProvider.get(CustomColor.text),
                              ),
                            ),
                          ],
                        )
                        // Container(
                        //   color: ColorProvider.get(CustomColor.background),
                        //   padding: const EdgeInsets.fromLTRB(2, 1, 2, 1),
                        // child: Text(topic.name[0],
                        //     style: TextStyle(
                        //         fontSize: 20,
                        //         color: ColorProvider.get(CustomColor.text))))
                        ),
                    Container(
                        width: 60.w,
                        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: Text(topic.name,
                            style: TextStyle(
                                fontSize: 20,
                                color: ColorProvider.get(CustomColor.text))))
                  ])),
              Row(
                children: [
                  TextButton(
                      onPressed: updateTopic,
                      style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.zero),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: MaterialStatePropertyAll(Size.zero)),
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Icon(Icons.edit,
                              color: ColorProvider.get(CustomColor.text)))),
                  TextButton(
                      onPressed: () {
                        deleteTopicAP();
                      },
                      style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.zero),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: MaterialStatePropertyAll(Size.zero)),
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Icon(Icons.delete,
                              color: ColorProvider.get(CustomColor.text))))
                ],
              )
            ],
          ),
          Visibility(
              visible: _isVisible,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: Text('Additional Topic information is displayed here',
                      style: TextStyle(
                          fontSize: 15,
                          color: ColorProvider.get(CustomColor.text)))))
        ]));
  }
}
