import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zocbo/models/course.dart';
import 'package:zocbo/models/setting.dart';
import 'package:zocbo/services/search_service.dart';
import 'package:zocbo/utils/filter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final column = 4;

  String text = '';
  bool isOutside = true;

  Map<String, dynamic> filter = defaultFilter;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    Widget _buildSearch() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: Material(
            elevation: 3,
            shadowColor: Colors.transparent,
            surfaceTintColor:
                isOutside ? colorScheme.surfaceTint : colorScheme.surface,
            borderRadius: BorderRadius.circular(28),
            child: InkWell(
              borderRadius: BorderRadius.circular(28),
              highlightColor: Colors.transparent,
              splashFactory: InkRipple.splashFactory,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isOutside ? Icons.add : Icons.navigate_before,
                      ),
                      onPressed: () {
                        setState(() {
                          isOutside = !isOutside;
                        });
                      },
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          onChanged: (value) => text = value,
                          cursorColor: colorScheme.primary,
                          style: textTheme.bodyLarge,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            isCollapsed: true,
                            border: InputBorder.none,
                            hintText: '검색',
                            hintStyle: textTheme.bodyLarge?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () async {
                        await context.read<SearchService>().courseSearch(
                              text,
                              department: departments
                                  .where(
                                    (element) => filter['departments']
                                        ['options'][element]['selected'],
                                  )
                                  .toList(),
                              type: types
                                  .where(
                                    (element) => filter['types']['options']
                                        [element]['selected'],
                                  )
                                  .toList(),
                              level: levels
                                  .where(
                                    (element) => filter['levels']['options']
                                        [element]['selected'],
                                  )
                                  .toList(),
                            );

                        setState(() {
                          isOutside = true;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget _buildDepartments() {
      return Column(
        children: List.generate(
          (filter['departments']['options'].length ~/ column) + 1,
          (i) {
            return Row(
              children: List.generate(
                column,
                (j) {
                  if (column * i + j < departments.length) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: j == 0 ? 0 : 4,
                        right: j == column - 1 ? 0 : 4,
                      ),
                      child: FilterChip(
                        label: Text(
                          filter['departments']['options']
                              [departments[column * i + j]]['label'],
                        ),
                        selected: filter['departments']['options']
                            [departments[column * i + j]]['selected'],
                        onSelected: (value) {
                          setState(() {
                            filter['departments']['options']
                                    [departments[column * i + j]]['selected'] =
                                value;
                          });
                        },
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            );
          },
        ),
      );
    }

    Widget _buildTypes() {
      return Column(
        children: List.generate(
          (filter['types']['options'].length ~/ column) + 1,
          (i) {
            return Row(
              children: List.generate(
                column,
                (j) {
                  if (column * i + j < types.length) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: j == 0 ? 0 : 4,
                        right: j == column - 1 ? 0 : 4,
                      ),
                      child: FilterChip(
                        label: Text(
                          filter['types']['options'][types[column * i + j]]
                              ['label'],
                        ),
                        selected: filter['types']['options']
                            [types[column * i + j]]['selected'],
                        onSelected: (value) {
                          setState(() {
                            filter['types']['options'][types[column * i + j]]
                                ['selected'] = value;
                          });
                        },
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            );
          },
        ),
      );
    }

    Widget _buildLevels() {
      return Column(
        children: List.generate(
          (filter['levels']['options'].length ~/ column) + 1,
          (i) {
            return Row(
              children: List.generate(
                column,
                (j) {
                  if (column * i + j < levels.length) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: j == 0 ? 0 : 4,
                        right: j == column - 1 ? 0 : 4,
                      ),
                      child: FilterChip(
                        label: Text(
                          filter['levels']['options'][levels[column * i + j]]
                              ['label'],
                        ),
                        selected: filter['levels']['options']
                            [levels[column * i + j]]['selected'],
                        onSelected: (value) {
                          setState(() {
                            filter['levels']['options'][levels[column * i + j]]
                                ['selected'] = value;
                          });
                        },
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            );
          },
        ),
      );
    }

    Widget _buildEmptyOutside() {
      final Color _color =
          context.watch<Setting>().brightness == Brightness.light
              ? Color(0xFFAAAAAA)
              : Color(0xFF555555);

      return Column(
        children: [
          const SizedBox(height: 256),
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
      );
    }

    Widget _buildNotEmptyOutside() {
      List<Course> _courses = context.read<SearchService>().courses!;

      return Expanded(
        child: ListView(
          children: List.generate(
            _courses.length,
            (index) => GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(
                  top: index == 0 ? 0 : 8,
                  bottom: index == _courses.length - 1 ? 0 : 8,
                  left: 16,
                  right: 16,
                ),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.watch<Setting>().brightness == Brightness.light
                      ? Color(0xFFEEEEEE)
                      : Color(0xFF111111),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          _courses[index].title,
                          style: textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _courses[index].oldCode,
                          style: textTheme.titleSmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Divider(),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '제공 학기',
                          style: textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '2021 봄, 2022 봄, 2023 봄',
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget _buildOutside() {
      return context.read<SearchService>().courses!.isEmpty
          ? _buildEmptyOutside()
          : _buildNotEmptyOutside();
    }

    Widget _buildInside() {
      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '학과',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildDepartments(),
            const SizedBox(height: 24),
            Text(
              '구분',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildTypes(),
            const SizedBox(height: 24),
            Text(
              '학년',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildLevels(),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: isOutside ? colorScheme.background : colorScheme.surfaceVariant,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          _buildSearch(),
          const SizedBox(height: 16),
          isOutside ? _buildOutside() : _buildInside(),
        ],
      ),
    );
  }
}
