//
//  JFPlayMedia.h
//  MagizProduct
//
//  Created by jingfuran on 14/12/15.
//  Copyright (c) 2014年 jingfuran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JFPlayMedia : NSObject

+(void)playMovie:(NSString *)fileName;
+(void)myMovieFinishedCallback:(NSNotification*)notify;
@end
