//
//  ApiCalls.h
//  MoviePrototype1
//
//  Created by TIVA on 10/21/16.
//  Copyright © 2016 TIVA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiCalls : NSObject

+ (NSMutableDictionary *)GetPopularMovies;
+ (NSMutableDictionary *)GetSimilarMovies:(NSString *)movieId;
+ (NSData *)GetImageDataForMovieUrl:(NSString *)imageUrl;
+ (NSData *)GetBackdropImageDataForMovieUrl:(NSString *)imageUrl;
+ (NSMutableDictionary *)GetUserCreatedList:(NSString *)listId;

@end
