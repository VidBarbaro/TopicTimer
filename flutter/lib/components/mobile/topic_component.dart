import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:topictimer_flutter_application/bll/topic_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/models/topic_model.dart';
import 'package:topictimer_flutter_application/theme/custom_color.dart';
import 'package:topictimer_flutter_application/theme/color_provider.dart';

class TopicWidget extends StatelessWidget {
  const TopicWidget({super.key, required this.topic});

  final TopicModel topic;

  @override
  Widget build(BuildContext context) {
    return Consumer<TopicProvider>(builder: (context, topicProvider, child) {
      bool isVisible = false;
      TextEditingController topicnameController = TextEditingController();
      Color pickerColor = const Color(0xff029eff);
      Future updateTopic() {
        topicnameController.text = topic.name;
        pickerColor = topic.color;
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                    'Edit Topic',
                    style:
                        TextStyle(color: ColorProvider.get(CustomColor.text)),
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
                        decoration: const InputDecoration(
                            hintText: 'Enter the topic name'),
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
                        onColorChanged: (Color newColor) {
                          pickerColor = newColor;
                        },
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
                            context
                                .read<TopicProvider>()
                                .updateTopic(returntopic);
                          } else {
                            TopicModel returntopic = TopicModel(
                                topicnameController.text, pickerColor);
                            returntopic.id = topic.id;
                            context
                                .read<TopicProvider>()
                                .updateTopic(returntopic);
                          }
                          Navigator.of(context).pop();
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
                    style:
                        TextStyle(color: ColorProvider.get(CustomColor.text)),
                    textAlign: TextAlign.center,
                  ),
                  content: SingleChildScrollView(
                      child: Column(
                    children: [
                      Text(
                        "Are you sure you want to delete '" +
                            topic.name +
                            "' ? ",
                        style: TextStyle(
                          color: ColorProvider.get(CustomColor.text),
                          fontSize: 5.w,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                          padding: const EdgeInsets.only(top: 20),
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
                          context.read<TopicProvider>().deleteTopic(topic.id);
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Delete',
                          style: TextStyle(
                              color: ColorProvider.get(CustomColor.primary)),
                        ))
                  ],
                ));
      }

      return Container(
          color: ColorProvider.get(CustomColor.background),
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Column(children: [
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      isVisible = !isVisible;
                    },
                    style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.zero),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                    child: Row(children: [
                      Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          width: 15.w,
                          color: topic.color,
                          alignment: Alignment.center,
                          child: Text(topic.name[0],
                              style: TextStyle(
                                  fontSize: 20,
                                  color: ColorProvider.get(CustomColor.text)))),
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
                visible: isVisible,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: Text(
                        'Additional Topic information is displayed here',
                        style: TextStyle(
                            fontSize: 15,
                            color: ColorProvider.get(CustomColor.text)))))
          ]));
    });
  }
}
