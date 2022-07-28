import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_activity/models/activity_model.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/package_tour_models.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/round_models.dart';
import 'package:chonburi_mobileapp/utils/services/order_package_service.dart';
import 'package:chonburi_mobileapp/utils/services/package_service.dart';
import 'package:chonburi_mobileapp/utils/services/upload_file_service.dart';
import 'package:equatable/equatable.dart';

part 'manage_package_event.dart';
part 'manage_package_state.dart';

class ManagePackageBloc extends Bloc<ManagePackageEvent, ManagePackageState> {
  ManagePackageBloc() : super(ManagePackageState(packages: const [])) {
    on<FetchPackageEvent>(_getPackages);
    on<DeletePackageEvent>(_deletePackage);
    on<SelectImageEvent>(_selectImage);
    on<SelectDayForrent>(_selectDayForrent);
    on<ChangeDayTripType>(_changeDayType);
    on<AddDayEvent>(_addDays);
    on<RemoveDayEvent>(_removeDays);
    on<CreatePackageEvent>(_createPackage);
    on<UpdatePackageEvent>(_updatePackage);
    on<SetDataPackageEvent>(_setDataPackageTour);
    on<FetchPackageRoundEvent>(_fetchRoundPackage);
    on<AddRoundPackageEvent>(_addRound);
    on<RemoveRoundPackageEvent>(_removeRound);
    on<UpdateRoundNameEvent>(_updateRoundName);
    on<SelectActivityEvent>(_selectActivity);
    on<RemoveActivityEvent>(_removeActivity);
    on<SelectImagePaymentEvent>(_selectImagePayment);
    on<ChangeTypePaymentEvent>(_changeTypePayment);
  }
  void _getPackages(
    FetchPackageEvent event,
    Emitter<ManagePackageState> emitter,
  ) async {
    try {
      emitter(ManagePackageState(packages: state.packages, loading: true));
      List<PackageTourModel> packagesData =
          await PackageService.getPackages(event.token);
      emitter(
        ManagePackageState(
            packages: packagesData, loaded: true, loading: false),
      );
    } catch (e) {
      log(e.toString());
      emitter(ManagePackageState(
          packages: state.packages,
          hasError: true,
          message: 'เกิดเหตุขัดข้อง ขออภัยในความไม่สะดวก'));
    }
  }

  void _createPackage(
      CreatePackageEvent event, Emitter<ManagePackageState> emitter) async {
    try {
      emitter(
        ManagePackageState(
          packages: state.packages,
          loading: true,
          dayForrents: state.dayForrents,
          dayType: state.dayType,
          packageImage: state.packageImage,
          imagePayment: state.imagePayment,
          typePayment: state.typePayment,
        ),
      );
      if (state.packageImage.path.isNotEmpty) {
        String fileName =
            await UploadService.singleFile(state.packageImage.path);
        event.packageTourModel.packageImage = fileName;
      }
      if (state.imagePayment.path.isNotEmpty) {
        String fileNamePayment =
            await UploadService.singleFile(state.imagePayment.path);
        event.packageTourModel.imagePayment = fileNamePayment;
      }
      try {
        PackageTourModel packageTour = await PackageService.createPackage(
            event.token, event.packageTourModel);
        emitter(
          ManagePackageState(
            packages: List.from(state.packages)..add(packageTour),
            loading: false,
            loaded: true,
            dayForrents: state.dayForrents,
            dayType: state.dayType,
            packageImage: state.packageImage,
            message: 'บันทึกข้อมูลเรียบร้อย',
            imagePayment: state.imagePayment,
            typePayment: state.typePayment,
          ),
        );
      } catch (e) {
        emitter(
          ManagePackageState(
            packages: state.packages,
            loading: false,
            hasError: true,
            dayForrents: state.dayForrents,
            dayType: state.dayType,
            packageImage: state.packageImage,
            message: 'บันทึกข้อมูลล้มเหลว',
          ),
        );
      }
    } catch (e) {
      emitter(
        ManagePackageState(
          packages: state.packages,
          loading: false,
          hasError: true,
          dayForrents: state.dayForrents,
          dayType: state.dayType,
          packageImage: state.packageImage,
          message: 'อัพโหลดรูปภาพล้มเหลว',
        ),
      );
    }
  }

