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

@property(nonatomic,strong)UIImageView *detailView;
@end

@implementation JFScrollViewController
@synthesize imageName;
@synthesize detailView;
@synthesize needProduct;

-(void)addButtonForProfuct
{
    if (!needProduct)
    {
        return;
    }
    CGFloat  fwidth = 170;
    CGFloat  fheight = 179;
    CGFloat  fxpoint = 79;
    CGFloat  fypoint = 434;
    CGFloat  fxsep = 165;
    CGFloat  fysep = 59;
    
    
    UIScrollView  *scrollView =(UIScrollView*) [self.view viewWithTag:10000];
    
   // int colum = 3;
    for (int i = 0;i < 3;i++)
    {
        for (int j = 0; j < 3; j++)
        {
            CGFloat  nowx = fxpoint+(fwidth+fxsep)*j;
            CGFloat  nowy = fypoint+(fheight+fysep)*i;
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(nowx, nowy, fwidth, fheight)];
            [button setBackgroundColor:[UIColor clearColor]];
            [button addTarget:self action:@selector(clickProduct:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:button];
            button.tag = i*3+j;
            
        }
    }
    
}



-(void)showImageViewWithTag:(NSUInteger)tag
{
    NSString    *strName = [NSString stringWithFormat:@"product_list_00%d.png",tag+1];
    UIImage  *image = [UIImage imageNamed:strName];
    
    self.detailView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    self.detailView.image = image;
    self.detailView.userInteractionEnabled = YES;
   // UIWindow  *window = [UIApplication sharedApplication].keyWindow;
    
   
    UIButton  *close = [[UIButton alloc] initWithFrame:CGRectMake(720, 48, 86, 80)];
    [close setBackgroundColor:[UIColor clearColor]];
    [close addTarget:self action:@selector(clickClose:) forControlEvents:UIControlEventTouchUpInside];
    [self.detailView addSubview:close];
    
    [self.view addSubview:self.detailView];
    
    self.detailView.alpha = 0;
    
    [UIView animateWithDuration:0.75 animations:^{self.detailView.alpha = 1;}];
    
    
}


-(void)clickClose:(id)sender
{
    
    
    [UIView animateWithDuration:0.75 animations:^{self.detailView.alpha = 0;} completion:^(BOOL finish){ [self.detailView removeFromSuperview];
        self.detailView = nil;}];
   
}

-(void)clickProduct:(UIButton*)sender
{
    [self showImageViewWithTag:sender.tag];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    
    
    if (imageName == nil)
    {
        self.imageName = @"product_list_detail.png";
    }
    
    UIImage  *image = [UIImage imageNamed:self.imageName];
    CGFloat  fheight = image.size.height/2;
    
    UIScrollView  *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    
    [scrollView setContentSize:CGSizeMake(1024, fheight)];
    scrollView.clipsToBounds = NO;
    scrollView.bounces = NO;
    scrollView.tag = 10000;
    
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, fheight)];
    imageView.image = image;
    [scrollView addSubview:imageView];
    
    [self.view  addSubview:scrollView];
    
    imageView.userInteractionEnabled = YES;
    
    UIButton  *btn = [[UIButton alloc] initWithFrame:CGRectMake((1024-65)/2+3, fheight-100+8, 65, 65)];
    [btn setBackgroundImage:[UIImage imageNamed:@"directory.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:btn];
    
    [self addButtonForProfuct];
    

    // Do any additional setup after loading the view from its nib.
}




-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
  
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
