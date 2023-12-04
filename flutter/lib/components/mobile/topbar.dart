import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
import 'package:animations/animations.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class TopBar extends StatefulWidget {
  TopBar({super.key, required this.callback});
  Function() callback;
  @override
  State<TopBar> createState() => _TopBarState(callback: callback);
}

class _TopBarState extends State<TopBar> {
  _TopBarState({required this.callback});
  Function() callback;
  final ButtonStyle topBarButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: ColorProvider.get(CustomColor.background),
      elevation: 5,
      disabledBackgroundColor: ColorProvider.get(CustomColor.primary));
// THINGS TO DISCUSS WITH MICHEL
// the changing of the pages, why dont the two left and right pointer buttons dissapear
// why doesnt the plus button appear on the topics page
  @override
  Widget build(BuildContext context) {
    final TextEditingController topicnameController = TextEditingController();
    Color pickerColor = Color(0xff029eff);
    Color currentColor = Color(0xff029eff);
    void changeColor(Color color) {
      setState(() => pickerColor = color);
    }

    void addTopic() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                'Add Topic',
                style: TextStyle(color: ColorProvider.get(CustomColor.text)),
              ),
              content: Column(
                children: [
                  TextField(
                    controller: topicnameController,
                    decoration:
                        InputDecoration(hintText: 'Enter the topic name'),
                  ),
                  TextButton(
                      onPressed: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                'Pick a color!',
                                style: TextStyle(
                                    color: ColorProvider.get(CustomColor.text)),
                              ),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: pickerColor,
                                  onColorChanged: changeColor,
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: const Text('Got it'),
                                  onPressed: () {
                                    setState(() => currentColor = pickerColor);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                      child: 
                          Text(
                            'tap to pick a topic color',
                            style: TextStyle(
                                color: ColorProvider.get(CustomColor.text),
                                fontSize: 5.w,
                                decoration: TextDecoration.none),
                          )
                        )
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      if(topicnameController.text.isEmpty) {
                        TopicProvider.createTopic(TopicModel('No Name', currentColor));
                      } else {
                        TopicProvider.createTopic(TopicModel(topicnameController.text, currentColor));
                      }
                      Navigator.of(context).pop();
                      callback();
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          color: ColorProvider.get(CustomColor.primary)),
                    ))
              ],
            ));
    return Consumer<ThemeChangeProvider>(
        builder: (context, themeChangeProvider, child) {
      return Column(children: [
        Container(
            width: 100.w,
            height: 12.h,
            color: ColorProvider.get(CustomColor.primary),
            child: Wrap(
                alignment: WrapAlignment.spaceAround,
                runAlignment: WrapAlignment.center,
                children: [
                  if (context.read<TopBarConentProvider>().pageIndex ==
                      2)
                    Consumer<TimerInfoProvider>(
                        builder: (context, timerInfoProvider, child) {
                      return ElevatedButton(
                        onPressed: timerInfoProvider.isActive
                            ? null
                            : () => context
                                .read<TopBarConentProvider>()
                                .switchTopicLeft(),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorProvider.get(CustomColor.background),
                            elevation: 5,
                            disabledBackgroundColor: ColorProvider.get(CustomColor.primary)
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: ColorProvider.get(CustomColor.primary),
                        ),
                      );
                    }),
                  if (context.read<TopBarConentProvider>().getSelectedPage() ==
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
                  if (context.read<TopBarConentProvider>().pageIndex ==
                      2)
                    Consumer<TimerInfoProvider>(
                        builder: (context, timerInfoProvider, child) {
                      return ElevatedButton(
                          onPressed: timerInfoProvider.isActive
                              ? null
                              : () => context
                                  .read<TopBarConentProvider>()
                                  .switchTopicRight(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorProvider.get(CustomColor.background),
                            elevation: 5,
                            disabledBackgroundColor: ColorProvider.get(CustomColor.primary)
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: ColorProvider.get(CustomColor.primary),
                          ));
                    }),
                  if (context.read<TopBarConentProvider>().getSelectedPage() ==
                      'Topics')
                    ElevatedButton(
                        onPressed: () => addTopic(),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorProvider.get(CustomColor.background),
                            elevation: 5,
                            disabledBackgroundColor: ColorProvider.get(CustomColor.primary)
                        ),
                        child: Icon(
                          Icons.add,
                          color: ColorProvider.get(CustomColor.primary),
                        )),
                ])),
        Container(
          width: 100.w,
          height: 5.h,
          color: ColorProvider.get(CustomColor.tertiary),
          alignment: Alignment.center,
          child: Consumer<BluetoothInfoProvider>(
              builder: (context, bluetoothInfoProvider, child) {
            return Wrap(alignment: WrapAlignment.center, children: <Widget>[
              Icon(Icons.watch,
                  color: ColorProvider.get(CustomColor.background)),
              Text(
                bluetoothInfoProvider.getConnectionState(),
                style: TextStyle(
                    color: ColorProvider.get(CustomColor.background),
                    fontSize: 20),
              ),
            ]);
          }),
        ),
      ]);
    });
  }
}
