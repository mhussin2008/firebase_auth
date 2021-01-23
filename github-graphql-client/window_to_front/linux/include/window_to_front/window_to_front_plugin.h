// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#ifndef FLUTTER_PLUGIN_WINDOW_TO_FRONT_PLUGIN_H_
#define FLUTTER_PLUGIN_WINDOW_TO_FRONT_PLUGIN_H_

#include <flutter_linux/flutter_linux.h>

G_BEGIN_DECLS

#ifdef FLUTTER_PLUGIN_IMPL
#define FLUTTER_PLUGIN_EXPORT __attribute__((visibility("default")))
#else
#define FLUTTER_PLUGIN_EXPORT
#endif

typedef struct _WindowToFrontPlugin WindowToFrontPlugin;
typedef struct {
  GObjectClass parent_class;
} WindowToFrontPluginClass;

FLUTTER_PLUGIN_EXPORT GType window_to_front_plugin_get_type();

FLUTTER_PLUGIN_EXPORT void window_to_front_plugin_register_with_registrar(
    FlPluginRegistrar* registrar);

G_END_DECLS

#endif  // FLUTTER_PLUGIN_WINDOW_TO_FRONT_PLUGIN_H_