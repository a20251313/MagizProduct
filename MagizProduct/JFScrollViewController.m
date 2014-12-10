//
//  JFScrollViewController.m
//  MagizProduct
//
//  Created by jingfuran on 14/12/9.
//  Copyright (c) 2014年 jingfuran. All rights reserved.
//

#import "JFScrollViewController.h"

@interface JFScrollViewController ()
{
   
}
@end

@implementation JFScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    

    // Do any additional setup after loading the view from its nib.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
    
    UIScrollView  *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    
    [scrollView setContentSize:CGSizeMake(1024, 1250)];
    scrollView.clipsToBounds = NO;
    scrollView.bounces = NO;
    
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 1250)];
    imageView.image = [UIImage imageNamed:@"product_list_detail.png"];
    [scrollView addSubview:imageView];
    
    [self.view  addSubview:scrollView];
    
    imageView.userInteractionEnabled = YES;
    
    UIButton  *btn = [[UIButton alloc] initWithFrame:CGRectMake((1024-65)/2+3, 1250-100+8, 65, 65)];
    [btn setBackgroundImage:[UIImage imageNamed:@"directory.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:btn];
   // [self.view bringSubviewToFront:btnBack];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(BOOL)prefersStatusBarHidden
{
    return YES;
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
