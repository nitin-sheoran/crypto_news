import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_wave/news/model/news_model.dart';

class NewsApiService {
  final String apiKey = '0a7bdfe011a74df6b521cbddba406b33';

  Future<List<Articles>> fetchCollegeNews() async {
    final response = await http.get(
      Uri.parse('https://newsapi.org/v2/everything?q=all&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['articles'];
      List<Articles> articles =
          data.map((item) => Articles.fromJson(item)).toList();
      return articles;
    } else {
      throw Exception('Error');
    }
  }
}
// onTap: () {
// if (counsellorSessionProvider
//     .details
//     .sessions![index]
//     .sessionAvailableSlots! <=
// 0) {
// startPgTransaction(
// counsellorSessionProvider
//     .details
//     .sessions![
// index]
//     .id,
// counsellorSessionProvider
//     .details
//     .sessions![
// index]
//     .sessionDate,
// counsellorSessionProvider
//     .details
//     .sessions![
// index]
//     .sessionPrice);
// } else if (counsellorSessionProvider
//     .details
//     .sessions![index]
//     .sessionAvailableSlots! <=
// counsellorSessionProvider
//     .details
//     .sessions![index]
//     .sessionAvailableSlots!) {
// EasyLoading.show(
// status:
// "Loading...",
// dismissOnTap:
// false);
// ApiService.sessionBooked(
// counsellorSessionProvider
//     .details
//     .sessions![
// index]
//     .id!)
//     .then((value) {
// if (value[
// "message"] ==
// "Counseling session booked successfully") {
// EasyLoading.showToast(
// value[
// "message"],
// toastPosition:
// EasyLoadingToastPosition
//     .bottom);
// context
//     .read<
// CounsellorDetailsProvider>()
//     .fetchCounsellor_session(
// id: widget
//     .id);
// var date = Jiffy.parse(
// counsellorSessionProvider
//     .details
//     .sessions![
// index]
//     .sessionDate!)
//     .format(
// pattern:
// "yyyy-M-d");
// context
//     .read<
// CounsellorDetailsProvider>()
//     .fetchCounsellor_session(
// id: widget
//     .id,
// sessionType:
// "Group",
// date: date);
// setState(() {});
// } else {
// EasyLoading.showToast(
// value["error"],
// toastPosition:
// EasyLoadingToastPosition
//     .bottom);
// }
// });
// } else {
// EasyLoading.showToast(
// 'Slot is not available',
// toastPosition:
// EasyLoadingToastPosition
//     .bottom);
// }
// },