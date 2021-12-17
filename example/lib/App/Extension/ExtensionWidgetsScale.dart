import 'package:example/App/Constant/App/AppConstant.dart';
import 'package:example/App/Init/Screen/SizeConfig.dart';

/// [textScale] Font size ları ölçeklendirmek için kullanılmakta
extension WidgetsScale on num {
 double get textScale => this * (SizeConfig.screenWidth / designWith);
}