  void _updatePackage(
      UpdatePackageEvent event, Emitter<ManagePackageState> emitter) async {
    try {
      emitter(
        ManagePackageState(
          packages: state.packages,
          loading: true,
          dayForrents: state.dayForrents,
          dayType: state.dayType,
          packageImage: state.packageImage,
          imagePayment: state.imagePayment,
          typePayment: state.typePayment,
          rounds: state.rounds,
        ),
      );
      if (state.packageImage.path.isNotEmpty) {
        String fileName =
            await UploadService.singleFile(state.packageImage.path);
        event.packageTourModel.packageImage = fileName;
      }
      if (state.imagePayment.path.isNotEmpty) {
        String fileNamePayment =
            await UploadService.singleFile(state.imagePayment.path);
        event.packageTourModel.imagePayment = fileNamePayment;
      }
      await PackageService.updatePackage(event.token, event.packageTourModel);
      int index = List<PackageTourModel>.from(state.packages).indexWhere(
        (element) => element.id == event.packageTourModel.id,
      );
      List<PackageTourModel> allPackages =
          List<PackageTourModel>.from(state.packages)
            ..removeWhere(
              (element) => element.id == event.packageTourModel.id,
            );
      allPackages.insert(index, event.packageTourModel);
      emitter(
        ManagePackageState(
          packages: allPackages,
          loading: false,
          loaded: true,
          dayForrents: state.dayForrents,
          dayType: state.dayType,
          packageImage: state.packageImage,
          imagePayment: state.imagePayment,
          typePayment: state.typePayment,
          message: 'แก้ไขข้อมูลเรียบร้อย',
          rounds: state.rounds,
        ),
      );
    } catch (e) {
      emitter(
        ManagePackageState(
          packages: state.packages,
          loading: false,
          hasError: true,
          dayForrents: state.dayForrents,
          dayType: state.dayType,
          packageImage: state.packageImage,
          imagePayment: state.imagePayment,
          typePayment: state.typePayment,
          message: 'แก้ไขข้อมูลล้มเหลว',
          rounds: state.rounds,
        ),
      );
    }
  }

  void _deletePackage(
      DeletePackageEvent event, Emitter<ManagePackageState> emitter) async {
    try {
      emitter(ManagePackageState(packages: state.packages, loading: true));
      await PackageService.deletePackage(event.token, event.docId);
      emitter(
        ManagePackageState(
          loaded: true,
          loading: false,
          message: 'ลบข้อมูลเรียบร้อย',
          packages: List.from(state.packages)
            ..removeWhere(
              (element) => element.id == event.docId,
            ),
        ),
      );
    } catch (e) {
      emitter(ManagePackageState(
          packages: state.packages,
          hasError: true,
          message: 'ลบข้อมูลล้มเหลว'));
    }
  }

  void _selectImage(
    SelectImageEvent event,
    Emitter<ManagePackageState> emitter,
  ) {
    emitter(
      ManagePackageState(
        packages: state.packages,
        packageImage: event.image,
        dayForrents: state.dayForrents,
        dayType: state.dayType,
        imagePayment: state.imagePayment,
        typePayment: state.typePayment,
      ),
    );
  }

  void _selectImagePayment(
    SelectImagePaymentEvent event,
    Emitter<ManagePackageState> emitter,
  ) {
    emitter(
      ManagePackageState(
        packages: state.packages,
        packageImage: state.packageImage,
        dayForrents: state.dayForrents,
        dayType: state.dayType,
        imagePayment: event.image,
        typePayment: state.typePayment,
      ),
    );
  }

  void _selectDayForrent(
    SelectDayForrent event,
    Emitter<ManagePackageState> emitter,
  ) {
    emitter(
      ManagePackageState(
        packages: state.packages,
        packageImage: state.packageImage,
        dayForrents: List.from(state.dayForrents)..add(event.day),
        dayType: state.dayType,
        imagePayment: state.imagePayment,
        typePayment: state.typePayment,
      ),
    );
  }

  void _changeDayType(
      ChangeDayTripType event, Emitter<ManagePackageState> emitter) {
    emitter(
      ManagePackageState(
        packages: state.packages,
        packageImage: state.packageImage,
        dayForrents: state.dayForrents,
        dayType: event.dayType,
        imagePayment: state.imagePayment,
        typePayment: state.typePayment,
      ),
    );
  }

  void _changeTypePayment(
      ChangeTypePaymentEvent event, Emitter<ManagePackageState> emitter) {
    emitter(
      ManagePackageState(
        packages: state.packages,
        packageImage: state.packageImage,
        dayForrents: state.dayForrents,
        dayType: state.dayType,
        imagePayment: state.imagePayment,
        typePayment: event.typePayment,
      ),
    );
  }

  void _addDays(AddDayEvent event, Emitter<ManagePackageState> emitter) {
    List<String> allDays = List.from(state.dayForrents)..add(event.day);
    emitter(
      ManagePackageState(
        packages: state.packages,
        packageImage: state.packageImage,
        dayForrents: allDays,
        dayType: state.dayType,
        imagePayment: state.imagePayment,
        typePayment: state.typePayment,
      ),
    );
  }

