//
//  PPMainViewController.m
//  PixelPixie
//
//  Created by xiefei on 5/19/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPMainViewController.h"
#import "PPPassNumberScroll.h"
@interface PPMainViewController ()
{
    PPMainScene *mainScene;
}
@end

@implementation PPMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
NSString * menu[]={
@"怪兽",
@"背包",
@"战斗",
@"商店",
@"设置"
};
- (void)viewDidLoad
{
    [super viewDidLoad];

    mainScene=[[PPMainScene alloc] initWithSize:[UIScreen mainScreen].bounds.size];
    mainScene.chooseTarget=self;
    mainScene.chooseCouterpartSel=@selector(counterpartEnter:);
    mainScene.scaleMode=SKSceneScaleModeFill;
    [skViewMain presentScene:mainScene];

    menuAnimationTag=0;
    
    for (int i=0; i<PP_MENU_COUNT; i++) {
        
        UIButton  *menuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [menuBtn setFrame:CGRectMake(i*skViewMain.frame.size.width/PP_MENU_COUNT, skViewMain.frame.size.height-64.0f, 64.0f, 64.0f)];
        menuBtn.tag=PP_MENU_BUTON_TAG+i;
        
        [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [menuBtn setTitle:menu[i] forState:UIControlStateNormal];
        [self.view addSubview:menuBtn];
        
    }
    
    // Do any additional setup after loading the view.
}
-(void)counterpartEnter:(id)obj
{
    
    PPTableView *ppTable1=[[PPTableView alloc] initWithFrame:CGRectMake(0.0f, 80, 320, 200)];
    ppTable1.choosePassNumber=self;
    ppTable1.tag=PP_PASSNUM_CHOOSE_TABLE_TAG;
    ppTable1.choosePassNumberSel=@selector(enterBattle:);
    NSArray *productInfoArray=[NSArray arrayWithObjects:@"关卡1",@"关卡2",@"关卡3",@"关卡4",@"关卡5",@"关卡6", nil];
    [ppTable1 ppsetTableViewWithData:productInfoArray];
    [self.view addSubview:ppTable1];
    
}
-(void)enterBattle:(NSNumber *)passNumber
{
    
    UIView *passNumView=[self.view viewWithTag:PP_PASSNUM_CHOOSE_TABLE_TAG];
    [passNumView removeFromSuperview];
    passNumber=nil;
    
    [UIView animateWithDuration:0.1 animations:^{
        
        [backToMain setFrame:CGRectMake(0.0f, backToMain.frame.origin.y, backToMain.frame.size.width, backToMain.frame.size.height)];
        
        
    } completion:^(BOOL finished){}];
    
    [self menuDownAnimation];

    PPBattleScene * battleScene;
    battleScene = [[PPBattleScene alloc] initWithSize:self.view.bounds.size];
    battleScene.scaleMode = SKSceneScaleModeAspectFill;
    
    [skViewMain presentScene:battleScene];
}
-(void)menuBtnClick:(UIButton *)sender
{
    [UIView animateWithDuration:0.1 animations:^{
    
        [backToMain setFrame:CGRectMake(0.0f, backToMain.frame.origin.y, backToMain.frame.size.width, backToMain.frame.size.height)];
        
       
    } completion:^(BOOL finished){}];
    

    switch (sender.tag-PP_MENU_BUTON_TAG) {
        case 0:
        {
            
            [self menuDownAnimation];

            PPMonsterScene * monsterScene = [[PPMonsterScene alloc] initWithSize:self.view.bounds.size];
            monsterScene.scaleMode = SKSceneScaleModeAspectFill;
            [skViewMain presentScene:monsterScene];
        }
            break;
        case 1:
        {
            
            [self menuDownAnimation];

            PPPacksackScene * packsackScene = [[PPPacksackScene alloc] initWithSize:self.view.bounds.size];
            packsackScene.scaleMode = SKSceneScaleModeAspectFill;
            [skViewMain presentScene:packsackScene];
            
        }
            break;
        case 2:
        {
            

            [self menuDownAnimation];
//            PPPixie * playerPixie = [PPPixie birthPixieWith:PPElementTypePlant Generation:2];
//            PPPixie * eneplayerPixie = [PPPixie birthPixieWith:PPElementTypePlant Generation:3];
//            PPBallScene * ballScene = [[PPBallScene alloc] initWithSize:self.view.bounds.size
//                                                                 PixieA:playerPixie
//                                                                 PixieB:eneplayerPixie];
            
            PPBattleScene * battleScene = [[PPBattleScene alloc] initWithSize:self.view.bounds.size];
            battleScene.scaleMode = SKSceneScaleModeAspectFill;
            
            [skViewMain presentScene:battleScene];
        }
            break;
        case 3:
        {
            [self menuDownAnimation];

            
            PPShopScene * shopScene = [[PPShopScene alloc] initWithSize:self.view.bounds.size];
            shopScene.scaleMode = SKSceneScaleModeAspectFill;
            [skViewMain presentScene:shopScene];
        }
            break;
        case 4:
        {
            [self menuDownAnimation];

            PPSettingScene * ppSetScene = [[PPSettingScene alloc] initWithSize:self.view.bounds.size];
            ppSetScene.scaleMode = SKSceneScaleModeAspectFill;
            [skViewMain presentScene:ppSetScene];
        }
            break;
            
        default:
            break;
    }
    
}
-(void)backToMainClick
{
    [skViewMain presentScene:mainScene];
    [UIView animateWithDuration:0.1 animations:^{
        
        [backToMain setFrame:CGRectMake(-backToMain.frame.size.width, backToMain.frame.origin.y, backToMain.frame.size.width, backToMain.frame.size.height)];
        
        
    } completion:^(BOOL finished){}];
    [self menuUpAnimation];
}
-(void)menuUpAnimation
{
    
    [self performSelector:@selector(upMenuBtn) withObject:nil];

}
-(void)menuDownAnimation
{
    [self performSelector:@selector(downMenuBtn) withObject:nil];
 
}
-(void)upMenuBtn
{
    [UIView animateWithDuration:0.1 animations:^{
        
        UIButton *buttonTmp=(UIButton *)[skViewMain viewWithTag:PP_MENU_BUTON_TAG+menuAnimationTag];
        [buttonTmp setFrame:CGRectMake(buttonTmp.frame.origin.x, skViewMain.frame.size.height-64.0f, buttonTmp.frame.size.width, buttonTmp.frame.size.height)];
        
    } completion:^(BOOL finished){
        menuAnimationTag++;
        if (menuAnimationTag<PP_MENU_COUNT) {
            [self performSelector:@selector(menuUpAnimation) withObject:nil];
            return ;
        }
        menuAnimationTag=0;
        
    }];
}
-(void)downMenuBtn
{
    [UIView animateWithDuration:0.1 animations:^{
        
        UIButton *buttonTmp=(UIButton *)[skViewMain viewWithTag:PP_MENU_BUTON_TAG+menuAnimationTag];
        [buttonTmp setFrame:CGRectMake(buttonTmp.frame.origin.x, buttonTmp.frame.origin.y+buttonTmp.frame.size.height, buttonTmp.frame.size.width, buttonTmp.frame.size.height)];
        
    } completion:^(BOOL finished){
        menuAnimationTag++;
        if (menuAnimationTag<PP_MENU_COUNT) {
             [self performSelector:@selector(menuDownAnimation) withObject:nil];
            return ;
        }
        menuAnimationTag=0;
        
    }];
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
