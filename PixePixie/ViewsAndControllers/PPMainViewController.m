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
-(void)viewDidAppear:(BOOL)animated
{
//    if ([UIScreen mainScreen].bounds.size.height>500) {
//
//    [skViewMain setFrame:CGRectMake(0.0f, 44.0f, 320.0f, 480.0f)];
//    }

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    if (CurrentDeviceRealSize.height>500) {
        skViewMain=[[SKView alloc] initWithFrame:CGRectMake(0.0f, 88.0f, 320.0f, 392.0f)];

    }else
    {
        skViewMain=[[SKView alloc] initWithFrame:CGRectMake(0.0f, 44.0f, 320.0f, 392.0f)];

    }
    [skViewMain setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:skViewMain];
    
    
    
    mainScene=[[PPMainScene alloc] initWithSize:skViewMain.frame.size];
    mainScene.chooseTarget=self;
    mainScene.chooseCouterpartSel=@selector(counterpartEnter:);
    CGFloat dicrect = 44.0f;
    
    if (mainScene.frame.size.height<500) {
        dicrect = 0.0f;
    }
    [skViewMain presentScene:mainScene];
    NSLog(@"height=%f",mainScene.frame.size.height);
    

    
    menuAnimationTag=0;
    
    
    for (int i=0; i<PP_MENU_COUNT; i++) {
        
        
        UIButton  *menuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [menuBtn setFrame:CGRectMake(i*skViewMain.frame.size.width/PP_MENU_COUNT, skViewMain.frame.size.height-64.0f-dicrect, 64.0f, 64.0f)];
        menuBtn.tag=PP_MENU_BUTON_TAG+i;
        [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [menuBtn setTitle:menu[i] forState:UIControlStateNormal];
        [skViewMain addSubview:menuBtn];
        
        
    }
    
    

    backToMain=[[UIButton alloc] initWithFrame:CGRectMake(-50.0f, 10.0f, 50.0f,50.0f)];

    [backToMain setTitle:@"back" forState:UIControlStateNormal];
    [backToMain addTarget:self action:@selector(backToMainClick) forControlEvents:UIControlEventTouchUpInside];
    [skViewMain addSubview:backToMain];
    
    
    
    if (CurrentDeviceRealSize.height>500) {
        
    UIView *upBlackBar=[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
    [upBlackBar setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:upBlackBar];
    
    
    UIView *downBlackBar=[[UIView alloc] initWithFrame:CGRectMake(0.0f, self.view.frame.size.height-44.0f, 320.0f, 44.0f)];
    [downBlackBar setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:downBlackBar];
        
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
    battleScene = [[PPBattleScene alloc] initWithSize:CurrentDeviceRealSize];
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

            PPMonsterScene * monsterScene = [[PPMonsterScene alloc] initWithSize:CurrentDeviceRealSize];
            monsterScene.scaleMode = SKSceneScaleModeAspectFill;
            [skViewMain presentScene:monsterScene];
        }
            break;
        case 1:
        {
            
            [self menuDownAnimation];

            PPPacksackScene * packsackScene = [[PPPacksackScene alloc] initWithSize:CurrentDeviceRealSize];
            packsackScene.scaleMode = SKSceneScaleModeAspectFill;
            [skViewMain presentScene:packsackScene];
            
        }
            break;
        case 2:
        {

            [self menuDownAnimation];
            PPPassNumberScene * passScene = [[PPPassNumberScene alloc] initWithSize:CurrentDeviceRealSize];
            passScene.scaleMode = SKSceneScaleModeAspectFill;
            [skViewMain presentScene:passScene];
        }
            break;
        case 3:
        {
            [self menuDownAnimation];

            
            PPShopScene * shopScene = [[PPShopScene alloc] initWithSize:CurrentDeviceRealSize];
            shopScene.scaleMode = SKSceneScaleModeAspectFill;
            [skViewMain presentScene:shopScene];
        }
            break;
        case 4:
        {
            [self menuDownAnimation];

            PPSettingScene * ppSetScene = [[PPSettingScene alloc] initWithSize:CurrentDeviceRealSize];
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
    
//    if ([UIScreen mainScreen].bounds.size.height>500) {
//
//    [skViewMain setFrame:CGRectMake(0.0f, 44.0f, 320.0f, 480.0f)];
//        
//    }
    
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
    [UIView animateWithDuration:0.05 animations:^{
        
        UIButton *buttonTmp=(UIButton *)[skViewMain viewWithTag:PP_MENU_BUTON_TAG+menuAnimationTag];
        NSLog(@"height=%f",skViewMain.frame.size.height);
        if(CurrentDeviceRealSize.height>500)
        {
            
           [buttonTmp setFrame:CGRectMake(buttonTmp.frame.origin.x, skViewMain.frame.size.height-108.0f, buttonTmp.frame.size.width, buttonTmp.frame.size.height)];
            
        }else
        {
            [buttonTmp setFrame:CGRectMake(buttonTmp.frame.origin.x, skViewMain.frame.size.height-64.0f, buttonTmp.frame.size.width, buttonTmp.frame.size.height)];

        }
        
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
    
    [UIView animateWithDuration:0.05 animations:^{
        
        UIButton *buttonTmp=(UIButton *)[skViewMain viewWithTag:PP_MENU_BUTON_TAG+menuAnimationTag];
        [buttonTmp setFrame:CGRectMake(buttonTmp.frame.origin.x, self.view.frame.size.height+buttonTmp.frame.size.height, buttonTmp.frame.size.width, buttonTmp.frame.size.height)];
        
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
