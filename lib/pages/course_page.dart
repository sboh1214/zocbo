import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

Widget leftTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff7589a2),
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  String text;
  if (value == 0) {
    text = '1K';
  } else if (value == 10) {
    text = '5K';
  } else if (value == 19) {
    text = '10K';
  } else {
    return Container();
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 0,
    child: Text(text, style: style),
  );
}

Widget bottomTitles(double value, TitleMeta meta) {
  final Widget text = Text(
    value.toString(),
    style: const TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
  );

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 16, //margin top
    child: text,
  );
}

class _CoursePageState extends State<CoursePage> {
  Widget _buildGraph() {
    return BarChart(
      BarChartData(
        maxY: 100,
        barGroups: [
          BarChartGroupData(
              x: 0,
              barRods: [BarChartRodData(toY: 30), BarChartRodData(toY: 20)]),
        ],
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.grey,
            getTooltipItem: (a, b, c, d) => null,
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: bottomTitles,
              reservedSize: 42,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: 1,
              getTitlesWidget: leftTitles,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        gridData: FlGridData(show: true),
      ),
    );
  }

  Widget _buildBody() {
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
                      "비대면",
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
                      "120분",
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
                      "30%",
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
                      "100점",
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
                      "프로그래밍 기초 중간고사입니다.\n프로그래밍 기초 중간고사입니다.",
                      style: descStyle,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: _buildGraph(),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      "평균, 표준편차",
                      style: titleStyle,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "35점, 3.5점",
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
                      "95점, 5점",
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
                      "25점, 50점, 75점",
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

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        _buildBody(),
        _buildBody(),
      ],
    );
  }
}
