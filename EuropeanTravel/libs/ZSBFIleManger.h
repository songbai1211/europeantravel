//
//  ZSBFIleManger.h
//  EuropeanTravel
//
//  Created by crespo on 2020/3/6.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZSBFIleManger : NSObject
+(NSArray *) getFilenamelistOfType:(NSString *)type fromDirPath:(NSString *)dirPath;
+ (NSArray*)getPathName;
+(instancetype)shareInstance;
@property(nonatomic,strong)NSArray *countryArray;
@property(nonatomic,strong)NSMutableArray *likeArray;
@property(nonatomic,assign)BOOL login;
@property(nonatomic,assign)BOOL agree;
@property(nonatomic,strong)NSMutableArray *userDataArry;

@end

NS_ASSUME_NONNULL_END
