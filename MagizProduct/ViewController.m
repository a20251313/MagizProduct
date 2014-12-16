//
//  ViewController.m
//  MagizProduct
//
//  Created by jingfuran on 14/12/9.
//  Copyright (c) 2014年 jingfuran. All rights reserved.
//

#import "ViewController.h"
#import "CABasicAnimation+someAniForProp.h"
#import <MediaPlayer/MediaPlayer.h>
#import "JFBrandViewController.h"
#import "JFScrollViewController.h"
#import "JFDXViewController.h"
#import "JFPlayMethodViewController.h"
#import "JFPlayMedia.h"
#import "publidDefine.h"
@interface ViewController ()
{
    UIImageView     *bgView;
    IBOutlet    UIView     *mainView;
    IBOutlet    UIButton     *btnDongxiang;
    IBOutlet    UIButton     *btnTown;
}

@property(nonatomic,strong)MPMoviePlayerController *mpcontroller;
@end

@implementation ViewController
@synthesize mpcontroller;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
   // CGFloat fwidth = [UIScreen mainScreen].bounds.size.width;
 //   CGFloat fheight = [UIScreen mainScreen].bounds.size.height;
    bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    bgView.image = [UIImage imageNamed:@"bg.png"];
    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBgView:)];
    [bgView addGestureRecognizer:tap];
    
    mainView.userInteractionEnabled = NO;
    mainView.alpha = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];

    
    if (OLDVERSION)
    {
        btnDongxiang.hidden = YES;
        btnTown.hidden = YES;
    }
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)didEnterBackground:(id)sender
{
    
    mainView.userInteractionEnabled = NO;
    mainView.alpha = 0;
    bgView.alpha = 1;
    if (self.navigationController.viewControllers.lastObject != self)
    {
         [self.navigationController popToRootViewControllerAnimated:NO];
    }
   
    [JFPlayMedia myMovieFinishedCallback:nil];
}




-(void)playMovie:(NSString *)fileName
{
    [JFPlayMedia playMovie:fileName];
    mainView.userInteractionEnabled = YES;
    mainView.alpha = 1;
}

-(IBAction)touchToView:(UIButton*)sender
{
    switch (sender.tag)
    {
        case 1:
        {
            //动向
            JFDXViewController *controller = [[JFDXViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            
        }
            break;
        case 2:
        {
            //品牌志
            JFBrandViewController *controller = [[JFBrandViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];

        }
            break;
        case 3:
        {   //产品列表
            JFScrollViewController  *controller = [[JFScrollViewController alloc] init];
            if (!OLDVERSION)
            {
                 controller.needProduct = YES; 
            }
          
            [self.navigationController pushViewController:controller animated:YES];
        }
            
            break;
        case 4:
        {//产品属性
            JFBrandViewController *controller = [[JFBrandViewController alloc] init];
            controller.dataType = 1;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 5:
        {
            if (OLDVERSION)
            {
                [self playMovie:@"method.mp4"];
                return;
            }
            //玩法
            JFPlayMethodViewController *play = [[JFPlayMethodViewController alloc] init];
            [self.navigationController pushViewController:play animated:YES];
            
        }
            break;
        case 6:
        {
            //小镇
            JFScrollViewController  *controller = [[JFScrollViewController alloc] init];
            controller.imageName = @"PK0.png";
            [self.navigationController pushViewController:controller animated:YES];
            
        }
            break;
            
        default:
            break;
    }
}






-(void)clickBgView:(id)sender
{
    
    [UIView animateWithDuration:0.75 animations:^{bgView.alpha = 0;} completion:^(BOOL finish){
       // mainView.alpha = 1;
        [self playMovie:@"new"];
       // [self performSelectorOnMainThread:@selector(playMovie:) withObject:@"new" waitUntilDone:YES];
    }];
    
    
    
    
}


-(BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
