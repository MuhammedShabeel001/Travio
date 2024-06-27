import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/providers/auth_provider.dart';
import 'package:travio/providers/textcontroller_provider.dart';
import 'package:travio/utils/theme.dart';
import 'package:travio/widgets/common/customs/custom_buttons.dart';
import 'package:travio/widgets/common/customs/custom_textfield.dart';
import 'package:travio/widgets/common/customs/welcome_bar.dart';

class DetailsPage extends StatelessWidget {
   DetailsPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textControllers = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: TTthemeClass().ttThird,
      body: Column(
        children: [
          Flexible(flex: 1, child: tWelcome('')),
          Flexible(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: TTthemeClass().ttLightPrimary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: ListView(
                      padding: const EdgeInsets.only(
                        top: 15,
                        left: 20,
                        right: 20,
                      ),
                      children: [
                        Center(
                            child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: TTthemeClass().ttThirdHalf,
                                style: BorderStyle.solid,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(25)),
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: const Image(
                                image: AssetImage(
                                    'assets/images/default_pfpf.jpg')),
                          ),
                        )),
                        const SizedBox(
                          height: 20,
                        ),
                        tTextfield(
                            Labeltext: 'Full Name',
                            HintText: 'john wick',
                            controller: textControllers.nameController),
                        tNumberfield(
                            Labeltext: 'Number',
                            controller: textControllers.phoneController),
                        tDropdownField(
                            labelText: 'Pronouns',
                            hintText: 'he/him',
                            controller: textControllers.pronounController,
                            items: ['he/him', 'she/her', 'they/them'])
                      ],
                    )),
                    Container(
                        padding: const EdgeInsets.all(20),
                        child: tActiveBottomButton('Start', true))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
