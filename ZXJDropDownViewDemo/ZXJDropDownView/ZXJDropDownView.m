//
//  ZXJDropDowView.m
//  ZXJDropDownViewDemo
//
//  Created by zhangxiaojing on 15/12/7.
//  Copyright © 2015年 张小静. All rights reserved.
//

#import "ZXJDropDownView.h"

#import "ZXJTitleButton.h"
#import "ZXJDropDownCell.h"

#define ZXJTitleButtonHeight 30
#define ZXJContentCellHeight 30


static NSString *  tableCellIdentity = @"DropDownCellIdentity";

@interface ZXJDropDownView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak) ZXJTitleButton* titleButton;
@property (nonatomic,assign,getter=isOpen) BOOL open;
@property (nonatomic,weak) UITableView* contentTableView;
@end
@implementation ZXJDropDownView
@synthesize borderViewColor =_borderViewColor;
@synthesize contentItems = _contentItems;
-(UIColor *) borderViewColor {
    if (!_borderViewColor) {
        _borderViewColor  =[UIColor colorWithRed:67/255.0 green:175/255.0 blue:224/255.0 alpha:1.0];
    }
    return _borderViewColor;
}
-(NSMutableArray *) contentItems {
    if (!_contentItems) {
        _contentItems =[[NSMutableArray alloc]  init];
    }
    return _contentItems;
}
-(void) setUpViews{
   
    self.backgroundColor = [UIColor clearColor];
    UITableView* tableView =[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.scrollEnabled =NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.separatorColor  =self.borderViewColor ;
    [tableView registerNib:[UINib nibWithNibName:@"ZXJDropDownCell" bundle:nil] forCellReuseIdentifier:tableCellIdentity];
    
    tableView.dataSource =self;
    tableView.delegate  = self;
    [self addSubview:tableView];
    self.contentTableView  =tableView;
    [self.contentTableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    ZXJTitleButton* titleButton  =[[ ZXJTitleButton alloc] init];
    [titleButton setImage:[UIImage imageNamed:@"Arrowhead-Down"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"Arrowhead-Up"] forState:UIControlStateSelected];
    titleButton.layer.borderColor =self.borderViewColor.CGColor;
    titleButton.layer.borderWidth = 1;
    [titleButton setTitle:@"请选择" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [titleButton setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:titleButton];
    self.titleButton = titleButton;
    [self.titleButton addTarget:self action:@selector(titleButtonOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    


}
-(void) initData {    
     self.open =NO;
    _contentItems =[[NSMutableArray alloc]  init];
    _textViewTextColor = [UIColor blackColor];
}
-(instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
         [self initData];
        [self setUpViews];
       
    }
    return self;

}
-(instancetype) initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
         [self initData];
        [self setUpViews];
       
    }
    return self;
}
-(void) titleButtonOnClicked:(UIButton *) sender {
    
    __weak __typeof(&*self)weakSelf = self;
    
    if (!self.isOpen) {
//         self.contentTableView.frame = CGRectMake(0, 0, self.bounds.size.width,  ZXJTitleButtonHeight+ZXJContentCellHeight*self.contentItems.count);
        if (self.contentTableView.numberOfSections>0&&self.contentItems.count>0) {
            [self.contentTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
          self.contentTableView.hidden = NO;
    }
    [UIView animateWithDuration:0.25 animations:^{
        
        if (!weakSelf.isOpen) {
            sender.imageView.transform =CGAffineTransformMakeRotation(M_PI);
            weakSelf.open =YES;
            self.contentTableView.frame = CGRectMake(0, 0, self.bounds.size.width, ZXJTitleButtonHeight+ZXJContentCellHeight*self.contentItems.count);
        }else{
            sender.imageView.transform =CGAffineTransformIdentity;
            weakSelf.open =NO;
             self.contentTableView.frame = CGRectMake(0, 0, self.bounds.size.width, 0);
            
        }
     } completion:^(BOOL finished){
        //[self.contentView removeFromSuperview];
         if (!self.isOpen) {
               self.contentTableView.hidden = YES;
         }
    }];
    

   
}

-(void) layoutSubviews{
    [super layoutSubviews];
    self.titleButton.frame = CGRectMake(0, 0, self.bounds.size.width, ZXJTitleButtonHeight);
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentItems.count;
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return ZXJTitleButtonHeight;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ZXJContentCellHeight;
}
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* titleView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, ZXJTitleButtonHeight)];
    [titleView setBackgroundColor:[UIColor clearColor]];
    return titleView;
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    ZXJDropDownCell* cell =[tableView dequeueReusableCellWithIdentifier:tableCellIdentity];
    if (!cell) {
        cell =[[ZXJDropDownCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:tableCellIdentity];
       
    }
    cell.titleText = self.contentItems[indexPath.row];
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.titleButton setTitleColor:self.textViewTextColor forState:UIControlStateNormal];
    [self.titleButton setTitle: self.contentItems[indexPath.row] forState:UIControlStateNormal];
}
-(void) setBorderViewColor:(UIColor *)borderViewColor{
    self.titleButton.layer.borderColor = self.borderViewColor.CGColor;
}
-(void) setContentItems:(NSMutableArray *)contentItems{
    _contentItems = contentItems;
    [_contentTableView reloadData];
    self.frame = CGRectMake( self.frame.origin.x,self.frame.origin.y, self.bounds.size.height,ZXJTitleButtonHeight+ZXJContentCellHeight*self.contentItems.count);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
