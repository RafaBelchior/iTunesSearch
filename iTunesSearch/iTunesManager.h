//
//  iTunesManager.h
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iTunesManager : NSObject
@property NSMutableArray *sections;
@property NSArray *sectionsOrden;
@property NSMutableArray *podcasts;
@property NSMutableArray *movies;
@property NSMutableArray *songs;
@property NSMutableArray *tvepisodes;
@property NSMutableArray *musicvideos;
/**
 * gets singleton object.
 * @return singleton
 */
+ (iTunesManager*)sharedInstance;

- (NSArray *)buscarMidias:(NSString *)termo;

@end
