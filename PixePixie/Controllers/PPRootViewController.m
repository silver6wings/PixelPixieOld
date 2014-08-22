
#import "PPRootViewController.h"

@interface PPRootViewController ()
{
    int menuAnimationTag;
    UIView * userInfoBar;
    UIView * menuInfoBar;
    SKView * skViewMain;
    UIButton *backToMain;
    
    PPMonsterMainView *monsterMainView;
    PPKnapsackMainView *knapsackMainView;
    PPFightingMainView*fightingMainView;
    PPScheduleMainView *scheduleMainView;
    PPOthersMainView *othersMainView;
}
@end

@implementation PPRootViewController

NSString * userInfo[] = {
    @"Name",
    @"Tips",
    @"Coin",
    @"Magic Stone",
    @"friends"
};

NSString * menu[] = {
    @"精灵",
    @"背包",
    @"战斗",
    @"日常",
    @"其它"
};


- (void)viewDidLoad
{
    [super viewDidLoad];
    
#warning 这里删掉没问题吧？
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToMainScene:) name:PP_BACK_TO_MAIN_VIEW object:nil];
    
    skViewMain=[[SKView alloc] initWithFrame:CGRectMake(0.0f, PP_FIT_TOP_SIZE, 320.0f, 480.0f)];
    [self.view addSubview:skViewMain];
    
    NSString * isNotFirstEnter = [PPCommonTool contentFromUserDefaultKey:PP_FIRST_LOG_IN];
    
    if ([isNotFirstEnter isEqualToString:@"1"]) {
        [self enterMainScene];
    } else {
        
        UIView *contentView=[[UIView alloc] initWithFrame:CGRectMake(10, 100, 300, 200)];
        [contentView setBackgroundColor:[UIColor cyanColor]];
        contentView.tag=PP_CONTENT_TAG;
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 40)];
        [titleLabel setBackgroundColor:[UIColor yellowColor]];
        [titleLabel setText:@"下面请告诉我你的名字："];
        [contentView addSubview:titleLabel];
    
        UITextField *textFiled=[[UITextField alloc] initWithFrame:CGRectMake(40.0f, 50.0f, 150, 50)];
        [textFiled addTarget:self action:@selector(textFieldResign:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [textFiled setBackgroundColor:[UIColor redColor]];
        [contentView addSubview:textFiled];
        
        
        UIButton *buttonConfirm=[UIButton buttonWithType:UIButtonTypeCustom];
        [buttonConfirm setTitle:@"确定" forState:UIControlStateNormal];
        [buttonConfirm setBackgroundColor:[UIColor brownColor]];
        [buttonConfirm addTarget:self action:@selector(textInputConfirmClick) forControlEvents:UIControlEventTouchUpInside];
        [buttonConfirm setFrame:CGRectMake(120, 120, 60, 40)];
        [contentView addSubview:buttonConfirm];
        
        [self.view addSubview:contentView];
    }
}

