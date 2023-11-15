import 'package:hive_db_hw/hive_db_hw.dart' as hive_db_hw;
import 'package:hive/hive.dart';

void main(List<String> arguments) {
  var box = Hive.box('myBox'); //parent - layer
  box.put('name', 'Immanuel');
  box.put('usn', '1NH20CS090');
  print(box.get('name'));
  print(box.get('usn'));
}
