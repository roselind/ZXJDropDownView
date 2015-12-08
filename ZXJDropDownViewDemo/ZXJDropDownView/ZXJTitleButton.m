//
//  ZXJTitleButton.m
//  ZXJLotteryTicket
//
//  Created by 张小静 on 15-6-9.
//  Copyright (c) 2015年 张小静. All rights reserved.
//

#import "ZXJTitleButton.h"
#import <Availability.h>

#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue]>=7.0)
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue]>=8.0)

@interface ZXJTitleButton()
@property (nonatomic,strong) UIFont *myFont;
@property (nonatomic,assign) BOOL isHaveImage;
@end

@implementation ZXJTitleButton
-(void)awakeFromNib{
    [super awakeFromNib];
}
-(instancetype) initWithCoder:(NSCoder *)aDecoder{
    if (self =[super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}
-(instancetype) initWithFrame:(CGRect)frame{
    if (self= [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
- (void) setUp{
    _imageW = 16;
    
    self.myFont =[UIFont systemFontOfSize:15];
    self.titleLabel.font =self.myFont;
    self.imageView.contentMode =UIViewContentModeCenter;
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX =5;
    CGFloat titleY =0;
    CGFloat titleH =contentRect.size.height;
    NSString *title =self.currentTitle;
    CGSize maxSize =CGSizeMake(MAXFLOAT, MAXFLOAT);
    
    NSMutableDictionary *muDic =[NSMutableDictionary dictionary];
    muDic[NSFontAttributeName] =self.myFont;
    CGFloat titleW =0;

#ifdef __IPHONE_7_0
    if (iOS7) {
        CGRect titleRect =[title boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:muDic context:nil];
        titleW =titleRect.size.width;
    }else{
        CGSize titleSize =[title sizeWithFont:self.myFont];
        titleW =titleSize.width ;
    }
#else
    //XCode 4
    CGSize titleSize =[title sizeWithFont:self.myFont];
    titleW =titleSize.width ;
#endif
    if ((contentRect.size.width -titleW)*0.5>16) {
        titleX =(contentRect.size.width -titleW)*0.5;
    }
    return CGRectMake(titleX, titleY, titleW, titleH);
    
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageY =0;
    CGFloat imageH =contentRect.size.height;
    CGFloat imageW=20;
    CGFloat imageX=contentRect.size.width -imageW;
    if (_imageW==0) {
       // imageH = 0;
    }
    return CGRectMake(imageX, imageY, _imageW, imageH);
}
@end
