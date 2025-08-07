import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/models/orders/get_order_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/screens/order_details/components/client_details.dart';
import 'package:sislimoda_admin_dashboard/screens/order_details/components/client_message.dart';
import 'package:sislimoda_admin_dashboard/screens/order_details/components/order_delivering_details.dart';
import 'package:sislimoda_admin_dashboard/screens/order_details/components/order_details.dart';
import 'package:sislimoda_admin_dashboard/screens/order_details/order_details_data.dart';

@RoutePage()
class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen(
      {super.key, @PathParam("orderId") required this.orderId});
  final String orderId;
  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen>
    with OrderDetailsData {
  @override
void initState() {
  super.initState();
  fetchVendors().then((_) {
    getOrderDetails(orderId: widget.orderId);
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom(
          ctx: context,
        ),
        body: context.isMobile ? mobileDesing() : webDesing());
  }

  Widget webDesing() {
    return Screen(
      loadingCubit: loading,
      child: GenericBuilder<OrderModel?>(
          genericCubit: orderCubit,
          builder: (order) {
            return Container(
              padding: EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Expanded(
                      flex: 2,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            OrderDetails(
                              order: order,
                                getVendorNameById: getVendorNameById,

                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ClientDetails(
                              order: order,
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          OrderDeliveringDetails(
                            order: order,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ClientMessage(
                            order: order,
                          )
                        ],
                      )),
                ],
              ),
            );
          }),
    );
  }

  Widget mobileDesing() {
    return Screen(
      loadingCubit: loading,
      child: GenericBuilder<OrderModel?>(
          genericCubit: orderCubit,
          builder: (order) {
            return Container(
              padding: EdgeInsets.all(20),
              child: ListView(
                children: [
                  OrderDetails(
                    order: order,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ClientDetails(
                    order: order,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  OrderDeliveringDetails(
                    order: order,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ClientMessage(
                    order: order,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
