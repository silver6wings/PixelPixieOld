//
//  ViewController.m
//  SpriteKitSimpleGame
//
//  Created by silver6wings on 14-2-25.
//  Copyright (c) 2014年 silver6wings. All rights reserved.
//

#import "PlaneViewController.h"
#import "PlaneScene.h"

@implementation PlaneViewController

-(void)loadView{
    [super loadView];
    
    SKView * skView = [[SKView alloc] initWithFrame:self.view.bounds];
    self.view = skView;
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    SKView * skView = (SKView *)self.view;
    //如果skView没有scene
    if(!skView.scene){
        SKScene * scene = [PlaneScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        [skView presentScene:scene];
        
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        skView.showsDrawCount = YES;
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end