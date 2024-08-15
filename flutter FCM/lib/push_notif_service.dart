import 'dart:convert';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;

class PushNotificationService {
  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
     ""
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/firebase.messaging",
      // "https://www.googleapis.com/auth/firebase.database",
    ];

    final accountCredentials = auth.ServiceAccountCredentials.fromJson(serviceAccountJson);
    final client = await auth.clientViaServiceAccount(accountCredentials, scopes);

    // Get access token
    final credentials = await client.credentials;
    client.close();
    return credentials.accessToken.data;
  }

  static Future<void> sendNotificationToSelectedID(String deviceToken, String title, String body, String userID) async {
    final String serverAccessTokenKey = await getAccessToken();
    String endpointFirebaseCloudMessaging = "https://fcm.googleapis.com/v1/projects/invoiceai-273a1/messages:send";

    final Map<String, dynamic> message = {
      'message': {
        'token': deviceToken,
        'notification': {
          'title': title,
          'body': body,
        },
        'data': {
          'userID': userID,
        }
      }
    };

        final response = await http.post(
      Uri.parse(endpointFirebaseCloudMessaging),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverAccessTokenKey',
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print("Notification sent successfully");
    } else {
      print("Error sending notification, ${response.statusCode}: ${response.body}");
    }
  }
}


