import 'package:flutter/material.dart';

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
                      onPressed: () {},
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
                        left: (j == 0) ? 0 : 4,
                        right: (j == column - 1) ? 0 : 4,
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
                        left: (j == 0) ? 0 : 4,
                        right: (j == column - 1) ? 0 : 4,
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
                        left: (j == 0) ? 0 : 4,
                        right: (j == column - 1) ? 0 : 4,
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

    Widget _buildOutside() {
      return Column(
        children: [
          const SizedBox(height: 256),
          Text(
            'Zocbo',
            style: textTheme.titleMedium?.copyWith(
              color: Color(0xFFCCCCCC),
            ),
          ),
          Text(
            'zocbo@sparcs.org',
            style: textTheme.bodyMedium?.copyWith(
              color: Color(0xFFCCCCCC),
            ),
          ),
          Text(
            '© 2023, SPARCS Zocbo Team',
            style: textTheme.bodyMedium?.copyWith(
              color: Color(0xFFCCCCCC),
            ),
          ),
        ],
      );
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

final departments = defaultFilter['departments']['options'].keys.toList();
final types = defaultFilter['types']['options'].keys.toList();
final levels = defaultFilter['levels']['options'].keys.toList();

final Map<String, dynamic> defaultFilter = {
  "departments": {
    "label": "학과",
    "options": {
      "HSS": {"label": "인문", "selected": false},
      "CE": {"label": "건환", "selected": false},
      "MSB": {"label": "기경", "selected": false},
      "ME": {"label": "기계", "selected": false},
      "PH": {"label": "물리", "selected": false},
      "BiS": {"label": "바공", "selected": false},
      "IE": {"label": "산공", "selected": false},
      "ID": {"label": "산디", "selected": false},
      "BS": {"label": "생명", "selected": false},
      "CBE": {"label": "생화", "selected": false},
      "MAS": {"label": "수리", "selected": false},
      "MS": {"label": "소재", "selected": false},
      "NQE": {"label": "원양", "selected": false},
      "TS": {"label": "융인", "selected": false},
      "CS": {"label": "전산", "selected": false},
      "EE": {"label": "전자", "selected": false},
      "AE": {"label": "항공", "selected": false},
      "CH": {"label": "화학", "selected": false},
      "ETC": {"label": "기타", "selected": false},
    }
  },
  "types": {
    "label": "구분",
    "options": {
      "BR": {"label": "기필", "selected": false},
      "BE": {"label": "기선", "selected": false},
      "MR": {"label": "전필", "selected": false},
      "ME": {"label": "전선", "selected": false},
      "MGC": {"label": "교필", "selected": false},
      "HSE": {"label": "인선", "selected": false},
      "GR": {"label": "공통", "selected": false},
      "EG": {"label": "석박", "selected": false},
      "OE": {"label": "자선", "selected": false},
      "ETC": {"label": "기타", "selected": false},
    }
  },
  "levels": {
    "label": "학년",
    "options": {
      "100": {"label": "100", "selected": false},
      "200": {"label": "200", "selected": false},
      "300": {"label": "300", "selected": false},
      "400": {"label": "400", "selected": false},
    }
  },
};
