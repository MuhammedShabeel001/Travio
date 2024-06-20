//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <custom_text_form_field_plus/custom_text_form_field_plus_plugin_c_api.h>
#include <firebase_auth/firebase_auth_plugin_c_api.h>
#include <firebase_core/firebase_core_plugin_c_api.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  CustomTextFormFieldPlusPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("CustomTextFormFieldPlusPluginCApi"));
  FirebaseAuthPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FirebaseAuthPluginCApi"));
  FirebaseCorePluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FirebaseCorePluginCApi"));
}
