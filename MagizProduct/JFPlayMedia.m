//
//  JFPlayMedia.m
//  MagizProduct
//
//  Created by jingfuran on 14/12/15.
//  Copyright (c) 2014年 jingfuran. All rights reserved.
//

#import "JFPlayMedia.h"
#import <MediaPlayer/MediaPlayer.h>
static JFPlayMedia *shareMedia = nil;



@interface JFPlayMedia ()
{
}
@property(nonatomic,strong)MPMoviePlayerController *mpcontroller;
@end
@implementation JFPlayMedia
@synthesize mpcontroller;


+(id)shareInstance
{
    if (shareMedia == nil)
    {
        shareMedia = [[JFPlayMedia alloc] init];
    }
    return shareMedia;
}


+(void)playMovie:(NSString *)fileName
{
    [[JFPlayMedia shareInstance] playMovie:fileName];
}

+(void)myMovieFinishedCallback:(NSNotification*)notify
{
    [[JFPlayMedia shareInstance] myMovieFinishedCallback:notify];
}

-(void)playMovie:(NSString *)fileName{
    
    NSString    *strSuf =   @"mp4";
    NSString    *strPre = fileName;
    
    if ([fileName rangeOfString:@"."].location != NSNotFound )
    {
        NSArray     *arrayData = [fileName componentsSeparatedByString:@"."];
        if (arrayData.count >= 2)
        {
            strSuf = [arrayData lastObject];
        }
        
        strPre = [arrayData firstObject];
        
    }
    //视频文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:strPre ofType:strSuf];
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
    UIWindow  *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_moviePlayer.view];
    [_moviePlayer setFullscreen:YES animated:NO];
    // 注册一个播放结束的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myMovieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
    [_moviePlayer play];
    
    
    

    
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


@end
