import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:topictimer_flutter_application/bll/topic_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/models/bar_data.dart';
import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/components/mobile/models/ble_messages.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/bluetooth_info_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/planning_selected_date_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/tracked_times_provider.dart';


class HistoryGraphComp extends StatefulWidget {

  const HistoryGraphComp({
    Key? key,
  }) : super(key: key);

  final shadowColor = const Color(0xFFCCCCCC);

  @override
  State<HistoryGraphComp> createState() => _HistoryGraphCompState();
}

class _HistoryGraphCompState extends State<HistoryGraphComp> {
  BarChartGroupData generateBarGroup(
    int x,
    Color color,
    double value,
    double shadowValue,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 6,
        ),
        BarChartRodData(
          toY: shadowValue,
          color: widget.shadowColor,
          width: 6,
        ),
      ],
      showingTooltipIndicators: touchedGroupIndex == x ? [0] : [],
    );
  }


  int touchedGroupIndex = -1;

  double calculateTimeDifference(TopicData data) {
    double startSeconds = (data.beginTime.time.hour * 3600 +
            data.beginTime.time.minute * 60 +
            data.beginTime.time.second)
        .toDouble();

    double endSeconds = (data.endTime.time.hour * 3600 +
            data.endTime.time.minute * 60 +
            data.endTime.time.second)
        .toDouble();

    double differenceInSeconds = endSeconds - startSeconds;

    return differenceInSeconds;
  }

  String _calculateTimeDifference(TopicData data) {
    // Calculate the total seconds from a DateTimeJSON instance
    int startSeconds = data.beginTime.time.hour * 3600 +
        data.beginTime.time.minute * 60 +
        data.beginTime.time.second;

    int endSeconds = data.endTime.time.hour * 3600 +
        data.endTime.time.minute * 60 +
        data.endTime.time.second;

    int differenceInSeconds = endSeconds - startSeconds;

    // Format the difference into a human-readable string
    String formattedDifference = _formatDuration(differenceInSeconds);

    return formattedDifference;
  }

  String _formatDuration(int seconds) {
    int hours = seconds ~/ 3600;
    int remainingMinutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    List<String> parts = [];

    if (hours > 0) {
      parts.add('$hours ${hours == 1 ? 'hour' : 'hours'}');
    }

    if (remainingMinutes > 0) {
      parts.add(
          '$remainingMinutes ${remainingMinutes == 1 ? 'minute' : 'minutes'}');
    }

    if (remainingSeconds > 0 || parts.isEmpty) {
      parts.add(
          '$remainingSeconds ${remainingSeconds == 1 ? 'second' : 'seconds'}');
    }

    return parts.join(' and ');
  }

  double formatTimeDifference(
      double differenceInSeconds, double maxDifference) {
    Duration maxDuration = Duration(seconds: maxDifference.toInt());

    if (maxDuration.inSeconds < 60) {
      // If the difference is less than 60 seconds, return seconds
      return differenceInSeconds;
    } else if (maxDuration.inMinutes < 60) {
      // If the difference is less than 60 minutes, return minutes
      return differenceInSeconds / 60;
    } else {
      // If the difference is 60 minutes or more, return hours
      return differenceInSeconds / 3600;
    }
  }

  String _formatDateTime(DateTimeJSON data) {
    return '${data.date.day}-${data.date.month}-${data.date.year} at ${data.time.hour.toString().padLeft(2, '0')}:${data.time.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BluetoothInfoProvider>(
        builder: (context, bluetoothInfoProvider, child) {
      final dataList = context
          .read<TrackedTimesProvider>()
          .getTrackedTimesOnDate(
              context.read<PlanningSelectedDateProvider>().get());
      if (dataList.isNotEmpty) {
        double maxDifference = dataList
            .map((data) => calculateTimeDifference(data))
            .reduce((value, element) => value > element ? value : element);
return Padding(
          padding: const EdgeInsets.all(30),
          child: AspectRatio(
            aspectRatio: 1.4,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.center,
                groupsSpace: 15,
                borderData: FlBorderData(
                  show: true,
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  leftTitles: AxisTitles(
                    drawBehindEverything: true,
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: maxDifference >= 60
                          ? maxDifference >= 600
                              ? maxDifference >= 3600
                                  ? 1
                                  : 10
                              : 1
                          : 10,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          maxDifference >= 60
                              ? value.toStringAsFixed(2)
                              : value.toInt().toString(),
                          textAlign: TextAlign.left,
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 36,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(context
                              .read<TopicProvider>()
                              .getTopicById(dataList[index].id)
                              .name
                              .substring(0, 3)),
                        );
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(),
                  topTitles: AxisTitles(),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.black,
                    strokeWidth: 1,
                  ),
                ),
                barGroups: dataList.asMap().entries.map((e) {
                  final index = e.key;
                  final data = e.value;
                  return generateBarGroup(
                    index,
                    context
                        .read<TopicProvider>()
                        .getTopicById(dataList[index].id)
                        .color,
                    formatTimeDifference(
                        calculateTimeDifference(dataList[index]),
                        maxDifference),
                    0,
                  );
                }).toList(),
                barTouchData: BarTouchData(
                  enabled: true,
                  handleBuiltInTouches: false,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.blueGrey,
                    getTooltipItem: (
                      BarChartGroupData group,
                      int groupIndex,
                      BarChartRodData rod,
                      int rodIndex,
                    ) {
                      return BarTooltipItem(
                        '${context.read<TopicProvider>().getTopicById(dataList[groupIndex].id).name}\n',
                        TextStyle(
                          color: context
                              .read<TopicProvider>()
                              .getTopicById(dataList[groupIndex].id)
                              .color,
                          fontWeight: FontWeight.bold,
                          fontSize: 9,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'Start: ${_formatDateTime(dataList[groupIndex].beginTime)}\nEnd: ${_formatDateTime(dataList[groupIndex].endTime)}\nDuration: ${_calculateTimeDifference(dataList[groupIndex])}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  touchCallback: (event, response) {
                    if (event.isInterestedForInteractions &&
                        response != null &&
                        response.spot != null) {
                      setState(() {
                        touchedGroupIndex = response.spot!.touchedBarGroupIndex;
                      });
                    } else {
                      setState(() {
                        touchedGroupIndex = -1;
                      });
                    }
                  },
                ),
              ),
            ),
          ),
        );
      }
      else {
        return Text(
          "It seems like you don't have any data to display yet, record some data and it will show up here!",
          style: TextStyle(fontSize: 5.w),
          textAlign: TextAlign.center,
        );
      }
    }
    );
  }
}

class _IconWidget extends ImplicitlyAnimatedWidget {
  const _IconWidget({
    required this.color,
    required this.isSelected,
  }) : super(duration: const Duration(milliseconds: 300));
  final Color color;
  final bool isSelected;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _IconWidgetState();
}

class _IconWidgetState extends AnimatedWidgetBaseState<_IconWidget> {
  Tween<double>? _rotationTween;

  @override
  Widget build(BuildContext context) {
    final rotation = math.pi * 4 * _rotationTween!.evaluate(animation);
    final scale = 1 + _rotationTween!.evaluate(animation) * 0.5;
    return Transform(
      transform: Matrix4.rotationZ(rotation).scaled(scale, scale),
      origin: const Offset(14, 14),
      child: Icon(
        widget.isSelected ? Icons.face_retouching_natural : Icons.face,
        color: widget.color,
        size: 28,
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _rotationTween = visitor(
      _rotationTween,
      widget.isSelected ? 1.0 : 0.0,
      (dynamic value) => Tween<double>(
        begin: value as double,
        end: widget.isSelected ? 1.0 : 0.0,
      ),
    ) as Tween<double>?;
  }
}