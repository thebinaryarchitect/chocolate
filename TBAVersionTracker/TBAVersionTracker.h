//
//  TBAVersionTracker.h
//  Chocolate
//
//  Copyright (C) 2015 Xiao Yao. All Rights Reserved.
//  See LICENSE.txt for more information.
//

@import Foundation;

#pragma mark - TBAVersionTracker

/**
 *  Tracks the versions and builds of an application installed on a device.
 */
@interface TBAVersionTracker : NSObject

@property (nonatomic, assign, readonly) BOOL isFirstLaunchEver;
@property (nonatomic, assign, readonly) BOOL isFirstLaunchForCurrentVersion;
@property (nonatomic, assign, readonly) BOOL isFirstLaunchForCurrentBuild;

+ (TBAVersionTracker *)sharedInstance;

- (void)track;

@end
