//
//  LBData.m
//  XinDongFang
//
//  Created by 楼 彬 on 13-4-28.
//  Copyright (c) 2013年 楼 彬. All rights reserved.
//

#import "LBData.h"
#import "FMDatabase.h"


@implementation LBData

static FMDatabase *db;


+ (FMDatabase *)Instance
{
    @synchronized([LBData class]) {
        
        if (db == nil) {
            
            NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *dbPath = [documentPath stringByAppendingPathComponent:DBNAME];
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            [fileManager removeItemAtPath:dbPath error:nil];
            
            db = [FMDatabase databaseWithPath:dbPath];
        }
        
        if (![db open]) {
            
            NSLog(@"Could not open db!");
            return 0;
        }
        
        return db;
    }
}

























@end
