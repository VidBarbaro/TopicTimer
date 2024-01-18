import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:topictimer_flutter_application/bll/topic_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/models/topic_model.dart';
import 'package:topictimer_flutter_application/theme/custom_color.dart';
import 'package:topictimer_flutter_application/theme/color_provider.dart';
import 'package:remove_emoji_input_formatter/remove_emoji_input_formatter.dart';

class TopicWidget extends StatefulWidget {
  const TopicWidget({Key? key, required this.topic}) : super(key: key);

  final TopicModel topic;

  @override
  _TopicWidgetState createState() => _TopicWidgetState();
}

class _TopicWidgetState extends State<TopicWidget> {
  bool additionalInfoIsVisible = false;

  @override
  Widget build(BuildContext context) {
    Future updateTopic() {
      TextEditingController topicnameController = TextEditingController();
      Color pickerColor = const Color(0xff029eff);
      final TextEditingController feedbackIntervalController =
          TextEditingController();
      final TextEditingController feedbackIntervalPeriodController =
          TextEditingController();
      String? selectedFeedbackIntervalPeriod;

      topicnameController.text = widget.topic.name;
      pickerColor = widget.topic.color;
      feedbackIntervalController.text = widget.topic.intervalTime.toString();

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
                  decoration: const InputDecoration(
                    hintText: 'Enter the topic name',
                  ),
                  inputFormatters: [
    RemoveEmojiInputFormatter()
  ],
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
                Text(
                  'Feedback interval:',
                  style: TextStyle(
                    color: ColorProvider.get(CustomColor.text),
                    fontSize: 5.w,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: feedbackIntervalController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Enter a duration',
                              contentPadding: EdgeInsets.all(0.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Expanded(
                          child: DropdownMenu<String>(
                            initialSelection:
                                '${widget.topic.intervalPeriod[0].toUpperCase()}${widget.topic.intervalPeriod.substring(1)}',
                            controller: feedbackIntervalPeriodController,
                            onSelected: (String? period) {
                              setState(() {
                                selectedFeedbackIntervalPeriod =
                                    period!.toLowerCase();
                              });
                            },
                            dropdownMenuEntries: const [
                              DropdownMenuEntry(
                                  value: 'Seconds', label: 'Seconds'),
                              DropdownMenuEntry(
                                  value: 'Minutes', label: 'Minutes'),
                              DropdownMenuEntry(value: 'Hours', label: 'Hours')
                            ],
                            inputDecorationTheme: const InputDecorationTheme(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: ColorProvider.get(CustomColor.primary),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (topicnameController.text.isEmpty) {
                  TopicModel returntopic = TopicModel(
                      'No Name',
                      pickerColor,
                      int.tryParse(feedbackIntervalController.text) ?? 0,
                      selectedFeedbackIntervalPeriod ?? 'seconds');
                  returntopic.id = widget.topic.id;
                  context.read<TopicProvider>().updateTopic(returntopic);
                } else {
                  TopicModel returntopic =
                      TopicModel(
                      topicnameController.text,
                      pickerColor,
                      int.tryParse(feedbackIntervalController.text) ?? 0,
                      selectedFeedbackIntervalPeriod ?? 'seconds');
                  returntopic.id = widget.topic.id;
                  context.read<TopicProvider>().updateTopic(returntopic);
                }
                Navigator.of(context).pop();
              },
              child: Text(
                'Save',
                style: TextStyle(
                  color: ColorProvider.get(CustomColor.primary),
                ),
              ),
            ),
          ],
        ),
      );
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
                  "Are you sure you want to delete '" +
                      widget.topic.name +
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
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: ColorProvider.get(CustomColor.primary),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<TopicProvider>().deleteTopic(widget.topic.id);
                Navigator.of(context).pop();
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  color: ColorProvider.get(CustomColor.primary),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Consumer<TopicProvider>(
      builder: (context, topicProvider, child) {
        return Container(
          color: ColorProvider.get(CustomColor.background),
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        additionalInfoIsVisible =
                            !additionalInfoIsVisible; // Toggle visibility
                      });
                    },
                    style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.zero),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: 15.w,
                          color: widget.topic.color,
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              Text(
                                widget.topic.name[0],
                                style: TextStyle(
                                  fontSize: 20,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 3
                                    ..color = ColorProvider.get(
                                        CustomColor.background)!,
                                ),
                              ),
                              Text(
                                widget.topic.name[0],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: ColorProvider.get(CustomColor.text),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 60.w,
                          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: Text(
                            widget.topic.name,
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                            style: TextStyle(
                              fontSize: 20,
                              color: ColorProvider.get(CustomColor.text),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: updateTopic,
                        style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.zero),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: MaterialStatePropertyAll(Size.zero),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Icon(
                            Icons.edit,
                            color: ColorProvider.get(CustomColor.text),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          deleteTopicAP();
                        },
                        style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.zero),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: MaterialStatePropertyAll(Size.zero),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Icon(
                            Icons.delete,
                            color: ColorProvider.get(CustomColor.text),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Visibility(
                visible: additionalInfoIsVisible,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Feedback: ',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: ColorProvider.get(CustomColor.text),
                              ),
                            ),
                            TextSpan(
                              text: widget.topic.intervalTime > 0
                                  ? 'every ${widget.topic.intervalTime} ${widget.topic.intervalTime > 1 ? widget.topic.intervalPeriod : widget.topic.intervalPeriod.substring(0, widget.topic.intervalPeriod.length - 1)}'
                                  : 'never',
                              style: TextStyle(
                                fontSize: 15,
                                color: ColorProvider.get(CustomColor.text),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
