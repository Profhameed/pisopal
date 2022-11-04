import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:inbestment/data/network/user_post_model.dart';
import 'package:inbestment/data/network/user_success_response_model.dart';
import 'package:inbestment/widgets/dialog_helper.dart';

class Network {
  Network._privateConstructor();

  static final Network _instance = Network._privateConstructor();

  factory Network() {
    return _instance;
  }

  final String url = "https://inbestment.itevolvers.com/api/save_user_details";
  final String apiToken = "@m1yi4nqD04";

  Future<String?> postUserPostModel(UserPostModel userPostModel) async {
    var header = {'api-token': apiToken};
    var payload = userPostModel.toMap();

    // if (kDebugMode) {
    //   print(payload);
    //   // return null;
    // }
    try {
      DialogHelper.showLoading("submitting data...");
      var response = await post(Uri.parse(url), headers: header, body: payload)
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        UserSuccessResponseModel resModel = UserSuccessResponseModel.fromJson(responseJson);
        if (resModel.success == true) {
          DialogHelper.hideLoading();
          await DialogHelper.showMyDialog(title: 'success', description: resModel.description);
          return 'pass';

          ///if response success is false
        } else {
          DialogHelper.hideLoading();
          await DialogHelper.showMyDialog(
              // description: "Error occurred while submitting the data. please try again");
              description: response.body);
          return null;
        }

        /// if response status is not 200
      } else {
        DialogHelper.hideLoading();
        await DialogHelper.showMyDialog(
            // description: "Error occurred while submitting the data. please try again");
            description: response.body);
        return null;
      }
    } on SocketException {
      DialogHelper.hideLoading();
      await DialogHelper.showMyDialog(description: "No Internet Connection");
      return null;
    } on TimeoutException {
      DialogHelper.hideLoading();
      await DialogHelper.showMyDialog(
          description: "Api not responded on time. please check your internet connection");
      return null;
    } catch (e) {
      DialogHelper.hideLoading();
      await DialogHelper.showMyDialog(description: e.toString());
      return null;
    }
  }
}
