import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/manage_package/bloc/manage_package_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/package_tour_models.dart';
import 'package:chonburi_mobileapp/modules/manage_package/screen/edit_package.dart';
import 'package:chonburi_mobileapp/modules/manage_package/screen/update_round.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/dialog_loading.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PackageListAdmin extends StatefulWidget {
  final String token;
  const PackageListAdmin({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<PackageListAdmin> createState() => _PackageListAdminState();
}

class _PackageListAdminState extends State<PackageListAdmin> {
  @override
  void initState() {
    context
        .read<ManagePackageBloc>()
        .add(FetchPackageEvent(token: widget.token));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocListener<ManagePackageBloc, ManagePackageState>(
      listener: (context, state) {
        if (state.loading) {
          showDialog(
            context: context,
            builder: (builder) => const DialogLoading(),
          );
        }
        if (state.loaded) {
          Navigator.pop(context);
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
          List<PackageTourModel> packages = state.packages;
          return Scaffold(
            backgroundColor: AppConstant.backgroudApp,
            body: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: packages.length,
                itemBuilder: (context, index) {
                  return Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => EditPackage(
                                packageModel: packages[index],
                                token: widget.token,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          margin: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            left: width * 0.12,
                            right: width * 0.12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.16,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(14),
                                    topRight: Radius.circular(14),
                                  ),
                                  child: ShowImageNetwork(
                                    pathImage: packages[index].packageImage,
                                    boxFit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      packages[index].packageName,
                                      softWrap: true,
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: AppConstant.colorTextHeader,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Card(
                                      color: AppConstant.bgHasTaged,
                                      margin: const EdgeInsets.only(
                                        left: 14,
                                        bottom: 10,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          AppConstant.tripsType[
                                              packages[index].dayTrips]!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            // fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: width * 0.11, top: 8),
                        decoration: BoxDecoration(
                          color: AppConstant.backgroudApp,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => UpdateRound(
                                  token: widget.token,
                                  packageTourModel: packages[index],
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.add_alarm,
                            color: AppConstant.colorText,
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
