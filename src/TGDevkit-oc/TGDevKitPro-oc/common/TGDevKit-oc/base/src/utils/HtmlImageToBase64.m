//
//  HtmlImageToBase64.m
//  TGToo
//
//  Created by home on 2017/12/26.
//  Copyright © 2017年 toad. All rights reserved.
//

#import "HtmlImageToBase64.h"
#import <AppKit/AppKit.h>
@implementation HtmlImageToBase64

+ (void) openFileSeler{
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    
    NSURL *shareFilePath = [NSURL URLWithString:@"NSHomeDirectory()"];
    [panel setDirectoryURL:shareFilePath];
    [panel setAllowsMultipleSelection:NO];
    [panel setCanChooseDirectories:YES];
    [panel setCanChooseFiles:YES];
    
    NSString*ex1 = @"zip";
    NSString*ex2 = @"jpg";
    NSString*ex3 = @"pdf";
    NSString*ex4 = @"log";
    NSString*ex5 = @"pnp";
    NSString*ex6 = @"dmg";
    NSArray *array = [[NSArray alloc] initWithObjects:ex1,ex2,ex3,ex4,ex5,ex6,nil];//可以通过将定义的字符串类型的文件格式加入创建的NSArray里，来增加识别多种类型的文件
    
    [panel setAllowedFileTypes:array];
    
    [panel setAllowsOtherFileTypes:YES];
    if ([panel runModal] == NSModalResponseOK) {
        NSString *path = [panel.URLs.firstObject path];
        NSLog(@"path:%@",path);
        [self bianli:path];
    }
    
}
+ (NSString *)base64ImagePath:(NSString *)path{
    NSImage *image = [[NSImage alloc] initWithContentsOfFile:path];
    NSLog(@"open image:%@",path);
    NSLog(@"image:%@",image);
    NSArray *keys = [NSArray arrayWithObject:@"NSImageCompressionFactor"];
    NSArray *objects = [NSArray arrayWithObject:@"1.0"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSBitmapImageRep *imageRep = [[NSBitmapImageRep alloc] initWithData:[image TIFFRepresentation]];
    NSData *tiff_data = [imageRep representationUsingType:NSPNGFileType properties:dictionary];
    NSString *base64Str =[tiff_data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return base64Str;
}

+ (NSString *) htmlImage2base64:(NSString *)htmlPath{
    NSLog(@"open htm:%@",htmlPath);
    
    NSError *error = nil;
    NSString *string = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:&error];
    if (!string) {
        NSLog(@"读取错误");
        return nil;
    }
    NSString *mutString = [NSString stringWithString:string];
    if (error != nil) {
        NSLog(@"error:%@",error);
        return nil;
    }
    else{
        NSString * regulaStr = @"<img[^>]*>";
        //                    NSString *regulaStr = @"<img class=\"*\" src=\"*\">";
        
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:&error];
        NSArray *arrayOfAllMatches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
        
        for (NSTextCheckingResult *match in arrayOfAllMatches)
        {
            NSString* substringForMatch = [string substringWithRange:match.range];
            NSLog(@"substringForMatch:%@",substringForMatch);
            NSArray *substringArry = [substringForMatch componentsSeparatedByString:@"\""];
            NSString *imagePath = substringArry[substringArry.count - 2];
            NSString *base64Str =[self base64ImagePath:[[htmlPath stringByDeletingLastPathComponent] stringByAppendingPathComponent:imagePath]];
            NSString *database64str = [substringForMatch stringByReplacingOccurrencesOfString:imagePath withString:[NSString stringWithFormat:@"data:img/png;base64, %@",base64Str]];
             mutString = [mutString stringByReplacingOccurrencesOfString:substringForMatch withString:database64str];
        }
        return mutString;
    }
    return nil;
}

+ (void) bianli:(NSString *)path{
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *array = [fm contentsOfDirectoryAtPath:path error:&error];
    if (error != nil) {
    }
    else {
        for (NSString *filePath in array) {
            NSString *lastpath = [filePath lastPathComponent];
            NSString *ext = [lastpath pathExtension];
            ext = [ext lowercaseString];
            if ([@"html" isEqualToString:ext]) {
                
                NSLog(@"filePath:%@",filePath);
                NSString *newHtmlStr = [self htmlImage2base64:[path stringByAppendingPathComponent:filePath]];
                NSString *outPath = [path stringByAppendingPathComponent:@"out"];
                
                if(![fm fileExistsAtPath:outPath]) {
                    [[NSFileManager defaultManager] createDirectoryAtPath:outPath withIntermediateDirectories:YES attributes:nil error:&error];
                    if (error != nil) {
                        NSLog(@"error:%@",error);
                    }
                    else {
                        NSLog(@"创建文件夹");
                    }
                }
                NSString *writePath = [outPath stringByAppendingPathComponent:filePath];
                NSLog(@"写入文件：%@",writePath);
                [newHtmlStr writeToFile:writePath atomically:true encoding:NSUTF8StringEncoding error:&error];
                if (error != nil) {
                    NSLog(@"error:%@",error);
                }
            }
        }
    }
}

@end
