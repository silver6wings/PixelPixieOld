//
//  BallViewController.m
//  SpriteKitSimpleGame
//
//  Created by silver6wings on 14-3-9.
//  Copyright (c) 2014年 silver6wings. All rights reserved.
//

#import "PPBallViewController.h"
#import "PPBallScene.h"
#import "PPPixie.h"

@interface PPBallViewController ()

@property (nonatomic) SKView * skView;
@property (nonatomic) PPPixie * player;
@property (nonatomic) PPPixie * enemy;

@end


@implementation PPBallViewController

- (id)init{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.skView = [[SKView alloc] initWithFrame:CGRectMake(0, ([UIScreen mainScreen].bounds.size.height - 480)/2, 320, 480)];
        [self.view addSubview:self.skView];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    //如果skView没有scene
    if(!self.skView.scene){
        SKScene * scene = [PPBallScene sceneWithSize:self.skView.bounds.size];
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
