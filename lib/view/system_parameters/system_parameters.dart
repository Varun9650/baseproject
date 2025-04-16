import 'dart:io';
import 'package:base_project/commans/widgets/custom_textform_field.dart';
import 'package:base_project/commans/widgets/custome_elevated_button.dart';
import 'package:base_project/resources/app_colors.dart';
import 'package:base_project/view_model/system_params/system_params_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SystemParametersView extends StatefulWidget {
  const SystemParametersView({super.key});

  @override
  _SystemParametersViewState createState() => _SystemParametersViewState();
}

class _SystemParametersViewState extends State<SystemParametersView> {
  final Map<String, String> formData = {};

  final TextEditingController schedulerTimerController =
      TextEditingController();
  final TextEditingController leaseTaxCodeController = TextEditingController();
  final TextEditingController vesselConfirmationController =
      TextEditingController();
  final TextEditingController rowToDisplayController = TextEditingController();
  final TextEditingController linkToDisplayController = TextEditingController();
  final TextEditingController rowToAddController = TextEditingController();
  final TextEditingController lovRowToDisplayController =
      TextEditingController();
  final TextEditingController lovLinkToDisplayController =
      TextEditingController();
  final TextEditingController oidServerNameController = TextEditingController();
  final TextEditingController oidBaseController = TextEditingController();
  final TextEditingController oidAdminUserController = TextEditingController();
  final TextEditingController oidServerPortController = TextEditingController();
  final TextEditingController userDefaultGroupController =
      TextEditingController();
  final TextEditingController defaultDepartmentController =
      TextEditingController();
  final TextEditingController defaultPositionController =
      TextEditingController();
  final TextEditingController singleChargeController = TextEditingController();
  final TextEditingController firstDayOfWeekController =
      TextEditingController();
  final TextEditingController hourPerShiftController = TextEditingController();
  final TextEditingController cnBillingFrequencyController =
      TextEditingController();
  final TextEditingController billingDepartmentCodeController =
      TextEditingController();
  final TextEditingController basePriceListController = TextEditingController();
  final TextEditingController nonContainerServiceController =
      TextEditingController();
  final TextEditingController ediMaeSchedulerController =
      TextEditingController();
  final TextEditingController ediSchedulerController = TextEditingController();
  final TextEditingController companynameController = TextEditingController();

