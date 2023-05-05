import 'package:amazon/constants/utils.dart';
import 'package:amazon/features/address/services/address_services.dart';
import 'package:amazon/providers/uer_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_textField.dart';
import '../../../constants/global_varibales.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = "/address";
  final String totalAmount;

  const AddressScreen({Key? key, required this.totalAmount}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController _flatBuildingController = TextEditingController();
  TextEditingController _areaController = TextEditingController();
  TextEditingController _pinCodeController = TextEditingController();
  TextEditingController _cityController = TextEditingController();

  final Future<PaymentConfiguration> _googlePayConfigFuture =
      PaymentConfiguration.fromAsset('gpay.json');

  String addressToBeUsed = '';
  List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();

  final _addressFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _flatBuildingController.dispose();
    _areaController.dispose();
    _pinCodeController.dispose();
    _cityController.dispose();
  }

  void onGPayPressed(String addressFromProvider){
    if(Provider.of<UserProvider>(context, listen: false).user.address.isEmpty){
      payPressed(addressFromProvider);
      addressServices.saveUserAddress(context: context, address: addressToBeUsed);

    }
    payPressed(addressFromProvider);
    addressServices.placeOrder(context: context, address: addressToBeUsed, totalSum: double.parse( widget.totalAmount));
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    bool _isForm = _flatBuildingController.text.isNotEmpty ||
        _areaController.text.isNotEmpty ||
        _pinCodeController.text.isNotEmpty ||
        _cityController.text.isNotEmpty;

    if (_isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            "${_flatBuildingController.text}, ${_areaController.text}, ${_cityController.text} - ${_pinCodeController.text}";
      }else{
        throw Exception("Please enter all the values");
      }
    }else if(addressFromProvider.isNotEmpty){
      addressToBeUsed = addressFromProvider;
    }else{
      showSnackBar(context, "ERROR");
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "OR",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _flatBuildingController,
                      hintText: "Flat, House No. Building",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: _areaController,
                      hintText: "Area, Street",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: _pinCodeController,
                      hintText: "PinCode",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: _cityController,
                      hintText: "town or City",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(text: "Place Order", onTap: (){
                onGPayPressed(address);
              }),
              // FutureBuilder<PaymentConfiguration>(
              //     future: _googlePayConfigFuture,
              //     builder: (context, snapshot) => snapshot.hasData
              //         ? GooglePayButton(
              //             height: 52,
              //             width: 250,
              //             onPressed: ()=> ,
              //             paymentConfiguration: snapshot.data!,
              //             paymentItems: paymentItems,
              //             type: GooglePayButtonType.buy,
              //             margin: const EdgeInsets.only(top: 15.0),
              //             onPaymentResult: onGPayResult,
              //             loadingIndicator: const Center(
              //               child: CircularProgressIndicator(),
              //             ),
              //           )
              //         : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }
}
