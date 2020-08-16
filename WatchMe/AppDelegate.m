//
//  AppDelegate.m
//  WatchMe
//
//  Created by Mark Cornelisse on 12/08/2020.
//  Copyright © 2020 Mark Cornelisse. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate () <NSMenuItemValidation>

@end

@implementation AppDelegate

- (void)reopenWindow {
    NSApplication *application = NSApplication.sharedApplication;
    if (application.windows.count == 0) {
        NSWindowController *windowController = (NSWindowController *)[[NSStoryboard alloc] instantiateControllerWithIdentifier:@"MainWindow"];
        [windowController showWindow:self];
    } else if (application.mainWindow) {
        [application.mainWindow makeKeyAndOrderFront:self];
    } else {
        NSWindow *window = application.windows.firstObject;
        [window makeKeyAndOrderFront:self];
    }
}

- (void)showWindow:(id)sender {
    [self reopenWindow];
}

#pragma mark - NSMenuItemValidation

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem {
    if ([self respondsToSelector:menuItem.action]) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - NSApplicationDelegate

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag {
    [self reopenWindow];
    return YES;
}

@end
