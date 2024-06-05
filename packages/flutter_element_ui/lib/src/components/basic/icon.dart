import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_element_ui/src/extension.dart';

/// 默认的图标样式
class ElDefaultIconStyle extends InheritedWidget {
  const ElDefaultIconStyle({
    super.key,
    required super.child,
    this.icon,
    this.svgUrl,
    this.size,
    this.color,
  }) : assert(
            (icon == null && svgUrl == null) ||
                (icon != null && svgUrl == null && svgUrl != '') ||
                (icon == null && svgUrl != null && svgUrl != ''),
            'icon和svgUrl不能同时存在');

  /// 默认的icon
  final IconData? icon;

  /// 默认的svg图标地址
  final String? svgUrl;
  final double? size;
  final Color? color;

  static ElDefaultIconStyle? of(BuildContext context) {
    final ElDefaultIconStyle? result = context.dependOnInheritedWidgetOfExactType<ElDefaultIconStyle>();
    return result;
  }

  @override
  bool updateShouldNotify(ElDefaultIconStyle oldWidget) {
    return true;
  }
}

/// Element UI 图标，它只是在[Icon]的基础上添加了[ElDefaultIconStyle]默认图标样式，同时扩展了svg图标，底层基于[flutter_svg]
class ElIcon extends StatelessWidget {
  /// 渲染普通的icon
  const ElIcon(
    this.icon, {
    super.key,
    this.size,
    this.fill,
    this.weight,
    this.grade,
    this.opticalSize,
    this.color,
    this.shadows,
    this.semanticLabel,
    this.textDirection,
    this.applyTextScaling,
  })  : svgUrl = null,
        assert(fill == null || (0.0 <= fill && fill <= 1.0)),
        assert(weight == null || (0.0 < weight)),
        assert(opticalSize == null || (0.0 < opticalSize));

  /// 渲染svg图标
  const ElIcon.svg(
    this.svgUrl, {
    super.key,
    this.size,
    this.color,
  })  : icon = null,
        fill = null,
        weight = null,
        grade = null,
        opticalSize = null,
        shadows = null,
        semanticLabel = null,
        textDirection = null,
        applyTextScaling = null;

  /// 渲染普通图标
  final IconData? icon;

  /// 渲染svg图标
  final String? svgUrl;

  final double? size;
  final Color? color;
  final double? fill;
  final double? weight;
  final double? grade;
  final double? opticalSize;
  final List<Shadow>? shadows;
  final String? semanticLabel;
  final TextDirection? textDirection;
  final bool? applyTextScaling;

  @override
  Widget build(BuildContext context) {
    ElDefaultIconStyle? style = ElDefaultIconStyle.of(context);
    if (svgUrl != null || (style?.svgUrl != null && style!.svgUrl != '')) {
      return _SvgWidget(
        svgUrl,
        size: size ?? style?.size ?? context.elConfig.iconSize,
        color: color ?? style?.color,
        package: 'flutter_element_ui',
      );
    } else {
      return Icon(
        icon ?? style?.icon,
        size: size ?? style?.size ?? context.elConfig.iconSize,
        color: color ?? style?.color,
        fill: fill,
        weight: weight,
        grade: grade,
        opticalSize: opticalSize,
        shadows: shadows,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
        applyTextScaling: applyTextScaling,
      );
    }
  }
}

class _SvgWidget extends StatelessWidget {
  const _SvgWidget(
    this.url, {
    this.size,
    this.color,
    this.package,
  });

  /// svg地址路径，它根据地址前缀自动加载不同环境的svg：
  /// * http、https - 加载网络上的svg
  /// * asset、assets、/asset、/assets - 加载项目资产中的svg
  final String? url;

  final double? size;

  final Color? color;

  /// 指定其他库的asset资产包
  final String? package;

  @override
  Widget build(BuildContext context) {
    assert(url != null);
    if (url!.startsWith('http')) {
      return SvgPicture.network(
        url!,
        width: size,
        height: size,
        color: color,
      );
    } else if (url!.startsWith('asset') || url!.startsWith('/asset')) {
      return SvgPicture.asset(
        url!,
        width: size,
        height: size,
        color: color,
        package: package,
      );
    }
    return const SizedBox();
  }
}

