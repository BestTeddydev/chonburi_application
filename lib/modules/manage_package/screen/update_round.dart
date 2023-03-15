import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/manage_package/bloc/manage_package_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/package_tour_models.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/round_models.dart';
import 'package:chonburi_mobileapp/modules/manage_package/screen/select_activity.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/dialog_loading.dart';
import 'package:chonburi_mobileapp/widget/dialog_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateRound extends StatefulWidget {
  final String token;
  final PackageTourModel packageTourModel;
  const UpdateRound({
    Key? key,
    required this.token,
    required this.packageTourModel,
  }) : super(key: key);

  @override
  State<UpdateRound> createState() => _UpdateRoundState();
}

class _UpdateRoundState extends State<UpdateRound> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<ManagePackageBloc>().add(
          FetchPackageRoundEvent(
            token: widget.token,
            docId: widget.packageTourModel.id,
          ),
        );
    super.initState();
  }

  _addFieldRound(id, dayType) {
    PackageRoundModel roundModel = PackageRoundModel(
      round: '',
      dayType: dayType,
      activities: [],
      id: id,
    );
    context.read<ManagePackageBloc>().add(
          AddRoundPackageEvent(roundModel: roundModel),
        );
  }

  _deletePolicy(PackageRoundModel roundModel) {
    context.read<ManagePackageBloc>().add(
          RemoveRoundPackageEvent(roundModel: roundModel),
        );
  }

  _updateRound(PackageRoundModel roundModel, String value) {
    context
        .read<ManagePackageBloc>()
        .add(UpdateRoundNameEvent(roundModel: roundModel, value: value));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int roundLength = widget.packageTourModel.dayTrips == '1d' ? 1 : 2;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'อัพเดทรอบกิจกรรม',
          style: TextStyle(
            color: AppConstant.colorTextHeader,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(
          color: AppConstant.colorTextHeader,
        ),
      ),
      backgroundColor: AppConstant.backgroudApp,
      body: BlocListener<ManagePackageBloc, ManagePackageState>(
        listener: (context, state) {
          if (state.loading) {
            showDialog(
              context: context,
              builder: (builder) => const DialogLoading(),
            );
          }
          
          if (state.loaded && state.message.isNotEmpty) {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (builder) => DialogSuccess(message: state.message),
            );
          }

          if (state.hasError) {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (builder) => DialogError(message: state.message),
            );
          }
        },
        child: BlocBuilder<ManagePackageBloc, ManagePackageState>(
          builder: (context, state) {
            List<PackageRoundModel> roundModel = state.rounds;
            return SingleChildScrollView(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                behavior: HitTestBehavior.opaque,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: roundLength,
                        itemBuilder: (_, index) => Column(
                          children: [
                            buildCreateOption(
                              'เพิ่มรอบกิจกรรมวันที่ ${index + 1}',
                              _addFieldRound,
                              index + 1,
                            ),
                            buildRoundForm(
                                width, height, roundModel, index + 1),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width * 1,
                        child: ElevatedButton(
                          onPressed: () {
                            PackageTourModel packageTourModel =
                                PackageTourModel(
                              id: widget.packageTourModel.id,
                              packageName: widget.packageTourModel.packageName,
                              dayTrips: widget.packageTourModel.dayTrips,
                              round: roundModel,
                              dayForrent: widget.packageTourModel.dayForrent,
                              packageImage:
                                  widget.packageTourModel.packageImage,
                              mark: widget.packageTourModel.mark,
                              createdBy: widget.packageTourModel.createdBy,
                              price: widget.packageTourModel.price,
                              introduce: widget.packageTourModel.introduce,
                              description: widget.packageTourModel.description,
                              contactAdmin: widget.packageTourModel.contactAdmin,
                            );
                            context.read<ManagePackageBloc>().add(
                                  UpdatePackageEvent(
                                    packageTourModel: packageTourModel,
                                    token: widget.token,
                                  ),
                                );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: AppConstant.bgbutton,
                          ),
                          child: const Text(
                            'อัพเดทรอบกิจกรรม',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Container buildRoundForm(double width, double height,
      List<PackageRoundModel> roundModels, int dayType) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: width * .8,
      height: dayType == 1 ? height * 0.74 : height * .45,
      child: roundModels.isNotEmpty
          ? listViewRound(width, height, roundModels, dayType)
          : null,
    );
  }

  Container buildCreateOption(
    String titleOption,
    Function addFieldOption,
    int dayType,
  ) {
    return Container(
      margin: const EdgeInsets.only(left: 35),
      child: Row(
        children: [
          Text(
            titleOption,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppConstant.colorText,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15),
            child: ElevatedButton(
              onPressed: () {
                addFieldOption(UniqueKey().toString(), dayType);
              },
              style: ElevatedButton.styleFrom(
                primary: AppConstant.bgbutton,
              ),
              child: const Icon(
                Icons.add,
              ),
            ),
          )
        ],
      ),
    );
  }

  ListView listViewRound(double width, double height,
      List<PackageRoundModel> roundModels, int dayType) {
    List<PackageRoundModel> roundWithDayType =
        roundModels.where((element) => element.dayType == dayType).toList();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: roundWithDayType.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildDismissible(
              index,
              width,
              height,
              roundWithDayType[index],
            ),
          ],
        );
      },
    );
  }

  Dismissible buildDismissible(
    int index,
    double width,
    double height,
    PackageRoundModel roundModel,
  ) {
    return Dismissible(
      key: Key(roundModel.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        _deletePolicy(roundModel);
      },
      background: Container(
        color: Colors.red,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: fieldOption(width, height, roundModel),
    );
  }

  SizedBox fieldOption(
    double width,
    double height,
    PackageRoundModel roundModel,
  ) {
    return SizedBox(
      width: width * 0.8,
      child: Column(
        children: [
          TextFormField(
            initialValue: roundModel.round,
            onChanged: (value) {
              _updateRound(roundModel, value);
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "กรุณากรอกรอบกิจกรรม";
              }
              return null;
            },
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              labelText: 'รอบกิจกรรม เช่น 9.00 - 10.00 น.',
              labelStyle: TextStyle(color: Colors.grey[600]),
              prefix: Icon(Icons.add_alarm, color: AppConstant.colorText),
            ),
            style: TextStyle(
              color: AppConstant.colorText,
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(6),
            height: height * 0.32,
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) => SelectActivity(
                    token: widget.token,
                    // activityInRound: roundModel.activities,
                    roundId: roundModel.id,
                  ),
                ),
              ),
              child: Card(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: roundModel.activities.length,
                  itemBuilder: (itemBuilder, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        '- ${roundModel.activities[index].activityName}',
                        style: TextStyle(
                          color: AppConstant.colorText,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Divider(
            color: AppConstant.themeApp,
            height: 20,
            thickness: 3.0,
          )
        ],
      ),
    );
  }
}
