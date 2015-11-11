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

@property (nonatomic, strong, readwrite) NSMutableDictionary *versionsDictionary;

@property (nonatomic, strong, readwrite) NSString *currentVersionString;
@property (nonatomic, strong, readwrite) NSString *currentBuildString;

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

- (instancetype)init {
    self = [super init];
    if (self) {
        self.currentVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        self.currentBuildString = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    }
    return self;
}

#pragma mark Public

- (void)track {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userDefaults versionDictionary];
    
    BOOL save = NO;
    
    // If the version dict does not exist, then it is the first time the user has launched the application after installation.
    if (dict) {
        self.isFirstLaunchEver = NO;
        
        self.versionsDictionary = [NSMutableDictionary dictionaryWithDictionary:dict];
        
        NSArray *versionBuilds = self.versionsDictionary[self.currentVersionString];
        // If the versionBuilds array does not exist, then it is the first time the user has launched the the current version of the application.
        if (versionBuilds) {
            self.isFirstLaunchForCurrentVersion = NO;
            // If the build string does not exist, then it is the first time the user has launched the the current build of the application.
            if ([versionBuilds containsObject:self.currentBuildString]) {
                self.isFirstLaunchForCurrentBuild = NO;
            } else {
                self.isFirstLaunchForCurrentBuild = YES;
                NSMutableArray *updatedVersionBuilds = [NSMutableArray arrayWithArray:versionBuilds];
                [updatedVersionBuilds addObject:self.currentBuildString];
                [self.versionsDictionary setObject:updatedVersionBuilds forKey:self.currentVersionString];
                save = YES;
            }
        } else {
            self.isFirstLaunchForCurrentVersion = YES;
            self.isFirstLaunchForCurrentBuild = YES;
            versionBuilds = @[self.currentBuildString];
            [self.versionsDictionary setObject:versionBuilds forKey:self.currentVersionString];
            save = YES;
        }
    } else {
        self.isFirstLaunchEver = YES;
        self.isFirstLaunchForCurrentVersion = YES;
        self.isFirstLaunchForCurrentBuild = YES;
        self.versionsDictionary = [[NSMutableDictionary alloc] init];
        NSArray *builds = @[self.currentBuildString];
        [self.versionsDictionary setObject:builds forKey:self.currentVersionString];
        save = YES;
    }
    
    if (save) {
        [userDefaults setVersionDictionary:self.versionsDictionary];
    }
}

@end
