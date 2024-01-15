import 'package:chatwave_flutter/authentication_screen/controller/authentication_controller.dart';
import 'package:chatwave_flutter/constants/color_constants.dart';
import 'package:chatwave_flutter/generated/assets.dart';
import 'package:chatwave_flutter/utils/helping_widgets.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


///---------custom common textfield-----------///
class CustomTextFieldNumber extends StatelessWidget {
  TextEditingController textEditController;
  TextInputType textInputType;
  String? icon;
  final Function(String) onChanged;
  String label;
  bool filled;
  Color? filledColor;
  FocusNode? focusNode;
  bool hintExist = false;
  String? hint;

  CustomTextFieldNumber({
    Key? key,
    required this.textEditController,
    required this.filled,
    this.icon,
    this.focusNode,
    required this.onChanged,
    required this.textInputType,
    required this.label,
    this.filledColor,
    this.hintExist = false,
    this.hint,
    // required this.validate
  }) : super(key: key);

  var maskFormatter;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(focusNode);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: ColorConstants.cECF4FF,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Image.asset(
                icon.toString(),
                height: 22,
                width: 22,
                fit: BoxFit.fill,
                color: ColorConstants.c1F61E8,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                        color: ColorConstants.c626B84,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ),
                  space15(),
                  TextFormField(
                    controller: textEditController,
                    keyboardType: textInputType,
                    //   inputFormatters: [
                    //     maskFormatter =  MaskTextInputFormatter(
                    //      mask: '### #### ### ### ### ############################',
                    //     filter: { "#": RegExp(r'[0-9]') },
                    //     type: MaskAutoCompletionType.eager
                    // ),
                    //   ],
                    focusNode: focusNode,
                    maxLines: 1,
                     maxLength: 25,
                    style: const TextStyle(
                        color: ColorConstants.c1C2439,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      labelStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        // color: ColorConstants.c404040
                      ),
                      hintText: hintExist ? hint : label,
                      fillColor: filledColor ?? ColorConstants.cECF4FF,
                      hintStyle: TextStyle(
                          color: ColorConstants.c1C2439.withOpacity(0.5),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: onChanged,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///-------customTextfield for the selecting country
class CustomTextFieldCountry extends StatelessWidget {
  String? icon;
  String label;
  Color? filledColor;
  String? hint;
  AuthenticationController controller;

  CustomTextFieldCountry({
    Key? key,
    this.icon,
    required this.label,
    this.filledColor,
    this.hint,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCountryPicker(
          context: context,
          countryListTheme: CountryListThemeData(
            flagSize: 25,
            backgroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
            bottomSheetHeight: 0.6.sh,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            inputDecoration: InputDecoration(
              labelText: 'Search',
              hintText: 'Start typing to search',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: const Color(0xFF8C98A8).withOpacity(0.2),
                ),
              ),
            ),
          ),
          onSelect: (Country country) {
            controller.countryName = country.name;
            controller.countryCode = country.phoneCode;
            controller.selectCountry=false;
            controller.selectCountryError="";
            controller.update();
          },
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: ColorConstants.cECF4FF,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Image.asset(
                icon.toString(),
                height: 22,
                width: 18,
                fit: BoxFit.fill,
                color: ColorConstants.c1F61E8,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                        color: ColorConstants.c626B84,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ),
                  space15(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.selectCountry==true?"Select":"(+${controller.countryCode}) ${controller.countryName}",
                        style: const TextStyle(
                            color: ColorConstants.c1C2439,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const Image(
                        image: AssetImage(Assets.imagesDropdownIcon),
                        height: 6,
                        width: 11,
                        color: ColorConstants.c202020,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// enter otp field

class CustomTextFieldPin extends StatelessWidget {
  TextEditingController textEditController;
  // FocusNode focusNode;
  bool? unFocus;
  bool? unFocusFirst;
  final Function(String) onChanged;
  CustomTextFieldPin(
      {Key? key,
        required this.textEditController,
        // required this.focusNode,
        this.unFocus,
        this.unFocusFirst,
        required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.center,
      child: TextFormField(
        maxLength: 1,
        textAlign: TextAlign.center,
        // focusNode:focusNode,
        controller: textEditController,
        keyboardType: TextInputType.number,
        onChanged: (v) {

          if (v.isEmpty) {
            if (unFocusFirst == true) {
              FocusScope.of(context).unfocus();
              return;
            }
            FocusScope.of(context).previousFocus();
          } else {
            if (unFocus == true) {
              FocusScope.of(context).unfocus();
              return;
            }
            FocusScope.of(context).nextFocus();
          }
        },
        style: const TextStyle(
            color: ColorConstants.c1C2439,
            fontSize: 24,
            fontWeight: FontWeight.w400),
        decoration: InputDecoration(
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            filled: true,
            fillColor: ColorConstants.cECF4FF,
            counterText: "",
            enabledBorder: OutlineInputBorder(
                borderSide:
                const BorderSide(color: Colors.transparent, width: 1),
                borderRadius: BorderRadius.circular(15)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15))),
      ),
    );
  }
}



///------custom textfiled for common name and description.
class CustomTextFieldName extends StatelessWidget {
  TextEditingController textEditController;
  TextInputType textInputType;
  String? icon;
  int maxLines;

  // bool validate;
  String label;
  FocusNode focusNode;
  bool filled;
  bool isImage;
  Color? filledColor;
  bool hintExist = false;
  String? hint;

  CustomTextFieldName({
    Key? key,
    required this.textEditController,
    required this.maxLines,
    required this.filled,
    this.icon,
    required this.isImage,
    required this.focusNode,
    required this.textInputType,
    required this.label,
    this.filledColor,
    this.hintExist = false,
    this.hint,
    // required this.validate
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: (){
        FocusScope.of(context).requestFocus(focusNode);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: ColorConstants.cECF4FF,
        ),
        child: Row(
          children: [
            isImage == true
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Image.asset(
                      icon.toString(),
                      height: 22,
                      width: 17,
                      fit: BoxFit.fill,
                      color: ColorConstants.c1F61E8,
                    ),
                  )
                : const SizedBox(),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                        color: ColorConstants.c626B84,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ),
                  space10(),
                  TextFormField(
                    focusNode: focusNode,
                    controller: textEditController,
                    keyboardType: textInputType,
                    maxLines: maxLines,
                    style: const TextStyle(
                        color: ColorConstants.c1C2439,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      filled: true,
                      counterText: '',
                      border: InputBorder.none,
                      hintText: hintExist ? hint : label,
                      fillColor: filledColor ?? ColorConstants.cECF4FF,
                      hintStyle: TextStyle(
                          color: isImage == true
                              ? ColorConstants.c1C2439.withOpacity(0.5)
                              : ColorConstants.c1C2439,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



