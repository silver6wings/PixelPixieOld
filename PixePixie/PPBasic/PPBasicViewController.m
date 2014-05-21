//
//  PPBasicViewController.m
//  PixelPixie
//
//  Created by xiefei on 5/19/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPBasicViewController.h"

@interface PPBasicViewController ()
{
   
}
@end

@implementation PPBasicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)loadView
{
    [super loadView];
    SKView *aView=[[SKView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view=aView;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    skViewMain = (SKView *)self.view;
    skViewMain.showsFPS = YES;
    skViewMain.showsNodeCount = YES;
    
    
    backToMain=[[UIButton alloc] initWithFrame:CGRectMake(-50.0f, 5.0f, 50.0f,50.0f)];
    [backToMain setTitle:@"back" forState:UIControlStateNormal];
    [backToMain addTarget:self action:@selector(backToMainClick) forControlEvents:UIControlEventTouchUpInside];
    [skViewMain addSubview:backToMain];
    
    // Do any additional setup after loading the view.
}
-(void)backToMainClick
{
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
