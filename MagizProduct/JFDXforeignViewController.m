//
//  JFDXforeignViewController.m
//  MagizProduct
//
//  Created by jingfuran on 14/12/15.
//  Copyright (c) 2014年 jingfuran. All rights reserved.
//

#import "JFDXforeignViewController.h"
#import "JFPlayMedia.h"
@interface JFDXforeignViewController ()

@end

@implementation JFDXforeignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)showMovie:(id)sender
{
    [JFPlayMedia playMovie:@"dongxiang_area"];
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
