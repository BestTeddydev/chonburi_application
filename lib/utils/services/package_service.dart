import 'dart:developer';
import 'dart:io';

import 'package:chonburi_mobileapp/constants/api_path.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/package_tour_models.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/round_models.dart';
import 'package:chonburi_mobileapp/utils/helper/dio.dart';
import 'package:dio/dio.dart';

class PackageService {
  static Future<List<PackageTourModel>> fetchsPackages() async {
    try {
      Response response = await DioService.dioGet('/guest/packages');
      List<PackageTourModel> packages = [];
      for (var package in response.data) {
        PackageTourModel packageModel = PackageTourModel.fromMapBuyer(package);
        packages.add(packageModel);
      }
      return packages;
    } catch (e) {
      return [];
    }
  }

  static Future<PackageTourModel> fetchPackage(String packageID) async {
    Response response = await Dio().get(
      '${APIRoute.host}/guest/packages/$packageID',
      options: Options(
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
      ),
    );
    var data = response.data;
    PackageTourModel packageModel = PackageTourModel.fromMap(data);
    return packageModel;
  }

  static Future<List<PackageTourModel>> getPackages(String token) async {
    Response response = await DioService.dioGetAuthen('/packages', token);
    List<PackageTourModel> packages = [];
    for (var repPackage in response.data) {
      PackageTourModel packageModel = PackageTourModel.fromMap(repPackage);
      packages.add(packageModel);
    }
    return packages;
  }

  static Future<void> deletePackage(String token, String docId) async {
    await DioService.dioDelete('/packages/$docId', token);
  }

  static Future<PackageTourModel> createPackage(
      String token, PackageTourModel packageTourModel) async {
    Response response = await DioService.dioPostAuthen(
        '/packages', token, packageTourModel.toMap());
    PackageTourModel package = PackageTourModel.fromMap(response.data);
    return package;
  }

  static Future<void> updatePackage(
      String token, PackageTourModel packageTourModel) async {
    await DioService.dioPut(
      '/packages/${packageTourModel.id}',
      token,
      packageTourModel.toMap(),
    );
  }

  static Future<List<PackageRoundModel>> fetchRound(
      String token, String docId) async {
    List<PackageRoundModel> rounds = [];
    Response response =
        await DioService.dioGetAuthen('/packages/round/$docId', token);

    Map<String, dynamic> data = Map<String, dynamic>.from(response.data);

    for (var round in data['round']) {
      PackageRoundModel roundModel = PackageRoundModel.fromMap(round);
      rounds.add(roundModel);
    }
    return rounds;
  }
}
