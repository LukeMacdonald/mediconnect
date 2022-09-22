String getDayStringFrontDayInt(int day){
  switch (day) {
    case 1:
      return 'Monday';
    case 2:
      return 'Tuesday';
    case 3:
      return 'Wednesday';
    case 4:
      return 'Thursday';
    case 5:
      return 'Friday';
    case 6:
      return  'Saturday';
    default:
      return 'Error';
  }
}
int getDayIntFromDayString(String day){
  switch (day) {
    case "Monday":
      return 1;
    case 'Tuesday':
      return 2;
    case 'Wednesday':
      return 3;

    case 'Thursday':
      return 4;

    case 'Friday':
      return 5;
    case 'Saturday':
      return 6;
    default:
      return -1;
  }

}
String createTime(String start, String end){
  return "${start.substring(0, start.length - 3)} - ${end.substring(0, end.length - 3)}";
}
String url(){
  return "http://localhost:8080/";
}