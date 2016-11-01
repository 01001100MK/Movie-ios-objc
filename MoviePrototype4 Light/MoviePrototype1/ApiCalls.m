//
//  ApiCalls.m
//  MoviePrototype1
//
//  Created by TIVA on 10/21/16.
//  Copyright © 2016 TIVA. All rights reserved.
//

#import "ApiCalls.h"

@implementation ApiCalls

+ (NSMutableDictionary *)GetPopularMovies
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    
    NSString *apiUrl = [[NSString alloc] init];
    apiUrl = @"https://api.themoviedb.org/3/movie/popular?api_key=81d7640dffed48055b1803be5b452893&language=en-US&page=1";
    NSURL *url = [[NSURL alloc] initWithString:apiUrl];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
//    NSHTTPURLResponse *urlResponse = [[NSHTTPURLResponse alloc] init];
    NSHTTPURLResponse *urlResponse = nil;
    
    NSError *error = [[NSError alloc] init];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    if (error.code == 0) {
        result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    }
    else {
        NSLog(@"ERROR IS %@", error);
    }
    
    return result;
}

+ (NSMutableDictionary *)GetSimilarMovies:(NSString *)movieId
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    
    //https://api.themoviedb.org/3/movie/550/similar?api_key=81d7640dffed48055b1803be5b452893&language=en-US
    NSString *apiUrl = [[NSString alloc] init];
    apiUrl = [NSString stringWithFormat:@"%@%@%@", @"https://api.themoviedb.org/3/movie/", movieId, @"/similar?api_key=81d7640dffed48055b1803be5b452893&language=en-US"];
    
    NSURL *url = [[NSURL alloc] initWithString:apiUrl];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //    NSHTTPURLResponse *urlResponse = [[NSHTTPURLResponse alloc] init];
    NSHTTPURLResponse *urlResponse = nil;
    
    NSError *error = [[NSError alloc] init];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    if (error.code == 0) {
        result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    }
    else {
        NSLog(@"ERROR IS %@", error);
    }
    
    return result;
}

+ (NSMutableDictionary *)GetUserCreatedList:(NSString *)listId
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    
    NSString *apiUrl = [[NSString alloc] init];
    apiUrl = [NSString stringWithFormat:@"%@%@%@", @"https://api.themoviedb.org/3/list/", listId, @"?api_key=81d7640dffed48055b1803be5b452893&language=en-US"];

    NSURL *url = [[NSURL alloc] initWithString:apiUrl];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //    NSHTTPURLResponse *urlResponse = [[NSHTTPURLResponse alloc] init];
    NSHTTPURLResponse *urlResponse = nil;
    
    NSError *error = [[NSError alloc] init];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    if (error.code == 0) {
        result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    }
    else {
        NSLog(@"ERROR IS %@", error);
    }
    
    return result;
}

+ (NSData *)GetImageDataForMovieUrl:(NSString *)imageUrl
{
    NSData *imageData = [[NSData alloc] init];
    
    NSString *apiUrl = [[NSString alloc] init];
    apiUrl = [NSString stringWithFormat:@"%@%@", @"https://image.tmdb.org/t/p/w300", imageUrl];
    
    NSURL *url = [[NSURL alloc] initWithString:apiUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    if (error.code == 0) {
        imageData = responseData;
    }
    else {
        NSLog(@"ERROR IS %@", error);
    }
    
    return imageData;
}

+ (NSData *)GetBackdropImageDataForMovieUrl:(NSString *)imageUrl
{
    NSData *imageData = [[NSData alloc] init];
    
    NSString *apiUrl = [[NSString alloc] init];
    apiUrl = [NSString stringWithFormat:@"%@%@", @"https://image.tmdb.org/t/p/w300", imageUrl];
    
    NSURL *url = [[NSURL alloc] initWithString:apiUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    if (error.code == 0) {
        imageData = responseData;
    }
    else {
        NSLog(@"ERROR IS %@", error);
    }
    
    return imageData;
}

@end
