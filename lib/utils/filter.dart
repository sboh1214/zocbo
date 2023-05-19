final List<String> departments =
    defaultFilter['departments']['options'].keys.toList();
final List<String> types = defaultFilter['types']['options'].keys.toList();
final List<String> levels = defaultFilter['levels']['options'].keys.toList();

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
