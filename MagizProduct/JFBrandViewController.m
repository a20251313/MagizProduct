//
//  JFBrandViewController.m
//  MagizProduct
//
//  Created by jingfuran on 14/12/9.
//  Copyright (c) 2014年 jingfuran. All rights reserved.
//

#import "JFBrandViewController.h"

@interface JFBrandViewController ()
{
    NSMutableArray  *arrayPicture;
    int             currentIndex;
    __weak IBOutlet UIImageView *mainImageView;
    __weak IBOutlet UIButton    *btnBack;
    __weak IBOutlet UIButton    *btnDirCenter;
    __weak IBOutlet UIButton    *btnDirRight;
    __weak IBOutlet UIView      *aniView;
}


@end

@implementation JFBrandViewController
@synthesize dataType;

-(IBAction)showNext:(id)sender
{
    if (currentIndex == arrayPicture.count-1)
    {
        return;
    }
    
    currentIndex++;
    if (currentIndex >= arrayPicture.count)
    {
        currentIndex = 0;
    }
    [UIView animateWithDuration:0.75 animations:^{aniView.alpha = 0;} completion:^(BOOL finish){
        
        
        [self refreshCurrentContent];
        [UIView animateWithDuration:0.75 animations:^{aniView.alpha = 1;}];
        // [self performSelectorOnMainThread:@selector(playMovie:) withObject:@"new" waitUntilDone:YES];
    }];
    
}
-(IBAction)showPrevices:(id)sender
{
    if (currentIndex == 0)
    {
        return;
    }
    
    currentIndex--;
    if (currentIndex < 0)
    {
        currentIndex = 0;
    }
    [UIView animateWithDuration:0.75 animations:^{aniView.alpha = 0;} completion:^(BOOL finish){
        
        
        [self refreshCurrentContent];
        [UIView animateWithDuration:0.75 animations:^{aniView.alpha = 1;}];
        // [self performSelectorOnMainThread:@selector(playMovie:) withObject:@"new" waitUntilDone:YES];
    }];
    
}

-(IBAction)back:(id)sender
{
   
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)refreshCurrentContent
{
    NSString    *strFileName = arrayPicture[currentIndex];
    mainImageView.image = [UIImage imageNamed:strFileName];
    
    switch (currentIndex)
    {
        case 0:
            btnBack.hidden = YES;
            btnDirCenter.hidden = NO;
            btnDirRight.hidden = YES;
            break;
        case 1:
            btnBack.hidden = NO;
            btnDirCenter.hidden = YES;
            btnDirRight.hidden = NO;
            break;
        case 2:
            btnBack.hidden = NO;
            btnDirCenter.hidden = YES;
            btnDirRight.hidden = NO;
            break;
            
        default:
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrayPicture = [[NSMutableArray alloc] init];
    currentIndex = 0;
    
    //品牌志
    if (self.dataType == 0)
    {
        [arrayPicture addObject:@"brand1.png"];
        [arrayPicture addObject:@"brand2.png"];
        [arrayPicture addObject:@"brand3.png"];
    }else if (self.dataType == 1)
    {
        //产品属性
        [arrayPicture addObject:@"property1.png"];
        [arrayPicture addObject:@"property2.png"];
        [arrayPicture addObject:@"property3.png"];
    }
   
    [self refreshCurrentContent];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