class ElIcons {
  static const String addLocation = 'assets/icons/add-location.svg';
  static const String aim = 'assets/icons/aim.svg';
  static const String alarmClock = 'assets/icons/alarm-clock.svg';
  static const String apple = 'assets/icons/apple.svg';
  static const String arrowDown = 'assets/icons/arrow-down.svg';
  static const String arrowDownBold = 'assets/icons/arrow-down-bold.svg';
  static const String arrowLeft = 'assets/icons/arrow-left.svg';
  static const String arrowLeftBold = 'assets/icons/arrow-left-bold.svg';
  static const String arrowRight = 'assets/icons/arrow-right.svg';
  static const String arrowRightBold = 'assets/icons/arrow-right-bold.svg';
  static const String arrowUp = 'assets/icons/arrow-up.svg';
  static const String arrowUpBold = 'assets/icons/arrow-up-bold.svg';
  static const String avatar = 'assets/icons/avatar.svg';
  static const String back = 'assets/icons/back.svg';
  static const String baseball = 'assets/icons/baseball.svg';
  static const String basketball = 'assets/icons/basketball.svg';
  static const String bell = 'assets/icons/bell.svg';
  static const String bellFilled = 'assets/icons/bell-filled.svg';
  static const String bicycle = 'assets/icons/bicycle.svg';
  static const String bottom = 'assets/icons/bottom.svg';
  static const String bottomLeft = 'assets/icons/bottom-left.svg';
  static const String bottomRight = 'assets/icons/bottom-right.svg';
  static const String bowl = 'assets/icons/bowl.svg';
  static const String box = 'assets/icons/box.svg';
  static const String briefcase = 'assets/icons/briefcase.svg';
  static const String brush = 'assets/icons/brush.svg';
  static const String brushFilled = 'assets/icons/brush-filled.svg';
  static const String burger = 'assets/icons/burger.svg';
  static const String calendar = 'assets/icons/calendar.svg';
  static const String aicameram = 'assets/icons/aicameram.svg';
  static const String cameraFilled = 'assets/icons/camera-filled.svg';
  static const String caretBottom = 'assets/icons/caret-bottom.svg';
  static const String caretLeft = 'assets/icons/caret-left.svg';
  static const String caretRight = 'assets/icons/caret-right.svg';
  static const String caretTop = 'assets/icons/caret-top.svg';
  static const String cellphone = 'assets/icons/cellphone.svg';
  static const String chatDotRound = 'assets/icons/chat-dot-round.svg';
  static const String chatDotSquare = 'assets/icons/chat-dot-square.svg';
  static const String chatLineRound = 'assets/icons/chat-line-round.svg';
  static const String chatLineSquare = 'assets/icons/chat-line-square.svg';
  static const String chatRound = 'assets/icons/chat-round.svg';
  static const String chatSquare = 'assets/icons/chat-square.svg';
  static const String check = 'assets/icons/check.svg';
  static const String checked = 'assets/icons/checked.svg';
  static const String cherry = 'assets/icons/cherry.svg';
  static const String chicken = 'assets/icons/chicken.svg';
  static const String chromeFilled = 'assets/icons/chrome-filled.svg';
  static const String circleCheck = 'assets/icons/circle-check.svg';
  static const String circleCheckFilled = 'assets/icons/circle-check-filled.svg';
  static const String circleClose = 'assets/icons/circle-close.svg';
  static const String circleCloseFilled = 'assets/icons/circle-close-filled.svg';
  static const String circlePlus = 'assets/icons/circle-plus.svg';
  static const String circlePlusFilled = 'assets/icons/circle-plus-filled.svg';
  static const String clock = 'assets/icons/clock.svg';
  static const String close = 'assets/icons/close.svg';
  static const String closeBold = 'assets/icons/close-bold.svg';
  static const String cloudy = 'assets/icons/cloudy.svg';
  static const String coffee = 'assets/icons/coffee.svg';
  static const String coffeeCup = 'assets/icons/coffee-cup.svg';
  static const String coin = 'assets/icons/coin.svg';
  static const String coldDrink = 'assets/icons/cold-drink.svg';
  static const String collection = 'assets/icons/collection.svg';
  static const String collectionTag = 'assets/icons/collection-tag.svg';
  static const String comment = 'assets/icons/comment.svg';
  static const String compass = 'assets/icons/compass.svg';
  static const String connection = 'assets/icons/connection.svg';
  static const String coordinate = 'assets/icons/coordinate.svg';
  static const String copyDocument = 'assets/icons/copy-document.svg';
  static const String cpu = 'assets/icons/cpu.svg';
  static const String creditCard = 'assets/icons/credit-card.svg';
  static const String crop = 'assets/icons/crop.svg';
  static const String dArrowLeft = 'assets/icons/d-arrow-left.svg';
  static const String dArrowRight = 'assets/icons/d-arrow-right.svg';
  static const String dCaret = 'assets/icons/d-caret.svg';
  static const String dataAnalysis = 'assets/icons/data-analysis.svg';
  static const String dataBoard = 'assets/icons/data-board.svg';
  static const String dataLine = 'assets/icons/data-line.svg';
  static const String delete = 'assets/icons/delete.svg';
  static const String deleteFilled = 'assets/icons/delete-filled.svg';
  static const String deleteLocation = 'assets/icons/delete-location.svg';
  static const String dessert = 'assets/icons/dessert.svg';
  static const String discount = 'assets/icons/discount.svg';
  static const String dish = 'assets/icons/dish.svg';
  static const String dishDot = 'assets/icons/dish-dot.svg';
  static const String document = 'assets/icons/document.svg';
  static const String documentAdd = 'assets/icons/document-add.svg';
  static const String documentChecked = 'assets/icons/document-checked.svg';
  static const String documentCopy = 'assets/icons/document-copy.svg';
  static const String documentDelete = 'assets/icons/document-delete.svg';
  static const String documentRemove = 'assets/icons/document-remove.svg';
  static const String download = 'assets/icons/download.svg';
  static const String drizzling = 'assets/icons/drizzling.svg';
  static const String edit = 'assets/icons/edit.svg';
  static const String editPen = 'assets/icons/edit-pen.svg';
  static const String eleme = 'assets/icons/eleme.svg';
  static const String elemeFilled = 'assets/icons/eleme-filled.svg';
  static const String elementPlus = 'assets/icons/element-plus.svg';
  static const String expand = 'assets/icons/expand.svg';
  static const String failed = 'assets/icons/failed.svg';
  static const String female = 'assets/icons/female.svg';
  static const String files = 'assets/icons/files.svg';
  static const String film = 'assets/icons/film.svg';
  static const String filter = 'assets/icons/filter.svg';
  static const String finished = 'assets/icons/finished.svg';
  static const String firstAidKit = 'assets/icons/first-aid-kit.svg';
  static const String flag = 'assets/icons/flag.svg';
  static const String fold = 'assets/icons/fold.svg';
  static const String folder = 'assets/icons/folder.svg';
  static const String folderAdd = 'assets/icons/folder-add.svg';
  static const String folderChecked = 'assets/icons/folder-checked.svg';
  static const String folderDelete = 'assets/icons/folder-delete.svg';
  static const String folderOpened = 'assets/icons/folder-opened.svg';
  static const String folderRemove = 'assets/icons/folder-remove.svg';
  static const String food = 'assets/icons/food.svg';
  static const String football = 'assets/icons/football.svg';
  static const String forkSpoon = 'assets/icons/fork-spoon.svg';
  static const String fries = 'assets/icons/fries.svg';
  static const String fullScreen = 'assets/icons/full-screen.svg';
  static const String goblet = 'assets/icons/goblet.svg';
  static const String gobletFull = 'assets/icons/goblet-full.svg';
  static const String gobletSquare = 'assets/icons/goblet-square.svg';
  static const String gobletSquareFull = 'assets/icons/goblet-square-full.svg';
  static const String goldMedal = 'assets/icons/gold-medal.svg';
  static const String goods = 'assets/icons/goods.svg';
  static const String goodsFilled = 'assets/icons/goods-filled.svg';
  static const String grape = 'assets/icons/grape.svg';
  static const String grid = 'assets/icons/grid.svg';
  static const String guide = 'assets/icons/guide.svg';
  static const String handbag = 'assets/icons/handbag.svg';
  static const String headset = 'assets/icons/headset.svg';
  static const String help = 'assets/icons/help.svg';
  static const String helpFilled = 'assets/icons/help-filled.svg';
  static const String hide = 'assets/icons/hide.svg';
  static const String histogram = 'assets/icons/histogram.svg';
  static const String homeFilled = 'assets/icons/home-filled.svg';
  static const String hotWater = 'assets/icons/hot-water.svg';
  static const String house = 'assets/icons/house.svg';
  static const String iceCream = 'assets/icons/ice-cream.svg';
  static const String iceCreamRound = 'assets/icons/ice-cream-round.svg';
  static const String iceCreamSquare = 'assets/icons/ice-cream-square.svg';
  static const String iceDrink = 'assets/icons/ice-drink.svg';
  static const String iceTea = 'assets/icons/ice-tea.svg';
  static const String infoFilled = 'assets/icons/info-filled.svg';
  static const String iphone = 'assets/icons/iphone.svg';
  static const String key = 'assets/icons/key.svg';
  static const String knifeFork = 'assets/icons/knife-fork.svg';
  static const String lightning = 'assets/icons/lightning.svg';
  static const String link = 'assets/icons/link.svg';
  static const String list = 'assets/icons/list.svg';
  static const String loading = 'assets/icons/loading.svg';
  static const String location = 'assets/icons/location.svg';
  static const String locationFilled = 'assets/icons/location-filled.svg';
  static const String locationInformation = 'assets/icons/location-information.svg';
  static const String lock = 'assets/icons/lock.svg';
  static const String lollipop = 'assets/icons/lollipop.svg';
  static const String magicStick = 'assets/icons/magic-stick.svg';
  static const String magnet = 'assets/icons/magnet.svg';
  static const String male = 'assets/icons/male.svg';
  static const String management = 'assets/icons/management.svg';
  static const String mapLocation = 'assets/icons/map-location.svg';
  static const String medal = 'assets/icons/medal.svg';
  static const String memo = 'assets/icons/memo.svg';
  static const String menu = 'assets/icons/menu.svg';
  static const String message = 'assets/icons/message.svg';
  static const String messageBox = 'assets/icons/message-box.svg';
  static const String mic = 'assets/icons/mic.svg';
  static const String microphone = 'assets/icons/microphone.svg';
  static const String milkTea = 'assets/icons/milk-tea.svg';
  static const String minus = 'assets/icons/minus.svg';
  static const String money = 'assets/icons/money.svg';
  static const String monitor = 'assets/icons/monitor.svg';
  static const String moon = 'assets/icons/moon.svg';
  static const String moonNight = 'assets/icons/moon-night.svg';
  static const String more = 'assets/icons/more.svg';
  static const String moreFilled = 'assets/icons/more-filled.svg';
  static const String mostlyCloudy = 'assets/icons/mostly-cloudy.svg';
  static const String mouse = 'assets/icons/mouse.svg';
  static const String mug = 'assets/icons/mug.svg';
  static const String mute = 'assets/icons/mute.svg';
  static const String muteNotification = 'assets/icons/mute-notification.svg';
  static const String noSmoking = 'assets/icons/no-smoking.svg';
  static const String notebook = 'assets/icons/notebook.svg';
  static const String notification = 'assets/icons/notification.svg';
  static const String odometer = 'assets/icons/odometer.svg';
  static const String officeBuilding = 'assets/icons/office-building.svg';
  static const String open = 'assets/icons/open.svg';
  static const String operation = 'assets/icons/operation.svg';
  static const String opportunity = 'assets/icons/opportunity.svg';
  static const String orange = 'assets/icons/orange.svg';
  static const String paperclip = 'assets/icons/paperclip.svg';
  static const String partlyCloudy = 'assets/icons/partly-cloudy.svg';
  static const String pear = 'assets/icons/pear.svg';
  static const String phone = 'assets/icons/phone.svg';
  static const String phoneFilled = 'assets/icons/phone-filled.svg';
  static const String picture = 'assets/icons/picture.svg';
  static const String pictureFilled = 'assets/icons/picture-filled.svg';
  static const String pictureRounded = 'assets/icons/picture-rounded.svg';
  static const String pieChart = 'assets/icons/pie-chart.svg';
  static const String place = 'assets/icons/place.svg';
  static const String platform = 'assets/icons/platform.svg';
  static const String plus = 'assets/icons/plus.svg';
  static const String pointer = 'assets/icons/pointer.svg';
  static const String position = 'assets/icons/position.svg';
  static const String postcard = 'assets/icons/postcard.svg';
  static const String pouring = 'assets/icons/pouring.svg';
  static const String present = 'assets/icons/present.svg';
  static const String priceTag = 'assets/icons/price-tag.svg';
  static const String printer = 'assets/icons/printer.svg';
  static const String promotion = 'assets/icons/promotion.svg';
  static const String quartzWatch = 'assets/icons/quartz-watch.svg';
  static const String questionFilled = 'assets/icons/question-filled.svg';
  static const String rank = 'assets/icons/rank.svg';
  static const String reading = 'assets/icons/reading.svg';
  static const String readingLamp = 'assets/icons/reading-lamp.svg';
  static const String refresh = 'assets/icons/refresh.svg';
  static const String refreshLeft = 'assets/icons/refresh-left.svg';
  static const String refreshRight = 'assets/icons/refresh-right.svg';
  static const String refrigerator = 'assets/icons/refrigerator.svg';
  static const String remove = 'assets/icons/remove.svg';
  static const String removeFilled = 'assets/icons/remove-filled.svg';
  static const String right = 'assets/icons/right.svg';
  static const String scaleToOriginal = 'assets/icons/scale-to-original.svg';
  static const String school = 'assets/icons/school.svg';
  static const String scissor = 'assets/icons/scissor.svg';
  static const String search = 'assets/icons/search.svg';
  static const String select = 'assets/icons/select.svg';
  static const String sell = 'assets/icons/sell.svg';
  static const String semiSelect = 'assets/icons/semi-select.svg';
  static const String service = 'assets/icons/service.svg';
  static const String setUp = 'assets/icons/set-up.svg';
  static const String setting = 'assets/icons/setting.svg';
  static const String share = 'assets/icons/share.svg';
  static const String ship = 'assets/icons/ship.svg';
  static const String shop = 'assets/icons/shop.svg';
  static const String shoppingBag = 'assets/icons/shopping-bag.svg';
  static const String shoppingCart = 'assets/icons/shopping-cart.svg';
  static const String shoppingCartFull = 'assets/icons/shopping-cart-full.svg';
  static const String shoppingTrolley = 'assets/icons/shopping-trolley.svg';
  static const String smoking = 'assets/icons/smoking.svg';
  static const String soccer = 'assets/icons/soccer.svg';
  static const String soldOut = 'assets/icons/sold-out.svg';
  static const String sort = 'assets/icons/sort.svg';
  static const String sortDown = 'assets/icons/sort-down.svg';
  static const String sortUp = 'assets/icons/sort-up.svg';
  static const String stamp = 'assets/icons/stamp.svg';
  static const String star = 'assets/icons/star.svg';
  static const String starFilled = 'assets/icons/star-filled.svg';
  static const String stopwatch = 'assets/icons/stopwatch.svg';
  static const String successFilled = 'assets/icons/success-filled.svg';
  static const String sugar = 'assets/icons/sugar.svg';
  static const String suitcase = 'assets/icons/suitcase.svg';
  static const String suitcaseLine = 'assets/icons/suitcase-line.svg';
  static const String sunny = 'assets/icons/sunny.svg';
  static const String sunrise = 'assets/icons/sunrise.svg';
  static const String sunset = 'assets/icons/sunset.svg';
  static const String switchs = 'assets/icons/switch.svg';
  static const String switchButton = 'assets/icons/switch-button.svg';
  static const String switchFilled = 'assets/icons/switch-filled.svg';
  static const String takeawayBox = 'assets/icons/takeaway-box.svg';
  static const String ticket = 'assets/icons/ticket.svg';
  static const String tickets = 'assets/icons/tickets.svg';
  static const String timer = 'assets/icons/timer.svg';
  static const String toiletPaper = 'assets/icons/toilet-paper.svg';
  static const String tools = 'assets/icons/tools.svg';
  static const String top = 'assets/icons/top.svg';
  static const String topLeft = 'assets/icons/top-left.svg';
  static const String topRight = 'assets/icons/top-right.svg';
  static const String trendCharts = 'assets/icons/trend-charts.svg';
  static const String trophy = 'assets/icons/trophy.svg';
  static const String trophyBase = 'assets/icons/trophy-base.svg';
  static const String turnOff = 'assets/icons/turn-off.svg';
  static const String umbrella = 'assets/icons/umbrella.svg';
  static const String unlock = 'assets/icons/unlock.svg';
  static const String upload = 'assets/icons/upload.svg';
  static const String uploadFilled = 'assets/icons/upload-filled.svg';
  static const String user = 'assets/icons/user.svg';
  static const String userFilled = 'assets/icons/user-filled.svg';
  static const String van = 'assets/icons/van.svg';
  static const String videoCamera = 'assets/icons/video-camera.svg';
  static const String videoCameraFilled = 'assets/icons/video-camera-filled.svg';
  static const String videoPause = 'assets/icons/video-pause.svg';
  static const String videoPlay = 'assets/icons/video-play.svg';
  static const String view = 'assets/icons/view.svg';
  static const String wallet = 'assets/icons/wallet.svg';
  static const String walletFilled = 'assets/icons/wallet-filled.svg';
  static const String warnTriangleFilled = 'assets/icons/warn-triangle-filled.svg';
  static const String warning = 'assets/icons/warning.svg';
  static const String warningFilled = 'assets/icons/warning-filled.svg';
  static const String watch = 'assets/icons/watch.svg';
  static const String watermelon = 'assets/icons/watermelon.svg';
  static const String windPower = 'assets/icons/wind-power.svg';
  static const String zoomIn = 'assets/icons/zoom-in.svg';
  static const String zoomOut = 'assets/icons/zoom-out.svg';
}
