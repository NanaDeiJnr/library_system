const kPrimaryColorString = '#FFD704';
const kPrimaryTextColorDarkString = '#263238';
const kPrimaryTextColorLightString = '#424A60';
const kPrimaryBackgroundColorString = '#F6F6F9';
const kRedString = '#E32526';
const kRoundButtonOutlineColorString = '#E3E9ED';
const kTextInputBorderColorString = '#E4DFDF';
const kTextInputHintColorString = '#747688';
const kTextInputIconColorString = '#807A7A';

// final kPrimaryColor = HexColor.fromHex(kPrimaryColorString);
// final kPrimaryTextColorDark = HexColor.fromHex(kPrimaryTextColorDarkString);
// final kPrimaryTextColorLight = HexColor.fromHex(kPrimaryTextColorLightString);
// final kPrimaryBackgroundColor = HexColor.fromHex(kPrimaryBackgroundColorString);
// final kRedColor = HexColor.fromHex(kRedString);
// final kRoundButtonOutlineColor = HexColor.fromHex(kRoundButtonOutlineColorString);
// final kTextInputBorderColor = HexColor.fromHex(kTextInputBorderColorString);
// final kTextInputHintColor = HexColor.fromHex(kTextInputHintColorString);
// final kTextInputIconColor = HexColor.fromHex(kTextInputIconColorString);


const kIsLoggedIn = 'isloggedin';
const kUserId = 'userid';
const kUserEmail = 'useremail';
const kHasSeenIntro = 'hasseenintro';
const kAccessToken = 'atk';
const kAccessTokenTime = 'atkt';
const kRefreshTokenTime = 'rtkt';
const kRefreshToken = 'rtk';
const kTempRegistrationData = "tempdata";
const kRelation = 'rltn';
const kUserProfile = 'upfl';
const kChildrenList = 'chldLst';
const kSeats = 'sts';
const kTempData = 'tmpdt';
const kAllTrips = 'altps';
const kColor = 'kclr';
const kDocType = 'dctlst';
const kVehicleMake = 'vhmk';
const kVehicleModel = 'vhml';
const kVehicleType = 'vhtp';
const kYear = 'vhyr';
const kVehicleId = 'vhid';
const kDriverStatus = 'drstts';
const kNotifications = 'ntf';
const kNewNotificationAvailable = 'inntfa';
const kWithdrawalList = 'wthlst';


/*const kIdVerificationSubmitted = 'idvsmt';
const kDriverLicenseSubmitted = 'drlsmt';
const kVehicleDetailsSubmitted = 'vhdtsmt';*/


const kMapApiKey = 'AIzaSyAkrrPQJrTuVkgi78_vmHZ1HQAAwmgbbvk';


class RequestStatus{
  static const pending = '0';
  static const accepted = '1';
  static const assigned = '2';
  static const scheduled = '3';
  static const pickup = '3.25';
  static const pickup2 = '325';
  static const arrived = '3.5';
  static const arrived2 = '35';
  static const waiting = '3.75';
  static const waiting2 = '375';
  static const ongoing = '4';
  static const completed = '5';
  static const cancelled = '6';
  static const rejected = '7';
}

class FirebaseDBKey{
  static const coordinates = 'coordinates';
  static const rides = 'rides';
  static const pickup = 'pickup';
  static const dropoff = 'dropoff';
  static const distance = 'distance';
  static const duration = 'duration';
  static const durationInSeconds = 'durationInSeconds';
  static const eta = 'eta';
  static const lat = 'lat';
  static const lng = 'lng';
  static const driverLocation = 'driverLocation';
  static const tripId = 'tripid';
  static const route = 'route';
  static const lastUpdated = 'lastUpdated';
}
