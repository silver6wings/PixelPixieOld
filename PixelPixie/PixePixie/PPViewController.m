//
//  ViewController.m
//  PixePixie
//
//  Created by silver6wings on 14-3-5.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import "PPViewController.h"
#import "PPScenes.h"
#import "PPElement.h"

@implementation PPViewController

-(id)init{
    
    if (self = [super init]) {
    }
    return self;
}

-(void)loadView{
    [super loadView];
    
    SKView * skView = [[SKView alloc] initWithFrame:CGRectZero];
    self.view = skView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [MyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
