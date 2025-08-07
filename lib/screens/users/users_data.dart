  import 'package:flutter/material.dart';
  import 'package:multi_dropdown/models/value_item.dart';
  import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
  import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
  import 'package:sislimoda_admin_dashboard/controllers/general.dart';
  import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
  import 'package:sislimoda_admin_dashboard/main.dart';
  import 'package:sislimoda_admin_dashboard/models/general/option_set_model.dart';
import 'package:sislimoda_admin_dashboard/models/user/get_users_model.dart';
  import 'package:sislimoda_admin_dashboard/models/users/DashboardUserModel.dart';
  import 'package:sislimoda_admin_dashboard/models/users/InfluencerModel.dart';
  import 'package:sislimoda_admin_dashboard/screens/categories/widgets/add_category.dart';
  import 'package:sislimoda_admin_dashboard/screens/users/widgets/add_dashboard_user.dart';
  import 'package:sislimoda_admin_dashboard/services/app_services.dart';
  import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
  import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
  import '../../models/users/MobileUserModel.dart';

  mixin UsersData {
      Loading loading = Loading();

    List<ValueItem> status = [];
    GenericCubit<List<ValueItem>> statusCubit = GenericCubit<List<ValueItem>>();

    List<InfluencerModel> influencers = [];
    GenericCubit<List<InfluencerModel>> influencersCubit = GenericCubit<List<InfluencerModel>>();

    List<DashboardUserModel> dashboardUsers = [];
    GenericCubit<List<DashboardUserModel>> dashboardUsersCubit = GenericCubit<List<DashboardUserModel>>();

   GenericCubit<List<MobileUserModel>> mobileUsersCubit =
      GenericCubit<List<MobileUserModel>>();

    getVendorStatus() async {
      var result = await GeneralController.getStatusByName(name: 'InfluencerStatus');
      result.fold((success) {
        optionSetModelFromJson(success).first.optionSetItems?.forEach((element) {
          status.add(ValueItem(
              label: isArabic ? element?.nameAr ?? '' : element?.nameEn ?? '',
              value: element?.id));
        });
        statusCubit.update(data: status);
      }, (fail) {
        showErrorMessage(message: fail.message);
      });
    }

  addDashboardUser() {
      showDialog(
          context: currentContext,
          barrierColor: AppColors.barrierColor,
          builder: (ctx) {
            return AddDashboardUser(
              refresh: getUsers,
              operationType: OperationType.add,
              userModel: DashboardUserModel(),
            );
          });
    }
    
  addInfluencer({
    required String name,
    required String email,
    required String phone,
    required int numberOfProduct,
    String? password,
  }) async {
    try {
      Map<String, dynamic> body = {
        "name": name,
        "email": email,
        "phone": phone,
        "numberOfProduct": numberOfProduct,
        if (password != null && password.isNotEmpty) "password": password,
      };
      var result = await AppService.callService(
        actionType: ActionType.post,
        apiName: 'api/Influencer/Add',
        body: body,
      );

      result.fold((success) {
        showSuccessMessage(message: "تم إضافة المؤثر بنجاح");
        getInfluencers(); // تحديث القائمة بعد الإضافة
      }, (fail) {
        showErrorMessage(message: fail.message);
      });
    } catch (e) {
      showErrorMessage(message: e.toString());
    }
  }
    getUsers() async {
      try {
        var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/User/GetAll',
          body: null,
        );
        result.fold((success) {
          List<DashboardUserModel> users = DashboardUserModelFromJson(success);
          dashboardUsersCubit.update(data: users);
        }, (fail) {
          showErrorMessage(message: fail.message);
        });
      } catch (error) {
        showErrorMessage(message: error.toString());
      }
    }

    getInfluencers() async {
      try {
        var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Influencer/GetAll',
          body: null,
        );
        result.fold((success) {
          influencers = InfluencerModelFromJson(success);
          influencersCubit.update(data: influencers);
        }, (fail) {
          showErrorMessage(message: fail.message);
        });
      } catch (error) {
        showErrorMessage(message: error.toString());
      }
    }

    deleteInfluencer(String influencerId) async {
      try {
        var result = await AppService.callService(
          actionType: ActionType.post,
          apiName: 'api/Influencer/Delete?Id=$influencerId',
          body: null,
        );
        result.fold((success) {
          showSuccessMessage(message: "تم حذف المؤثر");
          getInfluencers();
        }, (fail) {
          showErrorMessage(message: fail.message);
        });
      } catch (e) {
        showErrorMessage(message: e.toString());
      }
    }

    updateInfluencer(InfluencerModel influencer, {required InfluencerModel user}) async {
      try {
        var result = await AppService.callService(
          actionType: ActionType.post,
          apiName: 'api/Influencer/Update',
          body: influencer.toJson(),
        );
        result.fold((success) {
          showSuccessMessage(message: "تم تعديل بيانات المؤثر");
          getInfluencers();
        }, (fail) {
          showErrorMessage(message: fail.message);
        });
      } catch (e) {
        showErrorMessage(message: e.toString());
      }
    }

    // جلب مستخدمي الموبايل
    getMobileUsers() async {
      try {
        var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Auth/GetAllUser',
          body: null,
        );
        result.fold((success) {
       List<MobileUserModel> users = MobileUserModelFromJson(success);
          mobileUsersCubit.update(data: users);
        }, (fail) {
          showErrorMessage(message: fail.message);
        });
      } catch (error) {
        showErrorMessage(message: error.toString());
      }
    }

    // حذف مستخدم (DashboardUser)
    deleteUser(String userId) async {
      try {
        var result = await AppService.callService(
          actionType: ActionType.post,
          apiName: 'api/User/Delete?Id=$userId', 
      body: null, 

        );  
        result.fold((success) {
          showSuccessMessage(message: "تم حذف المستخدم");
          getUsers();
        }, (fail) {
          showErrorMessage(message: fail.message);
        });
      } catch (e) {
        showErrorMessage(message: e.toString());
      }
    }

    // // تحديث مستخدم (DashboardUser)
    // updateUser(DashboardUserModel user) async {
    //   try {
    //     var result = await AppService.callService(
    //       actionType: ActionType.post,
    //       apiName: 'api/User/Update',
    //       body: user.toJson(),
    //     );
    //     result.fold((success) {
    //       showSuccessMessage(message: "تم تعديل بيانات المستخدم");
    //       getUsers();
    //     }, (fail) {
    //       showErrorMessage(message: fail.message);
    //     });
    //   } catch (e) {
    //     showErrorMessage(message: e.toString());
    //   }
    // }

      updateUser({required DashboardUserModel user}) {
      showDialog(
          context: currentContext,
          barrierColor: AppColors.barrierColor,
          builder: (ctx) {
            return AddDashboardUser(
              refresh: getUsers,
              operationType: OperationType.update,
              userModel: user,
            );
          });
    }
      convertUserToInfluencer({required String userId}) async {
      loading.show;
      try {
        var result = await AppService.callService(
            actionType: ActionType.post,
            apiName: 'api/Auth/ConvertToInf?UserId=$userId',
            body: null);

        result.fold((success) async {
          await getInfluencers();
          await getMobileUsers();
          showSuccessMessage(
              message: isArabic
                  ? "تم التحويل الي مؤثر"
                  : "Converted to influencer success");
        }, (fail) {
          showErrorMessage(message: fail.message);
        });
      } catch (error) {}
      loading.hide;
    }

  }
















  /*
  import 'dart:convert';

  import 'package:flutter/material.dart';
  import 'package:multi_dropdown/multiselect_dropdown.dart';
  import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
  import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
  import 'package:sislimoda_admin_dashboard/controllers/general.dart';
  import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
  import 'package:sislimoda_admin_dashboard/main.dart';
  import 'package:sislimoda_admin_dashboard/models/general/option_set_model.dart';
  import 'package:sislimoda_admin_dashboard/models/user/get_users_model.dart';
  import 'package:sislimoda_admin_dashboard/models/user/influencer_model.dart';
  import 'package:sislimoda_admin_dashboard/screens/categories/widgets/add_category.dart';
  import 'package:sislimoda_admin_dashboard/screens/users/widgets/add_dashboard_user.dart';
  import 'package:sislimoda_admin_dashboard/screens/users/widgets/add_influencer.dart';
  import 'package:sislimoda_admin_dashboard/services/app_services.dart';
  import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
  import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

  mixin UsersData {
    Loading loading = Loading();

    GenericCubit<List<UserModel>> dashboardUsersCubit =
        GenericCubit<List<UserModel>>();
    GenericCubit<List<UserModel>> mobileUsersCubit =
        GenericCubit<List<UserModel>>();

    GenericCubit<List<InfluencerModel>> influencersCubit =
        GenericCubit<List<InfluencerModel>>();

    getUsers() async {
      loading.show;
      try {
        var result = await AppService.callService(
            actionType: ActionType.get, apiName: 'api/User/GetAll', body: null);

        result.fold((success) {
          dashboardUsersCubit.update(data: userModelFromJson(success));
        }, (fail) {
          showErrorMessage(message: fail.message);
        });
      } catch (error) {}
      loading.hide;
    }

    convertUserToInfluencer({required String userId}) async {
      loading.show;
      try {
        var result = await AppService.callService(
            actionType: ActionType.post,
            apiName: 'api/Auth/ConvertToInf?UserId=$userId',
            body: null);

        result.fold((success) async {
          await getInfluencers();
          await getMobileUsers();
          showSuccessMessage(
              message: isArabic
                  ? "تم التحويل الي مؤثر"
                  : "Converted to influencer success");
        }, (fail) {
          showErrorMessage(message: fail.message);
        });
      } catch (error) {}
      loading.hide;
    }

    getMobileUsers() async {
      loading.show;
      try {
        var result = await AppService.callService(
            actionType: ActionType.get,
            apiName: 'api/Auth/GetAllUser',
            body: null);

        result.fold((success) {
          List<UserModel> users = userModelFromJson(success);
          // users.removeWhere((element) =>
          //     (element.isSupperAdmin == true) ||
          //     (element.appUser?.isAdmin == true) ||
          //     (element.appUser?.isInfluencer == true));
          mobileUsersCubit.update(data: users);
        }, (fail) {
          showErrorMessage(message: fail.message);
        });
      } catch (error) {}
      loading.hide;
    }

    getInfluencers() async {
      loading.show;
      try {
        var result = await AppService.callService(
            actionType: ActionType.get,
            apiName: 'api/Influencer/GetAll',
            body: null);

        result.fold((success) {
          influencersCubit.update(data: influencerModelFromJson(success));
        }, (fail) {
          showErrorMessage(message: fail.message);
        });
      } catch (error) {}
      loading.hide;
    }

    List<ValueItem> status = [];
    GenericCubit<List<ValueItem>> statusCubit = GenericCubit<List<ValueItem>>();

    getVendorStatus() async {
      var result =
          await GeneralController.getStatusByName(name: 'InfluencerStatus');
      result.fold((success) {
        optionSetModelFromJson(success).first.optionSetItems?.forEach((element) {
          status.add(ValueItem(
              label: isArabic ? element?.nameAr ?? '' : element?.nameEn ?? '',
              value: element?.id));
        });
        statusCubit.update(data: status);
      }, (fail) {
        showErrorMessage(message: fail.message);
      });
    }

    deleteDashboardUser({required String userId}) async {
      loading.show;
      try {
        var result = await AppService.callService(
            actionType: ActionType.post,
            apiName: 'api/User/Delete?Id=$userId',
            body: null);

        result.fold((success) {
          showSuccessMessage(
              message: isArabic
                  ? 'تم حذف المستخدم بنجاح'
                  : 'User deleted successfully');
          getUsers();
        }, (fail) {
          showErrorMessage(message: fail.message);
          loading.hide;
        });
      } catch (error) {
        loading.hide;
      }
    }

    deleteInfluencer({required String userId}) async {
      loading.show;
      try {
        var result = await AppService.callService(
            actionType: ActionType.post,
            apiName: 'api/Influencer/Delete?Id=$userId',
            body: null);

        result.fold((success) {
          showSuccessMessage(
              message: isArabic
                  ? 'تم حذف المستخدم بنجاح'
                  : 'User deleted successfully');
          getInfluencers();
        }, (fail) {
          showErrorMessage(message: fail.message);
          loading.hide;
        });
      } catch (error) {
        loading.hide;
      }
    }

    addDashboardUser() {
      showDialog(
          context: currentContext,
          barrierColor: AppColors.barrierColor,
          builder: (ctx) {
            return AddDashboardUser(
              refresh: getUsers,
              operationType: OperationType.add,
              userModel: UserModel(),
            );
          });
    }

    addInfluencer() {
      showDialog(
          context: currentContext,
          barrierColor: AppColors.barrierColor,
          builder: (ctx) {
            return AddInfluencer(
              refresh: getUsers,
              operationType: OperationType.add,
              userModel: InfluencerModel(),
            );
          });
    }

    updateInfluencer({required InfluencerModel user}) {
      showDialog(
          context: currentContext,
          barrierColor: AppColors.barrierColor,
          builder: (ctx) {
            return AddInfluencer(
              refresh: getUsers,
              operationType: OperationType.update,
              userModel: user,
            );
          });
    }

    updateDashboardUser({required UserModel user}) {
      showDialog(
          context: currentContext,
          barrierColor: AppColors.barrierColor,
          builder: (ctx) {
            return AddDashboardUser(
              refresh: getUsers,
              operationType: OperationType.update,
              userModel: user,
            );
          });
    }
  }
  */