//
//  JFBrandViewController.m
//  MagizProduct
//
//  Created by jingfuran on 14/12/9.
//  Copyright (c) 2014年 jingfuran. All rights reserved.
//

#import "JFBrandViewController.h"
#import <MediaPlayer/MediaPlayer.h>

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

@property(nonatomic,strong)MPMoviePlayerController *mpcontroller;
@end

@implementation JFBrandViewController
@synthesize dataType;
@synthesize mpcontroller;
@synthesize viewCOntroller;

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


-(void)initView
{
    UIScrollView  *scrollView = (UIScrollView*)[self.view viewWithTag:1111];
    if (!scrollView)
    {
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
        scrollView.tag = 1111;
    }
    [scrollView setContentSize:CGSizeMake(1024* arrayPicture.count,768)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    
    for (int i = 0;i < arrayPicture.count;i++)
    {
        UIImageView *imageView = (UIImageView*)[scrollView viewWithTag:1000+i];
        if (imageView)
        {
            continue;
        }
        
   
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*1024, 0, 1024, 768)];
        imageView.tag =  1000+i;
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:arrayPicture[i]];
        
        [scrollView addSubview:imageView];
    }
    
    
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


-(IBAction)playMyMovie:(id)sender
{
    if (self.dataType == 1)
    {
        [self.viewCOntroller playMovie:@"property_play"];
    }else
    {
        [self.viewCOntroller playMovie:@"brand_play"];
    }
}




-(void)playMovie:(NSString *)fileName{
    
    //视频文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp4"];
    if ([fileName isEqualToString:@"dongxiang"])
    {
        path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"wmv"];
    }
    
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
    //[_moviePlayer prepareToPlay];
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