  bool isRegistrationAllow = false;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the values from system parameters
    Provider.of<SystemParamsViewModel>(context, listen: false)
        .getSystemParams(1);
    _initializeControllers();
  }

  void _initializeControllers() {
    final sysparameter =
        Provider.of<SystemParamsViewModel>(context, listen: false)
            .systemParamsList;

    schedulerTimerController.text =
        sysparameter['schedulerTime']?.toString() ?? '';
    leaseTaxCodeController.text =
        sysparameter['leaseTaxCode']?.toString() ?? '';
    vesselConfirmationController.text =
        sysparameter['vesselConfProcessLimit']?.toString() ?? '';
    rowToDisplayController.text =
        sysparameter['rowToDisplay']?.toString() ?? '';
    linkToDisplayController.text =
        sysparameter['linkToDisplay']?.toString() ?? '';
    rowToAddController.text = sysparameter['rowToAdd']?.toString() ?? '';
    lovRowToDisplayController.text =
        sysparameter['lovRowToDisplay']?.toString() ?? '';
    lovLinkToDisplayController.text =
        sysparameter['lovLinkToDisplay']?.toString() ?? '';
    oidServerNameController.text =
        sysparameter['oidserverName']?.toString() ?? '';
    oidBaseController.text = sysparameter['oidBase']?.toString() ?? '';
    oidAdminUserController.text =
        sysparameter['oidAdminUser']?.toString() ?? '';
    oidServerPortController.text =
        sysparameter['oidServerPort']?.toString() ?? '';
    userDefaultGroupController.text =
        sysparameter['userDefaultGroup']?.toString() ?? '';
    defaultDepartmentController.text =
        sysparameter['defaultDepartment']?.toString() ?? '';
    defaultPositionController.text =
        sysparameter['defaultPosition']?.toString() ?? '';
    singleChargeController.text =
        sysparameter['singleCharge']?.toString() ?? '';
    firstDayOfWeekController.text =
        sysparameter['firstDayOftheWeek']?.toString() ?? '';
    hourPerShiftController.text =
        sysparameter['hourPerShift']?.toString() ?? '';
    cnBillingFrequencyController.text =
        sysparameter['cnBillingFrequency']?.toString() ?? '';
    billingDepartmentCodeController.text =
        sysparameter['billingDepartmentCode']?.toString() ?? '';
    basePriceListController.text =
        sysparameter['basePriceList']?.toString() ?? '';
    nonContainerServiceController.text =
        sysparameter['nonContainerServiceOrder']?.toString() ?? '';
    ediMaeSchedulerController.text =
        sysparameter['ediMaeSchedulerONOFF']?.toString() ?? '';
    ediSchedulerController.text =
        sysparameter['ediSchedulerONOFF']?.toString() ?? '';
    companynameController.text =
        sysparameter['company_Display_Name']?.toString() ?? '';

    isRegistrationAllow = sysparameter['regitrationAllowed'] ?? false;
  }

  void _handleOnChanged(String key, String value) {
    formData[key] = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.adaptive.arrow_back),
        ),
        title: const Text("System Parameters"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Existing fields
              _buildTextFormField("Scheduler Timer", schedulerTimerController),
              _buildTextFormField("Lease Tax Code", leaseTaxCodeController),
              _buildTextFormField(
                  "Vessel Confirmation", vesselConfirmationController),
              _buildTextFormField("Row to Display", rowToDisplayController),
              _buildTextFormField("Link to Display", linkToDisplayController),
              _buildTextFormField("Row to Add", rowToAddController),
              _buildTextFormField(
                  "LOV Row to Display", lovRowToDisplayController),
              _buildTextFormField(
                  "LOV Link to Display", lovLinkToDisplayController),
              _buildTextFormField("OID Server Name", oidServerNameController),
              _buildTextFormField("OID Base", oidBaseController),
              _buildTextFormField("OID Admin User", oidAdminUserController),
              _buildTextFormField("OID Server Port", oidServerPortController),
              _buildTextFormField(
                  "User Default Group", userDefaultGroupController),
              _buildTextFormField(
                  "Default Department", defaultDepartmentController),
              _buildTextFormField(
                  "Default Position", defaultPositionController),
              _buildTextFormField("Single Charge", singleChargeController),
              _buildTextFormField(
                  "First Day of the Week", firstDayOfWeekController),
              _buildTextFormField("Hours Per Shift", hourPerShiftController),
              _buildTextFormField(
                  "CN Billing Frequency", cnBillingFrequencyController),
              _buildTextFormField(
                  "Billing Department Code", billingDepartmentCodeController),
              _buildTextFormField("Base Price List", basePriceListController),
              _buildTextFormField(
                  "Non-Container Service Order", nonContainerServiceController),
              _buildTextFormField(
                  "EDI Mae Scheduler ON/OFF", ediMaeSchedulerController),
              _buildTextFormField(
                  "EDI Scheduler ON/OFF", ediSchedulerController),
              _buildTextFormField(
                  "Company Display Name", companynameController),

              // Checkbox for registration allowed
              Row(
                children: [
                  Checkbox(
                    value: isRegistrationAllow,
                    onChanged: (bool? value) {
                      setState(() {
                        isRegistrationAllow = value ?? false;
                      });
                      _handleOnChanged('Registration Allowed',
                          isRegistrationAllow.toString());
                    },
                  ),
                  const Text("Allow Registration"),
                ],
              ),
              const SizedBox(height: 20),
              Consumer<SystemParamsViewModel>(
                builder: (context, provider, child) {
                  return provider.profileImg != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(provider.profileImg!.path),
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.accent),
                          ),
                          child: const Center(
                            child: Icon(Icons.image,
                                size: 50, color: AppColors.accent),
                          ),
                        );
                },
              ),

              // Upload button
              const SizedBox(height: 20),
              Consumer<SystemParamsViewModel>(
                builder: (context, provider, child) {
                  return MyCustomElevatedButton(
                    child: const Text("Pick Image"),
                    onPressed: () {
                      provider.pickImg(context);
                    },
                  );
                },
              ),

              const SizedBox(height: 10),

              // Save button
              Consumer<SystemParamsViewModel>(
                builder: (context, provider, child) {
                  return MyCustomElevatedButton(
                    isLoading: provider.loading,
                    child: const Text("Save"),
                    onPressed: () {
                      print(formData);
                      provider.updateSystemParams(formData, 1);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MyCustomTextFormField(
        label: label,
        controller: controller,
        onChanged: (value) => _handleOnChanged(label, value),
      ),
    );
  }
}
