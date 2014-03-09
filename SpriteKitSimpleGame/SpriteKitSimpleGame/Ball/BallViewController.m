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
@end


@implementation BallViewController

- (void)loadView{
    [super loadView];
    
    SKView * skView = [[SKView alloc] initWithFrame:self.view.bounds];
    self.view = skView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    SKView * skView = (SKView *)self.view;
    
    //如果skView没有scene
    if(!skView.scene){
        SKScene * scene = [BallScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        [skView presentScene:scene];
        
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        skView.showsDrawCount = YES;
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
