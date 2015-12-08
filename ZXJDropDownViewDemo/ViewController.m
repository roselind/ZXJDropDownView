//
//  ViewController.m
//  ZXJDropDownViewDemo
//
//  Created by zhangxiaojing on 15/12/7.
//  Copyright © 2015年 张小静. All rights reserved.
//

#import "ViewController.h"
#import "ZXJDropDownView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet ZXJDropDownView *dropDownView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSMutableArray* arrContent =[[NSMutableArray alloc] init];
    [arrContent addObject:@"香蕉"];
    [arrContent addObject:@"茄子"];
    [arrContent addObject:@"葡萄"];
    [arrContent addObject:@"橘子"];
    [arrContent addObject:@"土豆"];
    self.dropDownView.contentItems = arrContent;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
