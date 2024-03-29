import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:topictimer_flutter_application/bll/topic_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/models/topic_model.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/theme_change_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/bluetooth_info_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/timer_info_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/topbar_content_provider.dart';
import 'package:topictimer_flutter_application/theme/color_provider.dart';
import 'package:topictimer_flutter_application/theme/custom_color.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:remove_emoji_input_formatter/remove_emoji_input_formatter.dart';

class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  TopBarState createState() => TopBarState();
}

class TopBarState extends State<TopBar> {
  final TextEditingController topicnameController = TextEditingController();
  Color pickerColor = const Color(0xff029eff);
  final TextEditingController feedbackIntervalController =
      TextEditingController();
  final TextEditingController feedbackIntervalPeriodController =
      TextEditingController();
  String? selectedFeedbackIntervalPeriod;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TopicProvider>(
      builder: (context, topicProvider, child) {
        return Consumer<ThemeChangeProvider>(
          builder: (context, themeChangeProvider, child) {
            void addTopic() => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      'Create Topic',
                      style:
                          TextStyle(color: ColorProvider.get(CustomColor.text)),
                      textAlign: TextAlign.center,
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            'Name the topic:',
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
                            inputFormatters: [RemoveEmojiInputFormatter()],
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(7, 20, 7, 7),
                            child: Text(
                              'Pick a topic color:',
                              style: TextStyle(
                                color: ColorProvider.get(CustomColor.text),
                                fontSize: 5.w,
                              ),
                            ),
                          ),
                          ColorPicker(
                            pickerColor: pickerColor,
                            onColorChanged: (Color newColor) {
                              setState(() {
                                pickerColor = newColor;
                              });
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      initialSelection: 'Seconds',
                                      controller:
                                          feedbackIntervalPeriodController,
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
                                        DropdownMenuEntry(
                                            value: 'Hours', label: 'Hours')
                                      ],
                                      inputDecorationTheme:
                                          const InputDecorationTheme(
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
                            context.read<TopicProvider>().createTopic(
                                TopicModel(
                                    'No Name',
                                    pickerColor,
                                    int.tryParse(
                                            feedbackIntervalController.text) ??
                                        0,
                                    selectedFeedbackIntervalPeriod ??
                                        'seconds'));
                          } else {
                            context.read<TopicProvider>().createTopic(
                                TopicModel(
                                    topicnameController.text,
                                    pickerColor,
                                    int.tryParse(
                                            feedbackIntervalController.text) ??
                                        0,
                                    selectedFeedbackIntervalPeriod ??
                                        'seconds'));
                          }
                          feedbackIntervalController.text = '';
                          topicnameController.text = '';
                          pickerColor = const Color(0xff029eff);
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Create',
                          style: TextStyle(
                            color: ColorProvider.get(CustomColor.primary),
                          ),
                        ),
                      )
                    ],
                  ),
                );

            return Column(
              children: [
                Container(
                  width: 100.w,
                  height: 12.h,
                  color: ColorProvider.get(CustomColor.primary),
                  child: Wrap(
                    alignment: WrapAlignment.spaceAround,
                    runAlignment: WrapAlignment.center,
                    children: [
                      if (context.read<TopBarConentProvider>().pageIndex == 2)
                        Consumer<TimerInfoProvider>(
                          builder: (context, timerInfoProvider, child) {
                            return ElevatedButton(
                              onPressed: timerInfoProvider.isActive
                                  ? null
                                  : () => context
                                      .read<TopBarConentProvider>()
                                      .switchTopicLeft(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    ColorProvider.get(CustomColor.background),
                                elevation: 5,
                                disabledBackgroundColor:
                                    ColorProvider.get(CustomColor.primary),
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                color: ColorProvider.get(CustomColor.primary),
                              ),
                            );
                          },
                        ),
                      if (context
                              .read<TopBarConentProvider>()
                              .getSelectedPage() ==
                          'Topics')
                        //Empty button for spacing the topbar
                        TextButton(
                          onPressed: () {},
                          child: Icon(Icons.abc,
                              color: ColorProvider.get(CustomColor.primary)),
                        ),
                      Container(
                        width: 35.w,
                        height: 5.h,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Consumer<TopBarConentProvider>(
                          builder: (context, topBarConentProvider, child) {
                            if (context
                                    .read<TopBarConentProvider>()
                                    .getSelectedPage() ==
                                'Timer') {
                              return Text(
                                topBarConentProvider.getSelectedTopic().name,
                                maxLines: 1,
                                style: TextStyle(fontSize: 5.w),
                              );
                            } else {
                              return Text(
                                topBarConentProvider.getSelectedPage(),
                                style: TextStyle(fontSize: 5.w),
                              );
                            }
                          },
                        ),
                      ),
                      if (context.read<TopBarConentProvider>().pageIndex == 2)
                        Consumer<TimerInfoProvider>(
                          builder: (context, timerInfoProvider, child) {
                            return ElevatedButton(
                              onPressed: timerInfoProvider.isActive
                                  ? null
                                  : () => context
                                      .read<TopBarConentProvider>()
                                      .switchTopicRight(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    ColorProvider.get(CustomColor.background),
                                elevation: 5,
                                disabledBackgroundColor:
                                    ColorProvider.get(CustomColor.primary),
                              ),
                              child: Icon(
                                Icons.arrow_forward,
                                color: ColorProvider.get(CustomColor.primary),
                              ),
                            );
                          },
                        ),
                      if (context
                              .read<TopBarConentProvider>()
                              .getSelectedPage() ==
                          'Topics')
                        ElevatedButton(
                          onPressed: () => addTopic(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                ColorProvider.get(CustomColor.background),
                            elevation: 5,
                            disabledBackgroundColor:
                                ColorProvider.get(CustomColor.primary),
                          ),
                          child: Icon(
                            Icons.add,
                            color: ColorProvider.get(CustomColor.primary),
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  width: 100.w,
                  height: 5.h,
                  color: ColorProvider.get(CustomColor.tertiary),
                  alignment: Alignment.center,
                  child: Consumer<BluetoothInfoProvider>(
                    builder: (context, bluetoothInfoProvider, child) {
                      return Wrap(
                        alignment: WrapAlignment.center,
                        children: <Widget>[
                          Icon(Icons.watch,
                              color: ColorProvider.get(CustomColor.background)),
                          Text(
                            bluetoothInfoProvider.getConnectionState(),
                            style: TextStyle(
                                color:
                                    ColorProvider.get(CustomColor.background),
                                fontSize: 20),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
