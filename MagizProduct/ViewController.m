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
#import "JFPlayMovieViewController.h"
#import "JFBrandViewController.h"
#import "JFScrollViewController.h"
@interface ViewController ()
{
    UIImageView     *bgView;
    IBOutlet    UIView     *mainView;
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
   
    [self myMovieFinishedCallback:nil];
}


-(IBAction)touchToView:(UIButton*)sender
{
    switch (sender.tag)
    {
        case 1:
            break;
        case 2:
        {
            JFBrandViewController *controller = [[JFBrandViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 3:
        {
            JFScrollViewController  *controller = [[JFScrollViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            
            break;
        case 4:
        {
            JFBrandViewController *controller = [[JFBrandViewController alloc] init];
            controller.dataType = 1;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 5:
        {
            [self playMovie:@"method"];
            
        }
            break;
            
        default:
            break;
    }
}

-(void)playMovie:(NSString *)fileName{
    //视频文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp4"];
    //视频URL
    NSURL *url = [NSURL fileURLWithPath:path];
    
    if (url == nil)
    {
        NSLog(@"playMovie :%@ fail path:%@",fileName,path);
        return;
    }
    //视频播放对象
    MPMoviePlayerController *_moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    self.mpcontroller = _moviePlayer;
    [_moviePlayer prepareToPlay];
  
    _moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
    _moviePlayer.shouldAutoplay = NO;
    _moviePlayer.repeatMode = MPMovieRepeatModeNone;
    _moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    _moviePlayer.initialPlaybackTime = -1;
    [self.view addSubview:_moviePlayer.view];
    [_moviePlayer setFullscreen:YES animated:NO];
    // 注册一个播放结束的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myMovieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
    [_moviePlayer play];
    
    
    
    
    mainView.userInteractionEnabled = YES;
    mainView.alpha = 1;

}

-(void)stop:(id)sender
{
    NSLog(@"stop:%@",sender);
    [self.mpcontroller pause];
}

#pragma mark -------------------视频播放结束委托--------------------
/*
 @method 当视频播放完毕释放对象
 */
-(void)myMovieFinishedCallback:(NSNotification*)notify
{
    
 
    

    //销毁播放通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:nil];
    [self.mpcontroller.view removeFromSuperview];
    [self.mpcontroller stop];
    self.mpcontroller = nil;

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
