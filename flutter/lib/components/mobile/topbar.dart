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

class TopBar extends StatelessWidget {
  const TopBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChangeProvider>(
        builder: (context, themeChangeProvider, child) {
      final TextEditingController topicnameController = TextEditingController();
      Color pickerColor = const Color(0xff029eff);

      void addTopic() => showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  'Create Topic',
                  style: TextStyle(color: ColorProvider.get(CustomColor.text)),
                  textAlign: TextAlign.center,
                ),
                content: SingleChildScrollView(
                    child: Column(
                  children: [
                    Text(
                      'Name the topic',
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
                        'Pick a topic color',
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
                          context
                              .read<TopicProvider>()
                              .createTopic(TopicModel('No Name', pickerColor));
                        } else {
                          context.read<TopicProvider>().createTopic(TopicModel(
                              topicnameController.text, pickerColor));
                        }
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Create',
                        style: TextStyle(
                            color: ColorProvider.get(CustomColor.primary)),
                      ))
                ],
              ));

      return Column(children: [
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
                                ColorProvider.get(CustomColor.primary)),
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
                                  ColorProvider.get(CustomColor.primary)),
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
                          backgroundColor:
                              ColorProvider.get(CustomColor.background),
                          elevation: 5,
                          disabledBackgroundColor:
                              ColorProvider.get(CustomColor.primary)),
                      child: Icon(
                        Icons.add,
                        color: ColorProvider.get(CustomColor.primary),
                      ),
                    ),
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
