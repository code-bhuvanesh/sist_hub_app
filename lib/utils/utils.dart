import 'package:fluttertoast/fluttertoast.dart';

void showToast({required String msg}) {
  Fluttertoast.showToast(msg: msg);
}

String getTimeDiffernce(DateTime createdTime) {
  var difference = DateTime.now().difference(createdTime);
  if (difference.inMinutes == 0) {
    return "${difference.inSeconds}s";
  } else if (difference.inHours == 0) {
    return "${difference.inMinutes}m";
  } else if (difference.inDays == 0) {
    return "${difference.inHours}h";
  } else if (difference.inDays > 365) {
    return "${difference.inDays ~/ 365}y";
  } else if (difference.inDays > 30) {
    return "${difference.inDays ~/ 30}m";
  } else {
    return "${difference.inDays}d";
  }
}
