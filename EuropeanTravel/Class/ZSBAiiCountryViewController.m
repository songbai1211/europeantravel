//
//  ZSBAiiCountryViewController.m
//  EuropeanTravel
//
//  Created by crespo on 2020/3/6.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

#import "ZSBAiiCountryViewController.h"
#import "XLSphereView.h"
#import "ZSBListViewController.h"
#import <Accelerate/Accelerate.h>
@interface ZSBAiiCountryViewController ()
@property (nonatomic,strong) XLSphereView *sphereView;

@end

@implementation ZSBAiiCountryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
          self.navigationItem.title=@"旅行列表";
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
      self.navigationController.navigationBarHidden=NO;
    
   UIImageView *imageView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:imageView];
    

    imageView.image=[self blurryImage:[UIImage imageNamed:@"4.jpg"] withBlurLevel:0.3];
    [self earth];
    // Do any additional setup after loading the view.
}
-(void)earth{
    
    CGFloat sphereViewW = self.view.frame.size.width - 30 * 2;
    CGFloat sphereViewH = sphereViewW;
    _sphereView = [[XLSphereView alloc] initWithFrame:CGRectMake(30, 100, sphereViewW, sphereViewH)];
    _sphereView.center=self.view.center;
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    NSArray *imagesArry=@[@"波兰.gif",@"斯洛伐克.gif",@"列支敦士登.gif",@"英国.gif",@"摩纳哥.gif",@"瑞士.gif",@"梵蒂冈 .gif",@"马耳他骑士团.jpg",@"拉脱维亚.gif",@"乌克兰.gif",@"法国.gif",@"俄罗斯.gif",@"德国.gif",@"保加利亚.gif",@"圣马力诺.gif",@"马耳他.gif",@"意大利.gif",@"西班牙.gif",@"葡萄牙.gif",@"芬兰.gif",@"丹麦.gif",@"塞尔维亚.gif",@"安道尔.gif",@"阿尔巴尼亚.gif",@"爱沙尼亚.gif",@"瑞典.gif",@"马其顿.gif",@"黑山.jpg",@"希腊.gif",@"奥地利.gif",@"摩尔多瓦.gif",@"罗马尼亚.gif",@"荷兰.gif",@"波斯尼亚和 黑塞哥维那.gif",@"斯洛文尼亚.gif",@"白俄罗斯.gif",@"挪威.gif",@"冰岛.gif",@"克罗地亚.gif",@"欧盟.jpg",@"匈牙利.gif",@"立陶宛.gif",@"卢森堡.gif",@"捷克.gif",@"比利时.gif",@"爱尔兰.gif"];
        
    for (NSInteger i = 0; i < imagesArry.count; i ++) {
                
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 60, 30);
        UIImage *image=[UIImage imageNamed:imagesArry[i]];
        [btn setImage:image  forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:24.];
//        btn.layer.cornerRadius = 15;
        btn.clipsToBounds = YES;
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [array addObject:btn];
        btn.tag=i;
        [_sphereView addSubview:btn];
    }
    [_sphereView setItems:array];
    [self.view addSubview:_sphereView];
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_sphereView timerStop];
    _sphereView = nil;
}


- (void)buttonPressed:(UIButton *)btn
{
    
    NSMutableArray *arry=[NSMutableArray new];
    [[ZSBFIleManger shareInstance].countryArray enumerateObjectsUsingBlock:^(NSArray*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx<8) {
            [arry addObjectsFromArray:obj];
        }
    }];
    
    NSMutableArray *newtemp =[NSMutableArray new];
    
    
    for (int i= 0; i<20; i++) {
        NSInteger stop =arry.count-1;
        NSInteger tag = arc4random()%stop;
        [newtemp addObject:arry[tag]];
    }
    
    
    [_sphereView timerStop];
    
    [UIView animateWithDuration:0.3 animations:^{
        btn.transform = CGAffineTransformMakeScale(2., 2.);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            btn.transform = CGAffineTransformMakeScale(1., 1.);
        } completion:^(BOOL finished) {
//            [_sphereView timerStart];
            ZSBListViewController *vc=[ZSBListViewController new];
            vc.dataArry=newtemp;
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }];
}

// 添加通用模糊效果
// image是图片，blur是模糊度
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur
{
    if (image==nil)
    {
        NSLog(@"error:为图片添加模糊效果时，未能获取原始图片");
        return nil;
    }
    //模糊度,
    if (blur < 0.025f) {
        blur = 0.025f;
    } else if (blur > 1.0f) {
        blur = 1.0f;
    }
    
    //boxSize必须大于0
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    NSLog(@"boxSize:%i",boxSize);
    //图像处理
    CGImageRef img = image.CGImage;
    //需要引入#import <Accelerate/Accelerate.h>
    
    //图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    //像素缓存
    void *pixelBuffer;
    
    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    // provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    // 第三个中间的缓存区,抗锯齿的效果
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    //    NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    //颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    //根据上下文，处理过的图片，重新组件
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    //CGColorSpaceRelease(colorSpace);   //多余的释放
    CGImageRelease(imageRef);
    return returnImage;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