-(void)textInputConfirmClick
{
    UIView *contentView = [self.view viewWithTag:PP_CONTENT_TAG];
    if (contentView != nil)
    {
        [contentView removeFromSuperview];
    }
    
    
    UIView *viewContent=[[UIView alloc] initWithFrame:CGRectMake(0.0f, 20.0, 320.0f, 400)];
    viewContent.tag = PP_CHOOSE_PET_CONTENT_TAG;
    [viewContent setBackgroundColor:[UIColor magentaColor]];
    
    
    NSDictionary * dictUserPets=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PetsChooseInfo" ofType:@"plist"]];
    
    
    PPChoosePetScrollView *petsScroll=[[PPChoosePetScrollView alloc] initWithFrame:CGRectMake(20.0f, 20.0f, 280.0f, 250.0f)];
    [petsScroll setBackgroundColor:[UIColor cyanColor]];
    [petsScroll setSCrollWith:dictUserPets];
    [viewContent addSubview:petsScroll];
    
    
    UILabel *labelEnemyInfo=[[UILabel alloc] initWithFrame:CGRectMake(20, 280, 280, 60)];
    [labelEnemyInfo setText:@"怪物信息"];
    [labelEnemyInfo setBackgroundColor:[UIColor whiteColor]];
    [labelEnemyInfo setTextAlignment:NSTextAlignmentCenter];
    [viewContent addSubview:labelEnemyInfo];
    
    
    UILabel *labelConfrimInfo=[[UILabel alloc] initWithFrame:CGRectMake(labelEnemyInfo.frame.origin.x, labelEnemyInfo.frame.origin.y+labelEnemyInfo.frame.size.height+10.0f, 200, 40)];
    [labelConfrimInfo setFont:[UIFont boldSystemFontOfSize:11]];
    [labelConfrimInfo setTextColor:[UIColor blackColor]];
    [labelConfrimInfo setText:@"是否选择此怪物作为你的第一个伙伴？"];
    [labelConfrimInfo setTextAlignment:NSTextAlignmentCenter];
    [viewContent addSubview:labelConfrimInfo];
    
    
    UIButton *petsChooseCofirmBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [petsChooseCofirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [petsChooseCofirmBtn setBackgroundColor:[UIColor blackColor]];
    [petsChooseCofirmBtn setFrame:CGRectMake(labelConfrimInfo.frame.origin.x+labelConfrimInfo.frame.size.width+20.0f,labelConfrimInfo.frame.origin.y,40.0f, 40)];
    [petsChooseCofirmBtn addTarget:self action:@selector(petsChooseCofirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [viewContent addSubview:petsChooseCofirmBtn];
    

    [self.view addSubview:viewContent];
}

-(void)petsChooseCofirmBtnClick:(UIButton *)sender
{
    UIView *contentView=[self.view viewWithTag:PP_CHOOSE_PET_CONTENT_TAG];
    if (contentView) {
        [contentView removeFromSuperview];
    }
    
    [PPCommonTool setContent:@"1" forContentKey:PP_FIRST_LOG_IN];
    [self enterMainScene];
}

-(void)textFieldResign:(UITextField *)textField
{
    [textField resignFirstResponder];
}

-(void)enterMainScene
{
    menuAnimationTag = 0;
    
    CGRect NormalViewRect = CGRectMake(0.0f, 44.0f, skViewMain.frame.size.width, skViewMain.frame.size.height - 44.0f*2);
    
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
    
    [skViewMain bringSubviewToFront:monsterMainView];
    
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
        [menuBtn.titleLabel setFont:[UIFont systemFontOfSize:8]];
        [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [menuBtn setTitle:menu[i] forState:UIControlStateNormal];
        menuBtn.tag = PP_MENU_BUTON_TAG + i;
        [menuInfoBar addSubview:menuBtn];
    }
    
    [self changeMenuState:0];

    
    // 添加上下两个条
    if (CurrentDeviceRealSize.height > 500) {
        UIView *upBlackBar = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
        [upBlackBar setBackgroundColor:[UIColor blackColor]];
        [self.view addSubview:upBlackBar];
        
        UIView *downBlackBar = [[UIView alloc] initWithFrame:CGRectMake(0.0f, self.view.frame.size.height-44.0f, 320.0f, 44.0f)];
        [downBlackBar setBackgroundColor:[UIColor blackColor]];
        [self.view addSubview:downBlackBar];
    }
    
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

/*
-(void)backToMainScene:(NSNotification *)notifi
{
   
    [skViewMain bringSubviewToFront:mainView];
    if ([[notifi object] isEqualToString:PP_BACK_TO_MAIN_VIEW_FIGHTING]) {
        [skViewMain bringSubviewToFront:menuInfoBar];
        [skViewMain bringSubviewToFront:userInfoBar];
    }
}
*/

-(void)enterBattle:(NSNumber *)passNumber
{
    UIView *passNumView=[self.view viewWithTag:PP_PASSNUM_CHOOSE_TABLE_TAG];
    [passNumView removeFromSuperview];
    passNumber=nil;
    
    [UIView animateWithDuration:0.1 animations:^{
        [backToMain setFrame:CGRectMake(0.0f, backToMain.frame.origin.y, backToMain.frame.size.width, backToMain.frame.size.height)];
    } completion:^(BOOL finished){}];
    
    [self menuDownAnimation];

    PPHurdleReadyScene * battleScene;
    battleScene = [[PPHurdleReadyScene alloc] initWithSize:CurrentDeviceRealSize];
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
    
   
    [self changeMenuState:(int)sender.tag - PP_MENU_BUTON_TAG];
    
    switch (sender.tag - PP_MENU_BUTON_TAG) {
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
-(void)changeMenuState:(int)index
{
    for (int i=0; i<PP_MENU_COUNT; i++) {
        UIButton *buttonMenuTmp=(UIButton *)[menuInfoBar viewWithTag:PP_MENU_BUTON_TAG+i];
        if (i==index) {
            [buttonMenuTmp setBackgroundColor:[UIColor blueColor]];
        }else
        {
            [buttonMenuTmp setBackgroundColor:[UIColor purpleColor]];
        }
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
        if (menuAnimationTag < PP_MENU_COUNT) {
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