  void _removeDays(RemoveDayEvent event, Emitter<ManagePackageState> emitter) {
    emitter(
      ManagePackageState(
        packages: state.packages,
        packageImage: state.packageImage,
        dayForrents: List.from(state.dayForrents)..remove(event.day),
        dayType: state.dayType,
        imagePayment: state.imagePayment,
        typePayment: state.typePayment,
      ),
    );
  }

  void _setDataPackageTour(
      SetDataPackageEvent event, Emitter<ManagePackageState> emitter) {
    emitter(
      ManagePackageState(
        packages: state.packages,
        dayForrents: event.dayForrents,
        dayType: event.tripsType,
        packageImage: state.packageImage,
        typePayment: event.typePayment,
      ),
    );
  }

  void _fetchRoundPackage(
    FetchPackageRoundEvent event,
    Emitter<ManagePackageState> emitter,
  ) async {
    try {
      emitter(
        ManagePackageState(
          packages: state.packages,
          dayForrents: state.dayForrents,
          dayType: state.dayType,
          rounds: state.rounds,
        ),
      );
      List<PackageRoundModel> rounds = await PackageService.fetchRound(
        event.token,
        event.docId,
      );

      emitter(
        ManagePackageState(
          packages: state.packages,
          dayForrents: state.dayForrents,
          dayType: state.dayType,
          rounds: rounds,
        ),
      );
    } catch (e) {
      log('$e');
      emitter(
        ManagePackageState(
          packages: state.packages,
          dayForrents: state.dayForrents,
          dayType: state.dayType,
          hasError: true,
          message: 'เกิดเหตุขัดข้อง ขออภัยในความไม่สะดวกd',
          rounds: state.rounds,
        ),
      );
    }
  }

  void _addRound(
    AddRoundPackageEvent event,
    Emitter<ManagePackageState> emitter,
  ) {
    emitter(
      ManagePackageState(
        packages: state.packages,
        dayForrents: state.dayForrents,
        dayType: state.dayType,
        rounds: List.from(state.rounds)..add(event.roundModel),
      ),
    );
  }

  void _removeRound(
    RemoveRoundPackageEvent event,
    Emitter<ManagePackageState> emitter,
  ) {
    emitter(
      ManagePackageState(
        packages: state.packages,
        dayForrents: state.dayForrents,
        dayType: state.dayType,
        rounds: List.from(state.rounds)..remove(event.roundModel),
      ),
    );
  }

  void _updateRoundName(
    UpdateRoundNameEvent event,
    Emitter<ManagePackageState> emitter,
  ) {
    int index = List<PackageRoundModel>.from(state.rounds).indexWhere(
      (element) => element.id == event.roundModel.id,
    );
    List<PackageRoundModel> allRounds =
        List<PackageRoundModel>.from(state.rounds)
          ..removeWhere(
            (element) => element.id == event.roundModel.id,
          );
    allRounds.insert(index, event.roundModel.copyWith(round: event.value));
    emitter(
      ManagePackageState(
        packages: state.packages,
        dayForrents: state.dayForrents,
        dayType: state.dayType,
        rounds: allRounds,
      ),
    );
  }

  void _selectActivity(
      SelectActivityEvent event, Emitter<ManagePackageState> emitter) {
    int index = List<PackageRoundModel>.from(state.rounds).indexWhere(
      (element) => element.id == event.roundId,
    );
    List<PackageRoundModel> allRounds =
        List<PackageRoundModel>.from(state.rounds)
          ..removeWhere(
            (element) => element.id == event.roundId,
          );
    allRounds.insert(
      index,
      state.rounds[index].copyWith(
        activities: List.from(state.rounds[index].activities)
          ..add(event.activityModel),
      ),
    );
    emitter(
      ManagePackageState(
        packages: state.packages,
        dayForrents: state.dayForrents,
        dayType: state.dayType,
        rounds: allRounds,
      ),
    );
  }

  void _removeActivity(
      RemoveActivityEvent event, Emitter<ManagePackageState> emitter) {
    int index = List<PackageRoundModel>.from(state.rounds).indexWhere(
      (element) => element.id == event.roundId,
    );
    List<PackageRoundModel> allRounds =
        List<PackageRoundModel>.from(state.rounds)
          ..removeWhere(
            (element) => element.id == event.roundId,
          );
    allRounds.insert(
      index,
      state.rounds[index].copyWith(
        activities: List.from(state.rounds[index].activities)
          ..removeWhere((element) => element.id == event.activityModel.id),
      ),
    );
    emitter(
      ManagePackageState(
        packages: state.packages,
        dayForrents: state.dayForrents,
        dayType: state.dayType,
        rounds: allRounds,
      ),
    );
  }

  
}
