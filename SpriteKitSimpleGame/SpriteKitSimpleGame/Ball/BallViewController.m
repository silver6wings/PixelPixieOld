//
//  BallViewController.m
//  SpriteKitSimpleGame
//
//  Created by silver6wings on 14-3-9.
//  Copyright (c) 2014年 silver6wings. All rights reserved.
//

#import "BallViewController.h"
#import "BallScene.h"

@interface BallViewController ()

@property (nonatomic) SKView * skView;

@end


@implementation BallViewController

- (void)loadView{
    [super loadView];
    
    UIView * mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    mainView.backgroundColor = [UIColor whiteColor];
    self.view = mainView;
    
    self.skView = [[SKView alloc] initWithFrame:CGRectMake(0, ([UIScreen mainScreen].bounds.size.height - 480)/2, 320, 480)];
    [self.view addSubview:self.skView];
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    //如果skView没有scene
    if(!self.skView.scene){
        SKScene * scene = [BallScene sceneWithSize:self.skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        [self.skView presentScene:scene];
        
        self.skView.showsFPS = YES;
        self.skView.showsNodeCount = YES;
        self.skView.showsDrawCount = YES;
    }
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
