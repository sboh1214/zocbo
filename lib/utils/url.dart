const baseUrl = "https://otl.kaist.ac.kr";

const sessionUrl = "$baseUrl/session";
const loginUrl = "$sessionUrl/login/?next=$baseUrl";
const sessionInfoUrl = "$sessionUrl/info";

const apiUrl = "/api";
const API_SEMESTER_URL = "$apiUrl/semesters";
const API_COURSE_URL = "$apiUrl/courses";
const API_COURSE_LECTURE_URL = "$API_COURSE_URL/{id}/lectures";
const API_LECTURE_URL = "$apiUrl/lectures";
