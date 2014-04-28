
#import "PPBallViewController.h"

@interface PPBallViewController ()

@property (nonatomic) UIButton * btStart;
@property (nonatomic) SKView * skView;

@property (nonatomic) PPPixie * player;
@property (nonatomic) PPPixie * enemy;

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

-(void)startBattle{
    
     _skView = [[SKView alloc] initWithFrame:CGRectMake(0, ([UIScreen mainScreen].bounds.size.height - 480)/2, 320, 480)];
    
     //如果skView没有scene
     if(!_skView.scene){
         SKScene * scene = [PPBallScene sceneWithSize:_skView.bounds.size];
         scene.scaleMode = SKSceneScaleModeAspectFill;
         [self.skView presentScene:scene];
     }
    _skView.alpha = 0.0f;
    [self.view addSubview:_skView];
    
    [UIView animateWithDuration:1.0f animations:^(void){
        _skView.alpha = 1.0f;
    } completion:^(BOOL finished){

    }];

    
    [_btStart removeFromSuperview];
}

@end