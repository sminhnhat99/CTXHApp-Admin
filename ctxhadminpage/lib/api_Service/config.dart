class Config{
  // url
  static String url = 'http://192.168.89.102:3000/';
  //Login - Register
  static String register = 'api/users/register';
  static String login = 'api/users/login';
  // Member
  static String getMember = 'api/member/show?page=';
  static String addMember = 'api/member/create';
  static String deleteMember = 'api/member/delete/';
  static String getMemberDetail = 'api/member/search/';
  static String searchMemberByName = 'api/member/searchbyName/?name=';
  static String searchMemberByPosition = 'api/member/searchbyPosition?position=';
  static String searchMemberByKhoaDoiVien = 'api/member/searchbyKDV/?KDV=';
  static String searchMemberByRole = 'api/member/searchbyRole/?role=';
  static String editMember = 'api/member/edit/';
  // Activity
  // Event

  static String addEvent = 'api/event/create';
  static String getEvent = 'api/event/read/?time=';
}