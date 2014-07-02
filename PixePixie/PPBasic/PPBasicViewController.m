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
    if ([UIScreen mainScreen].bounds.size.height>500) {
        SKView *mainView=[[SKView alloc] initWithFrame:CGRectMake(0.0f, 44.0f, 320.0f, 480.0f)];
        self.view = mainView;
    }else
    {
        SKView *mainView=[[SKView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)];
        self.view = mainView;
    }
   
    
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    skViewMain = (SKView *)self.view;
    skViewMain.showsFPS = NO;
    skViewMain.showsNodeCount = NO;

    
    backToMain=[[UIButton alloc] initWithFrame:CGRectMake(-50.0f, 10.0f, 50.0f,50.0f)];
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
