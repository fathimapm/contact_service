import 'package:url_launcher/url_launcher.dart';

class CommonActions {
  static void makeCall(String mobNo){
    final Uri callLauncherUri =Uri(
        scheme:'tel',
            path: mobNo
    );
launchUrl(callLauncherUri);
  }
  static void sendSms(String mobNo,String content){
    final Uri smsLaunchUri = Uri(
      scheme: 'sms',
      path: mobNo,
      queryParameters: <String, String>{
        'body': Uri.encodeComponent(content),
      },
    );
    launchUrl(smsLaunchUri);
  }
  static void sendEmail(String emailAddress,String subject,String body ){
   final Uri emailLauncherUri= Uri(
   scheme:'mailto',
  path:emailAddress,
       queryParameters: <String, String>{
         'subject': subject,
     'body': Uri.encodeComponent(body),
   }
   );
   launchUrl(emailLauncherUri);
  }
  static void launchWebsite(String webAddress){
    final Uri _url = Uri.parse(webAddress);
    launchUrl(_url);
  }

}
