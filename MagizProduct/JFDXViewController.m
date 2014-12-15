//
//  JFDXViewController.m
//  MagizProduct
//
//  Created by jingfuran on 14/12/11.
//  Copyright (c) 2014年 jingfuran. All rights reserved.
//

#import "JFDXViewController.h"
#import "JFScrollViewController.h"
#import "JFDXforeignViewController.h"
@interface JFDXViewController ()

@end

@implementation JFDXViewController


-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)showForeignDetail:(id)sender
{
    JFDXforeignViewController  *controller = [[JFDXforeignViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    
   
}
-(IBAction)showMoreDetail:(id)sender
{
    JFScrollViewController *controller = [[JFScrollViewController alloc] init];
    controller.imageName = @"dongxiang_detail1.png";
    [self.navigationController pushViewController:controller animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
