
class ApiConstance{
  static const String basUrl="https://3c39ab8d73d5.ngrok-free.app/api/";
  static const String basUrlImage="https://3c39ab8d73d5.ngrok-free.app/storage/";
  static String urlImage(String? path)=>"${basUrlImage}$path";
  static const String login="${basUrl}office/login";
  static const String register="${basUrl}office/register";
  static const String getFollowersForOffice="${basUrl}office/getFollowersForOffice";
  static const String getOfficeProfile="${basUrl}office/getOfficeProfile";
  static const String updateProfile="${basUrl}office/UpdateProfileOffice";
  static const String getAcceptedPropertiesForOffice="${basUrl}office/getAcceptedPropertiesForOffice";
  static const String getPindingRequest="${basUrl}office/getPendingRequestsForOffice";
  static const String changeRequestStatus="${basUrl}office/updateRequestStatus";
  static const String createPay="${basUrl}wallet/recharge";
  static const String subscripe="${basUrl}office/activateOrExtendSubscription";
  static const String confirmRecharge="${basUrl}confirmRecharge";
  static const String getTransaction="${basUrl}wallet/transactions";
  static const String getBalance="${basUrl}wallet/show";
  static const String storeprofite="${basUrl}office/storeprofite";
  static const String addProperty="${basUrl}office/storePropertyWithImagesOffice";
  static const String getStateForAdd='${basUrl}property/allstates';
  static const String getRegionForAdd='${basUrl}property/allregion';
  static String deleteProperty(int id)=>"${basUrl}office/deletePropertyToOffice/$id";
  static const String addAdverts='${basUrl}wallet/pay-adverts';
  static const String getSubsicription='${basUrl}office/checkSubscriptionWithToken';
  static const String acceptRequest='${basUrl}acceptedPropertyByofficeWihfollowers/';
  static const String rejectRequest='${basUrl}rejectPropertyRequest/';
  static const String logOutOffice='${basUrl}office/logout';
  static const String saveOfficeToken='${basUrl}saveOfficeToken';




}