import 'dart:convert';
import 'dart:io';
import 'ExceptionBase.dart';
import 'package:http/http.dart' as http;

class APIBase {
  /// Base URL
  final String _baseUrl = "https://reqres.in/api/";

  /// Fetch User using get call. This is the single common method for all get calls
  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      /// Store the response from the server
      final response = await http.get(_baseUrl + url);
    

      /// decode the response using dart:convert lib
      responseJson = _decodeResponse(response);
      
    } on SocketException {

      /// throw no Internet connection Error.
      throw FetchDataException('No Internet connection');
    }
    /// return the parsed the response
    return responseJson;
  }

  dynamic _decodeResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        //When status code is 200. 
        /// Parse the JSON using json.decode 
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        //return decoded json
        return responseJson;
        
      case 400:
        /// When status code is 400.
        /// Throw BadRequest Exceiption
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        /// When status code is 401 and 403.
        /// Throw BadRequest UnauthorisedException
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
      /// When status code is 401 and 403.
      /// Throw BadRequest UnauthorisedException
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
