
#import "PPBallViewController.h"

@interface PPBallViewController ()

@property (nonatomic) UIButton * btStart;
@property (nonatomic) SKView * skView;

@property (nonatomic) PPPixie * playerPixie;
@property (nonatomic) PPPixie * enemyPixie;

@end

@implementation PPBallViewController

-(id)init{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        
        _btStart = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btStart.frame = CGRectMake(100, 100, 100, 100);
        [_btStart setTitle:@"Start" forState:UIControlStateNormal];
        [_btStart addTarget:self action:@selector(startBattle) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_btStart];
        
        _playerPixie = [PPPixie birthPixieWith:PPElementTypePlant Generation:3];
        _enemyPixie = [PPPixie birthPixieWith:PPElementTypePlant Generation:2];
        
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

// 开始战斗画面
-(void)startBattle{
    
    _skView = [[SKView alloc] initWithFrame:CGRectMake(0, ([UIScreen mainScreen].bounds.size.height - 480)/2, 320, 480)];
    _skView.alpha = 0.0f;
    [self.view addSubview:_skView];
    
    //如果skView没有scene则添加scene
    if(!_skView.scene){
        PPBallScene * battleScene = [[PPBallScene alloc] initWithSize:_skView.bounds.size
                                                               PixieA:_playerPixie
                                                               PixieB:_enemyPixie];
        battleScene.scaleMode = SKSceneScaleModeAspectFill;
        [self.skView presentScene:battleScene];
    }
    
    // 播放显示动画
    [UIView animateWithDuration:1.0f animations:^(void){
        _skView.alpha = 1.0f;
    } completion:^(BOOL finished){
        
    }];
    
    /*
    [UIView animateWithDuration:0.5f
                          delay:5.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^(void){
                         _skView.alpha = 1.0f;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    */
    
    [_btStart removeFromSuperview];
    
}

@end