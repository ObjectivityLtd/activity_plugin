// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

#import "ActivityPlugin.h"
#if __has_include(<activity_plugin/activity_plugin-Swift.h>)
#import <activity_plugin/activity_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "activity_plugin-Swift.h"
#endif

@implementation ActivityPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftActivityPlugin registerWithRegistrar:registrar];
}
@end
