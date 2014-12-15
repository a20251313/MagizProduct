//
//  JFPlayMethodViewController.m
//  MagizProduct
//
//  Created by jingfuran on 14/12/15.
//  Copyright (c) 2014年 jingfuran. All rights reserved.
//

#import "JFPlayMethodViewController.h"
#import "JFPlayMedia.h"
@interface JFPlayMethodViewController ()

@end

@implementation JFPlayMethodViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)playMethodMovie:(UIButton*)sender
{
    int tag = (int)sender.tag;
    NSString *moviename = [NSString stringWithFormat:@"play_Method0%d.mp4",tag+1];
    [JFPlayMedia playMovie:moviename];
}
-(IBAction)back:(UIButton*)sender
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
