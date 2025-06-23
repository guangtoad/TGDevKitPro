//
//  ViewController.m
//  HTMLIMAGE2BASE64
//
//  Created by home on 2017/12/25.
//  Copyright © 2017年 toad. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    return;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction) openFileSeler:(id)sender{
    
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
        [self.pathText setStringValue:path];
        [self reloadFiles];
    }
}

- (void) reloadFiles{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error = nil;
    NSString *selectPath = [self.pathText stringValue];
    NSArray *array = [fm contentsOfDirectoryAtPath:selectPath error:&error];
    if (error != nil) {
        NSLog(@"error :%@",error);
    }
    else {
        NSLog(@"array:%@",array);
        for (NSString *filePath in array) {
            NSString *lastpath = [filePath lastPathComponent];
            NSString *ext = [lastpath pathExtension];
            ext = [ext lowercaseString];
            if ([@"html" isEqualToString:ext]) {
                NSLog(@"filePath:%@",filePath);
                NSString *itemPath = [[self.pathText stringValue] stringByAppendingPathComponent:filePath];
                NSString *string = [NSString stringWithContentsOfFile:itemPath encoding:NSUTF8StringEncoding error:&error];
                NSString *mutString  = [[NSString alloc] initWithString:string];
//                NSLog(@"string:%@",string);
                if (error != nil) {
                    
                }
                else {
                    NSString * regulaStr = @"<img[^>]*>";
//                    NSString *regulaStr = @"<img class=\"*\" src=\"*\">";
                    
                    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                                           options:NSRegularExpressionCaseInsensitive
                                                                                             error:&error];
                    NSArray *arrayOfAllMatches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
                    
                    for (NSTextCheckingResult *match in arrayOfAllMatches)
                    {
                        NSString* substringForMatch;
                        substringForMatch = [string substringWithRange:match.range];
                        NSLog(@"substringForMatch:%@",substringForMatch);
                        NSArray *substringArry = [substringForMatch componentsSeparatedByString:@"\""];
                        
                        NSString *imagePath = substringArry[substringArry.count - 2];
                        NSLog(@"imagePath:%@",imagePath);
                        NSString *imageExt = [imagePath pathExtension];
                        NSImage *image = [[NSImage alloc] initWithContentsOfFile:[selectPath stringByAppendingPathComponent:imagePath]];
                        NSLog(@"image:%@",image);
                        NSArray *keys = [NSArray arrayWithObject:@"NSImageCompressionFactor"];
                        NSArray *objects = [NSArray arrayWithObject:@"1.0"];
                        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
                        NSBitmapImageRep *imageRep = [[NSBitmapImageRep alloc] initWithData:[image TIFFRepresentation]];
                        
                        NSData *tiff_data = [imageRep representationUsingType:NSPNGFileType properties:dictionary];
                        
                        NSString *base64Str =[tiff_data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                        NSString *database64str = [substringForMatch stringByReplacingOccurrencesOfString:imagePath withString:[NSString stringWithFormat:@"data:img/png;base64, %@",base64Str]];
                        
                        mutString = [mutString stringByReplacingOccurrencesOfString:substringForMatch withString:database64str];
                        
//                        NSString *outPath = [selectPath stringByAppendingPathComponent:@"OUTFILE"];
                        NSURL *outUrl = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                                                    inDomains:NSUserDomainMask] lastObject];
                        NSString *outPath =outUrl.path;
                        NSLog(@"outPath:%@",outPath);
                        NSString *outFilePath = [outPath stringByAppendingPathComponent:filePath];
                        NSLog(@"写入文件:%@",outFilePath);
                        if(![fm fileExistsAtPath:outPath]) {
                            [[NSFileManager defaultManager] createDirectoryAtPath:outPath withIntermediateDirectories:YES attributes:nil error:&error];
                        }
                        if (error != nil ) {
                            NSLog(@"error:%@",error);
                        }
                        
                        [mutString writeToFile:outFilePath
                                    atomically:false
                                      encoding:NSUTF8StringEncoding
                                         error:&error];
                        if (error != nil ) {
                            NSLog(@"error:%@",error);
                        }
                    }
                }
            }
        }
    }
    
}

@end
