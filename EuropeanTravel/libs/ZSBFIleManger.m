//
//  ZSBFIleManger.m
//  EuropeanTravel
//
//  Created by crespo on 2020/3/6.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

#import "ZSBFIleManger.h"

@implementation ZSBFIleManger


+(instancetype)shareInstance
{
    static ZSBFIleManger *_singleInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_singleInstance == nil) {
            _singleInstance = [[ZSBFIleManger alloc]init];
        }
    });
    return _singleInstance;
}

-(instancetype)init
{
    if (self=[super init]) {
        _countryArray=[NSMutableArray new];
    }
    return self;
}
- (BOOL)login{
 NSString *ret = [[NSUserDefaults standardUserDefaults]objectForKey:@"login"];
    if ([ret integerValue]==1) {
        return YES;
    }
    return NO;
}

- (BOOL)agree{
    NSString *ret =[[NSUserDefaults standardUserDefaults]objectForKey:@"agree"];
    if ([ret integerValue]==1) {
        return YES;
    }
    return NO;
}



-(NSArray*)countryArray{
    return _countryArray;
}
-(NSMutableArray*)likeArray{
    
    NSMutableArray *array=[[NSUserDefaults standardUserDefaults]objectForKey:@"likeDatas"];
    if (array.count) {
        return array;
    }else{
        array=[NSMutableArray new];
        return array;
    }
}
+(NSArray *)getFilenamelistOfType:(NSString *)type fromDirPath:(NSString *)dirPath
{
    NSMutableArray *filenamelist = [NSMutableArray arrayWithCapacity:10];
    NSArray *tmplist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirPath error:nil];
    
    for (NSString *filename in tmplist) {
        NSString *fullpath = [dirPath stringByAppendingPathComponent:filename];
        if ([self isFileExistAtPath:fullpath]) {
            if ([[filename pathExtension] isEqualToString:type]) {
                [filenamelist  addObject:filename];
            }
        }
    }
    
    return filenamelist;
}

+(BOOL)isFileExistAtPath:(NSString*)fileFullPath {
    BOOL isExist = NO;
    isExist = [[NSFileManager defaultManager] fileExistsAtPath:fileFullPath];
    return isExist;

}

- (NSMutableArray*)userDataArry{
    
    NSMutableArray *array=[NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"userInfoDatas"]];
       if (array.count) {
           return array;
       }else{
           array=[NSMutableArray new];
           return array;
       }
}


+ (NSArray*)getPathName{
    //使用快速枚举来实现
        //文件操作对象
        NSFileManager *manager = [NSFileManager defaultManager];
        //所查找文件夹的路径
        NSString *home = [@"/Users/crespo/Desktop/IOS_PROJECT/EuropeanTravel/EuropeanTravel/source/flatIcon" stringByExpandingTildeInPath];
        //目录迭代器
        NSDirectoryEnumerator *direnum = [manager enumeratorAtPath:home];
        //快速枚举
        NSMutableArray *files = [NSMutableArray arrayWithCapacity:42];
        for (NSString *filename in direnum) {
    //        if ([[filename pathExtension] isEqualTo:@"jpg"]) {
                [files addObject:filename];
    //        }
        }
        NSLog(@"%lu",[files count]);
        //快速枚举，输出结果
        for (NSString *filename in files) {
//            NSLog(@"%@",filename);
        }

    return files;
}


@end
