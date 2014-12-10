//
//  JFPlayMovieViewController.m
//  MagizProduct
//
//  Created by jingfuran on 14/12/9.
//  Copyright (c) 2014年 jingfuran. All rights reserved.
//

#import "JFPlayMovieViewController.h"
#import <MediaPlayer/MediaPlayer.h>
@interface JFPlayMovieViewController ()
{
    BOOL    isPlayed;
}
@property(nonatomic,strong)MPMoviePlayerController *mpcontroller;

@end

@implementation JFPlayMovieViewController
@synthesize mpcontroller;
- (void)viewDidLoad {
    [super viewDidLoad];
    isPlayed = NO;
  
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
 
    

    
    // Do any additional setup after loading the view.
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!isPlayed)
    {
        [self playMovie:@"method"];
        isPlayed = YES;
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
                                               object:_moviePlayer];
    [_moviePlayer play];
    
    

    
}


#pragma mark -------------------视频播放结束委托--------------------
/*
 @method 当视频播放完毕释放对象
 */
-(void)myMovieFinishedCallback:(NSNotification*)notify
{
    
    
    
    
    NSLog(@"myMovieFinishedCallback:%@",notify);
    //视频播放对象
    /*MPMoviePlayerController* theMovie = [notify object];
    //销毁播放通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:theMovie];
    [self.mpcontroller.view removeFromSuperview];
    [self.mpcontroller stop];
    self.mpcontroller = nil;*/
    
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
