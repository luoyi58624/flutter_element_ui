import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

/// 设备信息工具类
class DeviceUtil {
  DeviceUtil._();

  /// 设备信息实例对象
  static final DeviceInfoPlugin instance = DeviceInfoPlugin();

  /// 六大平台的设备信息，此变量实际上就是下面对象的Map格式数据
  static late final Map<String, dynamic> deviceInfo;

  /// 如果当前运行的平台是 Android，则不为null
  static AndroidDeviceInfo? androidInfo;

  /// 如果当前运行的平台是 IOS，则不为null
  static IosDeviceInfo? iosInfo;

  /// 如果当前运行的平台是 MacOS，则不为null
  static MacOsDeviceInfo? macInfo;

  /// 如果当前运行的平台是 Windows，则不为null
  static WindowsDeviceInfo? windowsInfo;

  /// 如果当前运行的平台是 Linux，则不为null
  static LinuxDeviceInfo? linuxInfo;

  /// 如果当前运行的平台是 Web，则不为null
  static WebBrowserInfo? webInfo;

  /// 所有的安卓设备厂商
  static const Map<String, String> allAndroidManufacturer = {
    'xiaomi': '小米',
    'honor': '荣耀',
    'oppo': 'OPPO',
    'oneplus': '一加',
    'realme': '红米',
    'vivo': 'Vivo',
    'huawei': '华为',
    'meizu': '魅族',
    'zte': '中兴',
    'sony': '索尼',
    'samsung': '三星',
    'letv': '乐视',
    'yulong': '酷派',
    'lenovo': '联想',
  };

  /// 当前设备是否是小米
  static bool get isXiaomi =>
      androidInfo?.manufacturer.toLowerCase() == 'xiaomi';

  /// 当前设备是否是荣耀
  static bool get isHONOR => androidInfo?.manufacturer.toLowerCase() == 'honor';

  /// 当前设备是否是OPPO
  static bool get isOPPO => androidInfo?.manufacturer.toLowerCase() == 'oppo';

  /// 当前设备是否是一加
  static bool get isOnePlus =>
      androidInfo?.manufacturer.toLowerCase() == 'oneplus';

  /// 当前设备是否是红米
  static bool get isRealme =>
      androidInfo?.manufacturer.toLowerCase() == 'realme';

  /// 当前设备是否是Vivo
  static bool get isVivo => androidInfo?.manufacturer.toLowerCase() == 'vivo';

  /// 当前设备是否是华为
  static bool get isHUAWEI =>
      androidInfo?.manufacturer.toLowerCase() == 'huawei';

  /// 当前设备是否是魅族
  static bool get isMeizu => androidInfo?.manufacturer.toLowerCase() == 'meizu';

  /// 当前设备是否是中兴
  static bool get isZTE => androidInfo?.manufacturer.toLowerCase() == 'zte';

  /// 当前设备是否是索尼
  static bool get isSony => androidInfo?.manufacturer.toLowerCase() == 'sony';

  /// 当前设备是否是三星
  static bool get isSamsung =>
      androidInfo?.manufacturer.toLowerCase() == 'samsung';

  /// 当前设备是否是乐视
  static bool get isLetv => androidInfo?.manufacturer.toLowerCase() == 'letv';

  /// 当前设备是否是酷派
  static bool get isYulong =>
      androidInfo?.manufacturer.toLowerCase() == 'yulong';

  /// 当前设备是否是联想
  static bool get isLENOVO =>
      androidInfo?.manufacturer.toLowerCase() == 'lenovo';

  static bool _isInit = false;

  /// 初始化平台信息
  static Future<void> init() async {
    if (!_isInit) {
      _isInit = true;
      if (kIsWeb) {
        webInfo = await instance.webBrowserInfo;
        deviceInfo = webInfo!.data;
      } else {
        if (PlatformUtil.isAndroid) {
          androidInfo = await instance.androidInfo;
          deviceInfo = androidInfo!.data;
        } else if (PlatformUtil.isIOS) {
          iosInfo = await instance.iosInfo;
          deviceInfo = iosInfo!.data;
        } else if (PlatformUtil.isMacOS) {
          macInfo = await instance.macOsInfo;
          deviceInfo = macInfo!.data;
        } else if (PlatformUtil.isWindows) {
          windowsInfo = await instance.windowsInfo;
          deviceInfo = windowsInfo!.data;
        } else if (PlatformUtil.isLinux) {
          linuxInfo = await instance.linuxInfo;
          deviceInfo = linuxInfo!.data;
        }
      }
    }
  }
}
