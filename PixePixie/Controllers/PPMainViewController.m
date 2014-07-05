#import "PPMainViewController.h"

@interface PPMainViewController ()
{
    PPMainView *mainView;
    PPMonsterMainView *monsterMainView;
    PPKnapsackMainView *knapsackMainView;
    PPFightingMainView*fightingMainView;
    PPScheduleMainView *scheduleMainView;
    PPOthersMainView *othersMainView;
}
@end

@implementation PPMainViewController

NSString * userInfo[] = {
    @"Name",
    @"Tips",
    @"Coin",
    @"Magic Stone",
    @"friends"
};

NSString * menu[] = {
    @"Monster",
    @"Knapsack",
    @"Fighting",
    @"Schedule",
    @"Others"
};

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
//    if ([UIScreen mainScreen].bounds.size.height>500) {
//      [skViewMain setFrame:CGRectMake(0.0f, 44.0f, 320.0f, 480.0f)];
//    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (CurrentDeviceRealSize.height > 500) {
        skViewMain=[[SKView alloc] initWithFrame:CGRectMake(0.0f, 44.0f, 320.0f, 480.0f)];
    } else {
        skViewMain=[[SKView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)];
    }
    [skViewMain setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:skViewMain];
    
    menuAnimationTag = 0;
    
    backToMain=[[UIButton alloc] initWithFrame:CGRectMake(-50.0f, 54.0f, 50.0f,50.0f)];
    [backToMain setTitle:@"back" forState:UIControlStateNormal];
    [backToMain addTarget:self action:@selector(backToMainClick) forControlEvents:UIControlEventTouchUpInside];
    [skViewMain addSubview:backToMain];
    
    CGRect NormalViewRect = CGRectMake(0.0f, 44.0f, skViewMain.frame.size.width, skViewMain.frame.size.height - 88);
    
    #warning MainView这个你看我写的有没有问题
    mainView =[[PPMainView alloc] initWithFrame:NormalViewRect];
    [skViewMain addSubview:mainView];

    monsterMainView=[[PPMonsterMainView alloc] initWithFrame:NormalViewRect];
    [skViewMain addSubview:monsterMainView];
    
    knapsackMainView=[[PPKnapsackMainView alloc] initWithFrame:NormalViewRect];
    [skViewMain addSubview:knapsackMainView];
    
    fightingMainView=[[PPFightingMainView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,
                                                                          skViewMain.frame.size.width,
                                                                          skViewMain.frame.size.height)];
    [skViewMain addSubview:fightingMainView];
    
    scheduleMainView=[[PPScheduleMainView alloc] initWithFrame:NormalViewRect];
    [skViewMain addSubview:scheduleMainView];
    
    othersMainView=[[PPOthersMainView alloc] initWithFrame:NormalViewRect];
    [skViewMain addSubview:othersMainView];
    
    [skViewMain bringSubviewToFront:mainView];
    
    // Bar上方状态栏
    userInfoBar=[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
    [userInfoBar setBackgroundColor:[UIColor purpleColor]];
    [skViewMain addSubview:userInfoBar];
    
    for (int i = 0; i < PP_MENU_COUNT; i++) {
        UIButton  *userInfoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        switch (i) {
            case 0:
            {
                [userInfoBtn setFrame:CGRectMake(5.0f,2.0f, 100.0f,18.0f)];

                
            }
                break;
            case 1:
            {
                
                [userInfoBtn setFrame:CGRectMake(110.0f,2.0f, 100.0f,18.0f)];

            }
                break;
            case 2:
            {
                
                [userInfoBtn setFrame:CGRectMake(5.0f,24.0f, 100.0f,18.0f)];
            }
                break;
            case 3:
            {
                [userInfoBtn setFrame:CGRectMake(110,24.0f, 100.0f,18.0f)];

            }
                break;
            case 4:
            {
                [userInfoBtn setFrame:CGRectMake(220.0f,2, 80.0f,40.0f)];

            }
                break;
            default:
                break;
        }
        userInfoBtn.tag = PP_USER_BUTON_TAG + i;
        [userInfoBtn.titleLabel setFont:[UIFont systemFontOfSize:8]];
        [userInfoBtn addTarget:self action:@selector(userBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [userInfoBtn setTitle:userInfo[i] forState:UIControlStateNormal];
        [userInfoBar addSubview:userInfoBtn];
    }
    
    menuInfoBar = [[UIView alloc] initWithFrame:CGRectMake(0.0f, skViewMain.frame.size.height-44.0f, 320.0f, 44.0f)];
    [menuInfoBar setBackgroundColor:[UIColor purpleColor]];
    [skViewMain addSubview:menuInfoBar];
    
    for (int i=0; i<PP_MENU_COUNT; i++) {
        UIButton  *menuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [menuBtn setFrame:CGRectMake(i*skViewMain.frame.size.width/PP_MENU_COUNT,2.0f, 50.0f, 40.0f)];
        menuBtn.tag=PP_MENU_BUTON_TAG+i;
        [menuBtn.titleLabel setFont:[UIFont systemFontOfSize:8]];
        [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [menuBtn setTitle:menu[i] forState:UIControlStateNormal];
        [menuInfoBar addSubview:menuBtn];
    }
    
    if (CurrentDeviceRealSize.height > 500) {
        UIView *upBlackBar = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
        [upBlackBar setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:upBlackBar];
        
        UIView *downBlackBar = [[UIView alloc] initWithFrame:CGRectMake(0.0f, self.view.frame.size.height-44.0f, 320.0f, 44.0f)];
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

-(void)userBtnClick:(UIButton *)sender
{
}

-(void)menuBtnClick:(UIButton *)sender
{
    [UIView animateWithDuration:0.2
                     animations:^{
                         [backToMain setFrame:CGRectMake(0.0f,
                                                         backToMain.frame.origin.y,
                                                         backToMain.frame.size.width,
                                                         backToMain.frame.size.height)];
                     }
                     completion:^(BOOL finished){
                     }];
    
    switch (sender.tag-PP_MENU_BUTON_TAG) {
        case 0:
        {
            [monsterMainView setBackgroundColor:[UIColor redColor]];
            [skViewMain bringSubviewToFront:monsterMainView];
            
//            [self menuDownAnimation];
//
//            PPMonsterScene * monsterScene = [[PPMonsterScene alloc] initWithSize:CurrentDeviceRealSize];
//            monsterScene.scaleMode = SKSceneScaleModeAspectFill;
//            [skViewMain presentScene:monsterScene];
        }
            break;
        case 1:
        {
            [skViewMain bringSubviewToFront:knapsackMainView];

//            [self menuDownAnimation];
//
//            PPPacksackScene * packsackScene = [[PPPacksackScene alloc] initWithSize:CurrentDeviceRealSize];
//            packsackScene.scaleMode = SKSceneScaleModeAspectFill;
//            [skViewMain presentScene:packsackScene];
            
        }
            break;
        case 2:
        {
            [skViewMain bringSubviewToFront:fightingMainView];
            
//            [self menuDownAnimation];
//            PPPassNumberScene * passScene = [[PPPassNumberScene alloc] initWithSize:CurrentDeviceRealSize];
//            passScene.scaleMode = SKSceneScaleModeAspectFill;
//            [skViewMain presentScene:passScene];
        }
            break;
        case 3:
        {
            [skViewMain bringSubviewToFront:scheduleMainView];
            
//            [self menuDownAnimation];
//
//            
//            PPShopScene * shopScene = [[PPShopScene alloc] initWithSize:CurrentDeviceRealSize];
//            shopScene.scaleMode = SKSceneScaleModeAspectFill;
//            [skViewMain presentScene:shopScene];
        }
            break;
        case 4:
        {
            [skViewMain bringSubviewToFront:othersMainView];
            
//            [self menuDownAnimation];
//
//            PPSettingScene * ppSetScene = [[PPSettingScene alloc] initWithSize:CurrentDeviceRealSize];
//            ppSetScene.scaleMode = SKSceneScaleModeAspectFill;
//            [skViewMain presentScene:ppSetScene];
        }
            break;
            
        default:
            break;
    }
}

-(void)backToMainClick
{
//    if ([UIScreen mainScreen].bounds.size.height > 500) {
//
//    [skViewMain setFrame:CGRectMake(0.0f, 44.0f, 320.0f, 480.0f)];
//        
//    }
    
//    [skViewMain presentScene:mainScene];
//    [UIView animateWithDuration:0.1 animations:^{
//        
//        [backToMain setFrame:CGRectMake(-backToMain.frame.size.width, backToMain.frame.origin.y, backToMain.frame.size.width, backToMain.frame.size.height)];
//        
//    } completion:^(BOOL finished){}];
//    [self menuUpAnimation];
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
    [UIView animateWithDuration:0.05
                     animations:
     ^{
        UIButton *buttonTmp=(UIButton *)[skViewMain viewWithTag:PP_MENU_BUTON_TAG+menuAnimationTag];
        NSLog(@"height=%f",skViewMain.frame.size.height);
        [buttonTmp setFrame:CGRectMake(buttonTmp.frame.origin.x,2, buttonTmp.frame.size.width, buttonTmp.frame.size.height)];
     }
                     completion:
     ^(BOOL finished) {
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
        
//        UIButton *buttonTmp=(UIButton *)[skViewMain viewWithTag:PP_MENU_BUTON_TAG+menuAnimationTag];
//        [buttonTmp setFrame:CGRectMake(buttonTmp.frame.origin.x,buttonTmp.frame.size.height, buttonTmp.frame.size.width, buttonTmp.frame.size.height)];
        
    } completion:^(BOOL finished){
        menuAnimationTag++;
        if (menuAnimationTag<PP_MENU_COUNT) {
            [self performSelector:@selector(menuDownAnimation) withObject:nil];
            return ;
        }
        menuAnimationTag = 0;
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
