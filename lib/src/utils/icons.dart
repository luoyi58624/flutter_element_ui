import 'package:flutter/widgets.dart';

class _ElIconData extends IconData {
  const _ElIconData(super.codePoint)
      : super(
          fontFamily: 'element',
          fontPackage: 'flutter_element_ui',
        );
}

/// Element UI 字体图标集合，总计 280 个图标，图标库的尺寸为 55 kb，打包时会剔除未使用的图标
class ElIcons {
  ElIcons._();

  static const IconData platformEleme = _ElIconData(0xe716);
  static const IconData eleme = _ElIconData(0xe688);
  static const IconData deleteSolid = _ElIconData(0xe671);
  static const IconData delete = _ElIconData(0xe677);
  static const IconData sTools = _ElIconData(0xe726);
  static const IconData setting = _ElIconData(0xe70f);
  static const IconData userSolid = _ElIconData(0xe6fa);
  static const IconData user = _ElIconData(0xe6f9);
  static const IconData phone = _ElIconData(0xe6da);
  static const IconData phoneOutline = _ElIconData(0xe6d7);
  static const IconData more = _ElIconData(0xe6c1);
  static const IconData moreOutline = _ElIconData(0xe6c3);
  static const IconData starOn = _ElIconData(0xe6ef);
  static const IconData starOff = _ElIconData(0xe701);
  static const IconData sGoods = _ElIconData(0xe718);
  static const IconData goods = _ElIconData(0xe69a);
  static const IconData warning = _ElIconData(0xe70d);
  static const IconData warningOutline = _ElIconData(0xe705);
  static const IconData question = _ElIconData(0xe746);
  static const IconData info = _ElIconData(0xe6a7);
  static const IconData remove = _ElIconData(0xe6e9);
  static const IconData circlePlus = _ElIconData(0xe65c);
  static const IconData success = _ElIconData(0xe6f0);
  static const IconData error = _ElIconData(0xe687);
  static const IconData zoomIn = _ElIconData(0xe70b);
  static const IconData zoomOut = _ElIconData(0xe711);
  static const IconData removeOutline = _ElIconData(0xe6e7);
  static const IconData circlePlusOutline = _ElIconData(0xe65b);
  static const IconData circleCheck = _ElIconData(0xe658);
  static const IconData circleClose = _ElIconData(0xe659);
  static const IconData sHelp = _ElIconData(0xe71a);
  static const IconData help = _ElIconData(0xe69b);
  static const IconData minus = _ElIconData(0xe6b6);
  static const IconData plus = _ElIconData(0xe710);
  static const IconData check = _ElIconData(0xe652);
  static const IconData close = _ElIconData(0xe65e);
  static const IconData picture = _ElIconData(0xe6d8);
  static const IconData pictureOutline = _ElIconData(0xe6dd);
  static const IconData pictureOutlineRound = _ElIconData(0xe6db);
  static const IconData upload = _ElIconData(0xe748);
  static const IconData upload2 = _ElIconData(0xe6fb);
  static const IconData download = _ElIconData(0xe681);
  static const IconData cameraSolid = _ElIconData(0xe648);
  static const IconData camera = _ElIconData(0xe650);
  static const IconData videoCameraSolid = _ElIconData(0xe6fc);
  static const IconData videoCamera = _ElIconData(0xe6fe);
  static const IconData messageSolid = _ElIconData(0xe6b9);
  static const IconData bell = _ElIconData(0xe63f);
  static const IconData sCooperation = _ElIconData(0xe6e1);
  static const IconData sOrder = _ElIconData(0xe725);
  static const IconData sPlatform = _ElIconData(0xe728);
  static const IconData sFold = _ElIconData(0xe6e5);
  static const IconData sUnfold = _ElIconData(0xe747);
  static const IconData sOperation = _ElIconData(0xe6cd);
  static const IconData sPromotion = _ElIconData(0xe721);
  static const IconData sHome = _ElIconData(0xe6c5);
  static const IconData sRelease = _ElIconData(0xe723);
  static const IconData sTicket = _ElIconData(0xe6ed);
  static const IconData sManagement = _ElIconData(0xe6cc);
  static const IconData sOpen = _ElIconData(0xe6c9);
  static const IconData sShop = _ElIconData(0xe6ec);
  static const IconData sMarketing = _ElIconData(0xe6ca);
  static const IconData sFlag = _ElIconData(0xe6e3);
  static const IconData sComment = _ElIconData(0xe6e8);
  static const IconData sFinance = _ElIconData(0xe6e6);
  static const IconData sClaim = _ElIconData(0xe717);
  static const IconData sCustom = _ElIconData(0xe6e4);
  static const IconData sOpportunity = _ElIconData(0xe724);
  static const IconData sData = _ElIconData(0xe6df);
  static const IconData sCheck = _ElIconData(0xe6e2);
  static const IconData sGrid = _ElIconData(0xe719);
  static const IconData menu = _ElIconData(0xe6b4);
  static const IconData share = _ElIconData(0xe709);
  static const IconData dCaret = _ElIconData(0xe66b);
  static const IconData caretLeft = _ElIconData(0xe647);
  static const IconData caretRight = _ElIconData(0xe649);
  static const IconData caretBottom = _ElIconData(0xe64b);
  static const IconData caretTop = _ElIconData(0xe64a);
  static const IconData bottomLeft = _ElIconData(0xe644);
  static const IconData bottomRight = _ElIconData(0xe640);
  static const IconData back = _ElIconData(0xe636);
  static const IconData right = _ElIconData(0xe6ff);
  static const IconData bottom = _ElIconData(0xe64e);
  static const IconData top = _ElIconData(0xe736);
  static const IconData topLeft = _ElIconData(0xe730);
  static const IconData topRight = _ElIconData(0xe735);
  static const IconData arrowLeft = _ElIconData(0xe637);
  static const IconData arrowRight = _ElIconData(0xe639);
  static const IconData arrowDown = _ElIconData(0xe63c);
  static const IconData arrowUp = _ElIconData(0xe63a);
  static const IconData dArrowLeft = _ElIconData(0xe670);
  static const IconData dArrowRight = _ElIconData(0xe66c);
  static const IconData videoPause = _ElIconData(0xe700);
  static const IconData videoPlay = _ElIconData(0xe6fd);
  static const IconData refresh = _ElIconData(0xe72c);
  static const IconData refreshRight = _ElIconData(0xe6ea);
  static const IconData refreshLeft = _ElIconData(0xe6dc);
  static const IconData finished = _ElIconData(0xe68f);
  static const IconData sort = _ElIconData(0xe6f1);
  static const IconData sortUp = _ElIconData(0xe6ee);
  static const IconData sortDown = _ElIconData(0xe722);
  static const IconData rank = _ElIconData(0xe745);
  static const IconData loading = _ElIconData(0xe6b2);
  static const IconData view = _ElIconData(0xe707);
  static const IconData cScaleToOriginal = _ElIconData(0xe64f);
  static const IconData date = _ElIconData(0xe674);
  static const IconData edit = _ElIconData(0xe680);
  static const IconData editOutline = _ElIconData(0xe684);
  static const IconData folder = _ElIconData(0xe690);
  static const IconData folderOpened = _ElIconData(0xe695);
  static const IconData folderAdd = _ElIconData(0xe68c);
  static const IconData folderRemove = _ElIconData(0xe68a);
  static const IconData folderDelete = _ElIconData(0xe68d);
  static const IconData folderChecked = _ElIconData(0xe68b);
  static const IconData tickets = _ElIconData(0xe6f5);
  static const IconData documentRemove = _ElIconData(0xe67e);
  static const IconData documentDelete = _ElIconData(0xe67d);
  static const IconData documentCopy = _ElIconData(0xe678);
  static const IconData documentChecked = _ElIconData(0xe67c);
  static const IconData document = _ElIconData(0xe679);
  static const IconData documentAdd = _ElIconData(0xe67b);
  static const IconData printer = _ElIconData(0xe741);
  static const IconData paperclip = _ElIconData(0xe715);
  static const IconData takeawayBox = _ElIconData(0xe6f2);
  static const IconData search = _ElIconData(0xe6d2);
  static const IconData monitor = _ElIconData(0xe738);
  static const IconData attract = _ElIconData(0xe638);
  static const IconData mobile = _ElIconData(0xe6be);
  static const IconData scissors = _ElIconData(0xe6d4);
  static const IconData umbrella = _ElIconData(0xe73b);
  static const IconData headset = _ElIconData(0xe69c);
  static const IconData brush = _ElIconData(0xe642);
  static const IconData mouse = _ElIconData(0xe6cb);
  static const IconData coordinate = _ElIconData(0xe666);
  static const IconData magicStick = _ElIconData(0xe6ae);
  static const IconData reading = _ElIconData(0xe744);
  static const IconData dataLine = _ElIconData(0xe66f);
  static const IconData dataBoard = _ElIconData(0xe66d);
  static const IconData pieChart = _ElIconData(0xe6de);
  static const IconData dataAnalysis = _ElIconData(0xe66e);
  static const IconData collectionTag = _ElIconData(0xe663);
  static const IconData film = _ElIconData(0xe686);
  static const IconData suitcase = _ElIconData(0xe729);
  static const IconData suitcase1 = _ElIconData(0xe72a);
  static const IconData receiving = _ElIconData(0xe6d9);
  static const IconData collection = _ElIconData(0xe665);
  static const IconData files = _ElIconData(0xe685);
  static const IconData notebook1 = _ElIconData(0xe6c8);
  static const IconData notebook2 = _ElIconData(0xe6c4);
  static const IconData toiletPaper = _ElIconData(0xe732);
  static const IconData officeBuilding = _ElIconData(0xe6ce);
  static const IconData school = _ElIconData(0xe6eb);
  static const IconData tableLamp = _ElIconData(0xe733);
  static const IconData house = _ElIconData(0xe69d);
  static const IconData noSmoking = _ElIconData(0xe6c2);
  static const IconData smoking = _ElIconData(0xe71e);
  static const IconData shoppingCartFull = _ElIconData(0xe71f);
  static const IconData shoppingCart1 = _ElIconData(0xe71d);
  static const IconData shoppingCart2 = _ElIconData(0xe71c);
  static const IconData shoppingBag1 = _ElIconData(0xe6d5);
  static const IconData shoppingBag2 = _ElIconData(0xe71b);
  static const IconData soldOut = _ElIconData(0xe727);
  static const IconData sell = _ElIconData(0xe6d1);
  static const IconData present = _ElIconData(0xe73d);
  static const IconData box = _ElIconData(0xe641);
  static const IconData bankCard = _ElIconData(0xe643);
  static const IconData money = _ElIconData(0xe6c0);
  static const IconData coin = _ElIconData(0xe682);
  static const IconData wallet = _ElIconData(0xe703);
  static const IconData discount = _ElIconData(0xe673);
  static const IconData priceTag = _ElIconData(0xe73f);
  static const IconData news = _ElIconData(0xe6c6);
  static const IconData guide = _ElIconData(0xe74a);
  static const IconData male = _ElIconData(0xe6b3);
  static const IconData female = _ElIconData(0xe683);
  static const IconData thumb = _ElIconData(0xe6f4);
  static const IconData cpu = _ElIconData(0xe669);
  static const IconData link = _ElIconData(0xe6af);
  static const IconData connection = _ElIconData(0xe667);
  static const IconData open = _ElIconData(0xe6cf);
  static const IconData turnOff = _ElIconData(0xe737);
  static const IconData setUp = _ElIconData(0xe70a);
  static const IconData chatRound = _ElIconData(0xe654);
  static const IconData chatLineRound = _ElIconData(0xe656);
  static const IconData chatSquare = _ElIconData(0xe657);
  static const IconData chatDotRound = _ElIconData(0xe651);
  static const IconData chatDotSquare = _ElIconData(0xe655);
  static const IconData chatLineSquare = _ElIconData(0xe653);
  static const IconData message = _ElIconData(0xe6b7);
  static const IconData postcard = _ElIconData(0xe73a);
  static const IconData position = _ElIconData(0xe73e);
  static const IconData turnOffMicrophone = _ElIconData(0xe6f6);
  static const IconData microphone = _ElIconData(0xe6b5);
  static const IconData closeNotification = _ElIconData(0xe65d);
  static const IconData bangZhu = _ElIconData(0xe63e);
  static const IconData time = _ElIconData(0xe6f7);
  static const IconData odometer = _ElIconData(0xe6c7);
  static const IconData crop = _ElIconData(0xe668);
  static const IconData aim = _ElIconData(0xe635);
  static const IconData switchButton = _ElIconData(0xe731);
  static const IconData fullScreen = _ElIconData(0xe696);
  static const IconData copyDocument = _ElIconData(0xe66a);
  static const IconData mic = _ElIconData(0xe6ba);
  static const IconData stopwatch = _ElIconData(0xe6f3);
  static const IconData medal1 = _ElIconData(0xe6bd);
  static const IconData medal = _ElIconData(0xe6bc);
  static const IconData trophy = _ElIconData(0xe702);
  static const IconData trophy1 = _ElIconData(0xe74b);
  static const IconData firstAidKit = _ElIconData(0xe692);
  static const IconData discover = _ElIconData(0xe67a);
  static const IconData place = _ElIconData(0xe712);
  static const IconData location = _ElIconData(0xe6b1);
  static const IconData locationOutline = _ElIconData(0xe6ac);
  static const IconData locationInformation = _ElIconData(0xe6aa);
  static const IconData addLocation = _ElIconData(0xe634);
  static const IconData deleteLocation = _ElIconData(0xe672);
  static const IconData mapLocation = _ElIconData(0xe6b8);
  static const IconData alarmClock = _ElIconData(0xe63b);
  static const IconData timer = _ElIconData(0xe749);
  static const IconData watch1 = _ElIconData(0xe70e);
  static const IconData watch = _ElIconData(0xe704);
  static const IconData lock = _ElIconData(0xe6ab);
  static const IconData unlock = _ElIconData(0xe739);
  static const IconData key = _ElIconData(0xe6a3);
  static const IconData service = _ElIconData(0xe6d3);
  static const IconData mobilePhone = _ElIconData(0xe6bf);
  static const IconData bicycle = _ElIconData(0xe645);
  static const IconData truck = _ElIconData(0xe6f8);
  static const IconData ship = _ElIconData(0xe6d0);
  static const IconData basketball = _ElIconData(0xe64c);
  static const IconData football = _ElIconData(0xe68e);
  static const IconData soccer = _ElIconData(0xe720);
  static const IconData baseball = _ElIconData(0xe646);
  static const IconData windPower = _ElIconData(0xe706);
  static const IconData lightRain = _ElIconData(0xe6a9);
  static const IconData lightning = _ElIconData(0xe6ad);
  static const IconData heavyRain = _ElIconData(0xe6a0);
  static const IconData sunrise = _ElIconData(0xe72f);
  static const IconData sunrise1 = _ElIconData(0xe72e);
  static const IconData sunset = _ElIconData(0xe72d);
  static const IconData sunny = _ElIconData(0xe742);
  static const IconData cloudy = _ElIconData(0xe662);
  static const IconData partlyCloudy = _ElIconData(0xe714);
  static const IconData cloudyAndSunny = _ElIconData(0xe65f);
  static const IconData moon = _ElIconData(0xe73c);
  static const IconData moonNight = _ElIconData(0xe743);
  static const IconData dish = _ElIconData(0xe676);
  static const IconData dish1 = _ElIconData(0xe67f);
  static const IconData food = _ElIconData(0xe694);
  static const IconData chicken = _ElIconData(0xe65a);
  static const IconData forkSpoon = _ElIconData(0xe691);
  static const IconData knifeFork = _ElIconData(0xe6a5);
  static const IconData burger = _ElIconData(0xe64d);
  static const IconData tableware = _ElIconData(0xe734);
  static const IconData sugar = _ElIconData(0xe72b);
  static const IconData dessert = _ElIconData(0xe675);
  static const IconData iceCream = _ElIconData(0xe6a2);
  static const IconData hotWater = _ElIconData(0xe69f);
  static const IconData waterCup = _ElIconData(0xe70c);
  static const IconData coffeeCup = _ElIconData(0xe661);
  static const IconData coldDrink = _ElIconData(0xe664);
  static const IconData goblet = _ElIconData(0xe698);
  static const IconData gobletFull = _ElIconData(0xe693);
  static const IconData gobletSquare = _ElIconData(0xe699);
  static const IconData gobletSquareFull = _ElIconData(0xe697);
  static const IconData refrigerator = _ElIconData(0xe6e0);
  static const IconData grape = _ElIconData(0xe6a8);
  static const IconData watermelon = _ElIconData(0xe708);
  static const IconData cherry = _ElIconData(0xe660);
  static const IconData apple = _ElIconData(0xe63d);
  static const IconData pear = _ElIconData(0xe713);
  static const IconData orange = _ElIconData(0xe6d6);
  static const IconData coffee = _ElIconData(0xe689);
  static const IconData iceTea = _ElIconData(0xe6a6);
  static const IconData iceDrink = _ElIconData(0xe6a1);
  static const IconData milkTea = _ElIconData(0xe6bb);
  static const IconData potatoStrips = _ElIconData(0xe740);
  static const IconData lollipop = _ElIconData(0xe6b0);
  static const IconData iceCreamSquare = _ElIconData(0xe6a4);
  static const IconData iceCreamRound = _ElIconData(0xe69e);

