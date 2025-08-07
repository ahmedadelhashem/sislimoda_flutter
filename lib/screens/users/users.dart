import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/models/user/get_users_model.dart';
import 'package:sislimoda_admin_dashboard/models/users/DashboardUserModel.dart';
import 'package:sislimoda_admin_dashboard/models/users/InfluencerModel.dart';
import 'package:sislimoda_admin_dashboard/models/users/MobileUserModel.dart';
import 'package:sislimoda_admin_dashboard/screens/categories/widgets/add_category.dart';
import 'package:sislimoda_admin_dashboard/screens/users/users_data.dart';
import 'package:sislimoda_admin_dashboard/screens/users/widgets/add_influencer.dart';
import 'package:sislimoda_admin_dashboard/screens/users/widgets/dahsboard_users_datatable.dart';
import 'package:sislimoda_admin_dashboard/screens/users/widgets/influencersDataTable.dart';
import 'package:sislimoda_admin_dashboard/screens/users/widgets/mobile_users.dart';
import 'package:sislimoda_admin_dashboard/screens/users/widgets/add_influencer.dart';
import 'package:sislimoda_admin_dashboard/screens/users/widgets/dahsboard_users_datatable.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';


@RoutePage()
class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> with UsersData {
  @override
  void initState() {
    super.initState();
    getUsers();
    getInfluencers();
    getMobileUsers();
    getVendorStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      loadingCubit: loading,
      child: Scaffold(
        appBar: AppBarCustom(ctx: context),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.isMobile ? 16 : 34),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.userManagement.tr(),
                          style: AppFonts.apptextStyle.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          LocaleKeys.usersManagementHint.tr(),
                          style: AppFonts.apptextStyle.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!context.isMobile) ...[
                    SizedBox(width: 16),
                    _buildPopupButton(),
                  ]
                ],
              ),
              if (context.isMobile) ...[
                SizedBox(height: 12),
                Align(alignment: Alignment.centerLeft, child: _buildPopupButton())
              ],
              SizedBox(height: 25.h),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: DefaultTabController(
                      length: 3,
                      child: Column(
                        children: [
                          TabBar(
                            isScrollable: true,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: BoxDecoration(
                              color: const Color(0xffEBF4FF),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            labelStyle: AppFonts.apptextStyle.copyWith(
                              color: const Color(0xff003B7E),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            unselectedLabelStyle: AppFonts.apptextStyle.copyWith(
                              color: const Color(0xff556377),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            tabs: [
                              Tab(text: isArabic ? 'مستخدمين لوحة التحكم' : 'Dashboard users'),
                              Tab(text: isArabic ? 'المؤثرين' : 'Influencers'),
                              Tab(text: isArabic ? 'مستخدمي الموبايل' : 'Mobile users'),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                // شاشة مستخدمي لوحة التحكم
                              BlocBuilder<GenericCubit<List<DashboardUserModel>>, GenericState<List<DashboardUserModel>>>(
  bloc: dashboardUsersCubit,
  builder: (context, state) {
    final users = state.data ?? [];
    return DashboardUsersDatatable(
      // users: users,
      deleteUser: (id) => deleteUser(id),
      updateUser: (user) => updateUser(user:user), 
      dashboardUsersCubit: dashboardUsersCubit,
    );
  },
),


BlocBuilder<GenericCubit<List<InfluencerModel>>, GenericState<List<InfluencerModel>>>(
  bloc: influencersCubit,
  builder: (context, state) {
    return InfluencersDatatable(
      influencersCubit: influencersCubit,
      deleteInfluencer: (String id) => deleteInfluencer(id),
      updateInfluencer: (user) => updateInfluencer(user, user: user),
      optionSet: status, // ✅ جديد
      changeUserStatus: getInfluencers, // ✅ جديد
    );
  },
),

BlocBuilder<GenericCubit<List<MobileUserModel>>, GenericState<List<MobileUserModel>>>(
  bloc: mobileUsersCubit,
  builder: (context, state) {
    return MobileUsers(
      deleteUser: (id) => deleteUser(id),
      dashboardUsersCubit: mobileUsersCubit,
      convertToInfluencer: (user) => convertUserToInfluencer(userId: user.id ?? ''),
    );
  },
),




                                // // شاشة مستخدمي الموبايل
                                // GenericBuilder<List<MobileUserModel>>(
                                //   genericCubit: mobileUsersCubit,
                                //   builder: (mobileUsers) {
                                //     return MobileUsers(
                                //       dashboardUsersCubit: mobileUsersCubit,
                                //       convertToInfluencer: (user) => convertUserToInfluencer(userId: user.id ?? ''),
                                //     );
                                //   },
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopupButton() {
    return PopupMenuButton(
      position: PopupMenuPosition.under,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      itemBuilder: (context) => [
        PopupMenuItem(
          height: 35,
          onTap: addDashboardUser,
          child: Row(
            children: [
              SvgPicture.asset(AppImages.users, width: 20, height: 20),
              SizedBox(width: 10),
              Text(
                isArabic ? 'مستخدم لوحة التحكم' : 'Dashboard user',
                style: AppFonts.apptextStyle.copyWith(
                  color: AppColors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          height: 35,
          onTap: addInfinuencer,
          child: Row(
            children: [
              SvgPicture.asset(AppImages.users, width: 20, height: 20),
              SizedBox(width: 10),
              Text(
                isArabic ? 'مؤثر' : 'Influencer',
                style: AppFonts.apptextStyle.copyWith(
                  color: AppColors.error,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
      child: SizedBox(
        width: 150,
        height: 40,
        child: AppButton(
          title: LocaleKeys.addUser.tr(),
          titleFontColor: Colors.white,
          titleFontSize: 15,
          borderRadius: 8,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }





//  void inf() {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (_) => const AddInfluencerPage(),
//     ),
//   ).then((_) {
//     getInfluencers();
//   });
// }
void addInfinuencer() {
  showDialog(
    context: context,
    builder: (context) => AddInfluencer(
      operationType: OperationType.add,
      userModel: InfluencerModel.empty(), // أو قيم افتراضية مناسبة
      refresh: getInfluencers,
    ),
  );
}

}



















