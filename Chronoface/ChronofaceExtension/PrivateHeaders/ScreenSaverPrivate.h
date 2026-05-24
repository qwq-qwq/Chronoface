//
//  ScreenSaverPrivate.h
//
//  Reverse-engineered private ScreenSaver API declarations.
//  Used by the new macOS Sonoma+ App Extension based screensaver API.
//  Symbols are exported in ScreenSaver.framework but Apple does not publish public headers.
//
//  Based on Aerial v4 approach:
//  https://github.com/AerialScreensaver/Aerial/blob/main/AerialScreenSaverExtension/PrivateHeaders/ScreenSaverPrivate.h
//

#ifndef ScreenSaverPrivate_h
#define ScreenSaverPrivate_h

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Principal class for screensaver extensions.
/// Declared in Info.plist via NSExtensionPrincipalClass.
@interface ScreenSaverExtension : NSObject
- (instancetype)init;
@end

/// View controller that manages the screensaver view.
/// Declared in Info.plist via ScreenSaverViewControllerClass.
@interface ScreenSaverViewController : NSViewController
- (instancetype)init;
@end

/// View controller for the configuration sheet (Options button).
/// Declared in Info.plist via ScreenSaverConfigurationSheetViewControllerClass.
@interface ScreenSaverConfigurationViewController : NSViewController
- (instancetype)init;
@end

NS_ASSUME_NONNULL_END

#endif /* ScreenSaverPrivate_h */