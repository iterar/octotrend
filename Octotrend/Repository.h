//
//  Repository.h
//  Octotrend
//
//  Created by Tiago Alves on 27/12/13.
//  Copyright (c) 2013 Iterar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Repository : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSNumber *watchersCount;

@end
