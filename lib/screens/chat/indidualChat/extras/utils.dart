
import 'package:chat_app/models/chat/old_chat.dart';

bool wasSenderSame(int index, Chat provider) {
  return provider.messages.elementAt(index).sender ==
      provider.messages.elementAt(index + 1).sender;
}

String getDate(DateTime dateTime) {
  String hour = dateTime.hour.toString();
  if (noBritish.containsKey(hour)) {
    hour = noBritish[hour]!;
  }

  String minute = dateTime.minute.toString();
  if (minute.length < 2) {
    minute = '0$minute';
  }
  return hour + ':' + minute;
}

Map<String, String> noBritish = {
  '13': '1',
  '14': '2',
  '15': '3',
  '16': '4',
  '17': '5',
  '18': '6',
  '19': '7',
  '20': '8',
  '21': '9',
  '22': '10',
  '23': '11',
  '24': '12',
};
