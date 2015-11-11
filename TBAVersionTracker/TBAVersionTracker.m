//
//  TBAVersionTracker.m
//  Chocolate
//
//  Copyright (C) 2015 Xiao Yao. All Rights Reserved.
//  See LICENSE.txt for more information.
//

#import "TBAVersionTracker.h"

#pragma mark - NSUserDefaults (TBAVersionTracker)

NSString *const NSUserDefaultsKeyVersionDictionary = @"com.thebinaryarchitect.versiontracker";

@interface NSUserDefaults (VersionTracker)
- (NSDictionary *)versionDictionary;
- (void)setVersionDictionary:(NSDictionary *)dictionary;
@end

@implementation NSUserDefaults (VersionTracker)

- (NSDictionary *)versionDictionary {
    return [self objectForKey:NSUserDefaultsKeyVersionDictionary];
}

- (void)setVersionDictionary:(NSDictionary *)dictionary {
    [self setObject:dictionary forKey:NSUserDefaultsKeyVersionDictionary];
    [self synchronize];
}

@end

#pragma mark - TBAVersionTracker

@interface TBAVersionTracker()
@property (nonatomic, assign, readwrite) BOOL isFirstLaunchEver;
@property (nonatomic, assign, readwrite) BOOL isFirstLaunchForCurrentVersion;
@property (nonatomic, assign, readwrite) BOOL isFirstLaunchForCurrentBuild;
@end

@implementation TBAVersionTracker

+ (TBAVersionTracker *)sharedInstance {
    static TBAVersionTracker *_versionTracker = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _versionTracker = [[self alloc] init];
    });
    return _versionTracker;
}

#pragma mark Public

- (void)track {
    
}

@end
