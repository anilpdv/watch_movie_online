import 'package:http/http.dart' as http;

Future<String> getPublicIP() async {
  try {
    const url = 'https://api64.ipify.org';
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // The response body is the IP in plain text, so just
      // return it as-is.
      print(response.body);
      return response.body;
    } else {
      // The request failed with a non-200 code
      // The ipify.org API has a lot of guaranteed uptime
      // promises, so this shouldn't ever actually happen.
      print(response.statusCode);
      print(response.body);
      return null;
    }
  } catch (e) {
    // Request failed due to an error, most likely because
    // the phone isn't connected to the internet.
    print(e);
    return null;
  }
}