  /// 返回所有图标集合
  static const Map<String, IconData> values = {
    'platformEleme': platformEleme,
    'eleme': eleme,
    'deleteSolid': deleteSolid,
    'delete': delete,
    'sTools': sTools,
    'setting': setting,
    'userSolid': userSolid,
    'user': user,
    'phone': phone,
    'phoneOutline': phoneOutline,
    'more': more,
    'moreOutline': moreOutline,
    'starOn': starOn,
    'starOff': starOff,
    'sGoods': sGoods,
    'goods': goods,
    'warning': warning,
    'warningOutline': warningOutline,
    'question': question,
    'info': info,
    'remove': remove,
    'circlePlus': circlePlus,
    'success': success,
    'error': error,
    'zoomIn': zoomIn,
    'zoomOut': zoomOut,
    'removeOutline': removeOutline,
    'circlePlusOutline': circlePlusOutline,
    'circleCheck': circleCheck,
    'circleClose': circleClose,
    'sHelp': sHelp,
    'help': help,
    'minus': minus,
    'plus': plus,
    'check': check,
    'close': close,
    'picture': picture,
    'pictureOutline': pictureOutline,
    'pictureOutlineRound': pictureOutlineRound,
    'upload': upload,
    'upload2': upload2,
    'download': download,
    'cameraSolid': cameraSolid,
    'camera': camera,
    'videoCameraSolid': videoCameraSolid,
    'videoCamera': videoCamera,
    'messageSolid': messageSolid,
    'bell': bell,
    'sCooperation': sCooperation,
    'sOrder': sOrder,
    'sPlatform': sPlatform,
    'sFold': sFold,
    'sUnfold': sUnfold,
    'sOperation': sOperation,
    'sPromotion': sPromotion,
    'sHome': sHome,
    'sRelease': sRelease,
    'sTicket': sTicket,
    'sManagement': sManagement,
    'sOpen': sOpen,
    'sShop': sShop,
    'sMarketing': sMarketing,
    'sFlag': sFlag,
    'sComment': sComment,
    'sFinance': sFinance,
    'sClaim': sClaim,
    'sCustom': sCustom,
    'sOpportunity': sOpportunity,
    'sData': sData,
    'sCheck': sCheck,
    'sGrid': sGrid,
    'menu': menu,
    'share': share,
    'dCaret': dCaret,
    'caretLeft': caretLeft,
    'caretRight': caretRight,
    'caretBottom': caretBottom,
    'caretTop': caretTop,
    'bottomLeft': bottomLeft,
    'bottomRight': bottomRight,
    'back': back,
    'right': right,
    'bottom': bottom,
    'top': top,
    'topLeft': topLeft,
    'topRight': topRight,
    'arrowLeft': arrowLeft,
    'arrowRight': arrowRight,
    'arrowDown': arrowDown,
    'arrowUp': arrowUp,
    'dArrowLeft': dArrowLeft,
    'dArrowRight': dArrowRight,
    'videoPause': videoPause,
    'videoPlay': videoPlay,
    'refresh': refresh,
    'refreshRight': refreshRight,
    'refreshLeft': refreshLeft,
    'finished': finished,
    'sort': sort,
    'sortUp': sortUp,
    'sortDown': sortDown,
    'rank': rank,
    'loading': loading,
    'view': view,
    'cScaleToOriginal': cScaleToOriginal,
    'date': date,
    'edit': edit,
    'editOutline': editOutline,
    'folder': folder,
    'folderOpened': folderOpened,
    'folderAdd': folderAdd,
    'folderRemove': folderRemove,
    'folderDelete': folderDelete,
    'folderChecked': folderChecked,
    'tickets': tickets,
    'documentRemove': documentRemove,
    'documentDelete': documentDelete,
    'documentCopy': documentCopy,
    'documentChecked': documentChecked,
    'document': document,
    'documentAdd': documentAdd,
    'printer': printer,
    'paperclip': paperclip,
    'takeawayBox': takeawayBox,
    'search': search,
    'monitor': monitor,
    'attract': attract,
    'mobile': mobile,
    'scissors': scissors,
    'umbrella': umbrella,
    'headset': headset,
    'brush': brush,
    'mouse': mouse,
    'coordinate': coordinate,
    'magicStick': magicStick,
    'reading': reading,
    'dataLine': dataLine,
    'dataBoard': dataBoard,
    'pieChart': pieChart,
    'dataAnalysis': dataAnalysis,
    'collectionTag': collectionTag,
    'film': film,
    'suitcase': suitcase,
    'suitcase1': suitcase1,
    'receiving': receiving,
    'collection': collection,
    'files': files,
    'notebook1': notebook1,
    'notebook2': notebook2,
    'toiletPaper': toiletPaper,
    'officeBuilding': officeBuilding,
    'school': school,
    'tableLamp': tableLamp,
    'house': house,
    'noSmoking': noSmoking,
    'smoking': smoking,
    'shoppingCartFull': shoppingCartFull,
    'shoppingCart1': shoppingCart1,
    'shoppingCart2': shoppingCart2,
    'shoppingBag1': shoppingBag1,
    'shoppingBag2': shoppingBag2,
    'soldOut': soldOut,
    'sell': sell,
    'present': present,
    'box': box,
    'bankCard': bankCard,
    'money': money,
    'coin': coin,
    'wallet': wallet,
    'discount': discount,
    'priceTag': priceTag,
    'news': news,
    'guide': guide,
    'male': male,
    'female': female,
    'thumb': thumb,
    'cpu': cpu,
    'link': link,
    'connection': connection,
    'open': open,
    'turnOff': turnOff,
    'setUp': setUp,
    'chatRound': chatRound,
    'chatLineRound': chatLineRound,
    'chatSquare': chatSquare,
    'chatDotRound': chatDotRound,
    'chatDotSquare': chatDotSquare,
    'chatLineSquare': chatLineSquare,
    'message': message,
    'postcard': postcard,
    'position': position,
    'turnOffMicrophone': turnOffMicrophone,
    'microphone': microphone,
    'closeNotification': closeNotification,
    'bangZhu': bangZhu,
    'time': time,
    'odometer': odometer,
    'crop': crop,
    'aim': aim,
    'switchButton': switchButton,
    'fullScreen': fullScreen,
    'copyDocument': copyDocument,
    'mic': mic,
    'stopwatch': stopwatch,
    'medal1': medal1,
    'medal': medal,
    'trophy': trophy,
    'trophy1': trophy1,
    'firstAidKit': firstAidKit,
    'discover': discover,
    'place': place,
    'location': location,
    'locationOutline': locationOutline,
    'locationInformation': locationInformation,
    'addLocation': addLocation,
    'deleteLocation': deleteLocation,
    'mapLocation': mapLocation,
    'alarmClock': alarmClock,
    'timer': timer,
    'watch1': watch1,
    'watch': watch,
    'lock': lock,
    'unlock': unlock,
    'key': key,
    'service': service,
    'mobilePhone': mobilePhone,
    'bicycle': bicycle,
    'truck': truck,
    'ship': ship,
    'basketball': basketball,
    'football': football,
    'soccer': soccer,
    'baseball': baseball,
    'windPower': windPower,
    'lightRain': lightRain,
    'lightning': lightning,
    'heavyRain': heavyRain,
    'sunrise': sunrise,
    'sunrise1': sunrise1,
    'sunset': sunset,
    'sunny': sunny,
    'cloudy': cloudy,
    'partlyCloudy': partlyCloudy,
    'cloudyAndSunny': cloudyAndSunny,
    'moon': moon,
    'moonNight': moonNight,
    'dish': dish,
    'dish1': dish1,
    'food': food,
    'chicken': chicken,
    'forkSpoon': forkSpoon,
    'knifeFork': knifeFork,
    'burger': burger,
    'tableware': tableware,
    'sugar': sugar,
    'dessert': dessert,
    'iceCream': iceCream,
    'hotWater': hotWater,
    'waterCup': waterCup,
    'coffeeCup': coffeeCup,
    'coldDrink': coldDrink,
    'goblet': goblet,
    'gobletFull': gobletFull,
    'gobletSquare': gobletSquare,
    'gobletSquareFull': gobletSquareFull,
    'refrigerator': refrigerator,
    'grape': grape,
    'watermelon': watermelon,
    'cherry': cherry,
    'apple': apple,
    'pear': pear,
    'orange': orange,
    'coffee': coffee,
    'iceTea': iceTea,
    'iceDrink': iceDrink,
    'milkTea': milkTea,
    'potatoStrips': potatoStrips,
    'lollipop': lollipop,
    'iceCreamSquare': iceCreamSquare,
    'iceCreamRound': iceCreamRound,
  };
}
