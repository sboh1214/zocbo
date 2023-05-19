import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zocbo/models/setting.dart';
import 'package:zocbo/services/lecture_service.dart';

import '../models/exam.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  Widget leftTitles(double value, TitleMeta meta) {
    String text;

    if (value == 0) {
      text = '1';
    } else if (value == 5) {
      text = '5';
    } else if (value == 10) {
      text = '10';
    } else if (value == 15) {
      text = '15';
    } else if (value == 20) {
      text = '20';
    } else {
      return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        value.toInt().toString(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
      ),
    );
  }

  Widget _buildGraph() {
    return BarChart(
      BarChartData(
        maxY: 20,
        barGroups: List.generate(
          10,
          (index) => BarChartGroupData(
            x: 10 * index + 5,
            barRods: [
              BarChartRodData(
                toY: Random().nextDouble() * 20,
                color: Theme.of(context).colorScheme.primary,
              ),
              BarChartRodData(
                toY: Random().nextDouble() * 20,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: leftTitles,
            ),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: bottomTitles,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        gridData: FlGridData(
          show: true,
        ),
      ),
    );
  }

  Widget _buildBody(Exam exam) {
    final textTheme = Theme.of(context).textTheme;
    final titleStyle = textTheme.titleSmall?.copyWith(
      fontWeight: FontWeight.bold,
    );
    final descStyle = textTheme.titleSmall;

    return Container(
        margin: const EdgeInsets.all(16),
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "시험 방식",
                      style: titleStyle,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      exam.type ?? '모름',
                      style: descStyle,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "시험 시간",
                      style: titleStyle,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${exam.duration}분",
                      style: descStyle,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "반영 비율",
                      style: titleStyle,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${exam.ratio}%",
                      style: descStyle,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "시험 총점",
                      style: titleStyle,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${exam.totalScore}점",
                      style: descStyle,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "시험 설명",
                      style: titleStyle,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      exam.description ?? "설명 없음",
                      style: descStyle,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: (MediaQuery.of(context).size.width - 2 * 16) / 2,
                  child: _buildGraph(),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Text(
                      "평균, 표준편차",
                      style: titleStyle,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${exam.avg ?? '??'}점 ${exam.std ?? '??'}점",
                      style: descStyle,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "최고점, 최저점",
                      style: titleStyle,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${exam.max ?? '??'}점, ${exam.min ?? '??'}점",
                      style: descStyle,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "1Q, 2Q, 3Q",
                      style: titleStyle,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${exam.q1 ?? '??'}점, ${exam.q2 ?? '??'}점, ${exam.q3 ?? '??'}점",
                      style: descStyle,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "내 점수",
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "80점 (상위 15%)",
                          style: textTheme.titleMedium,
                        ),
                      ],
                    ),
                    IconButton.filled(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () {},
                        child: const Text('시험지 다운로드'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () {}, child: const Text('답안지 다운로드')))
                  ],
                )
              ],
            ),
          ],
        ));
  }

  List<Widget> _buildTabs(List<Exam> exams) {
    List<Widget> tabs = [];
    if (exams.any((element) => element.id == 'mid')) {
      tabs.add(_buildBody(exams.firstWhere((element) => element.id == 'mid')));
    }
    if (exams.any((element) => element.id == 'final')) {
      tabs.add(
          _buildBody(exams.firstWhere((element) => element.id == 'final')));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    final exams = context.watch<LectureService>().exams;
    final textTheme = Theme.of(context).textTheme;

    if (exams.isEmpty) {
      final Color _color =
          context.watch<Setting>().brightness == Brightness.light
              ? Color(0xFFAAAAAA)
              : Color(0xFF555555);

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Zocbo',
              style: textTheme.titleMedium?.copyWith(
                color: _color,
              ),
            ),
            Text(
              'zocbo@sparcs.org',
              style: textTheme.bodyMedium?.copyWith(
                color: _color,
              ),
            ),
            Text(
              '© 2023, SPARCS Zocbo Team',
              style: textTheme.bodyMedium?.copyWith(
                color: _color,
              ),
            ),
          ],
        ),
      );
    }
    return TabBarView(
      children: _buildTabs(exams),
    );
  }
}
