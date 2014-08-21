#import "PPBasicViewController.h"

@interface PPBasicViewController ()
@end

@implementation PPBasicViewController

-(void)loadView
{
    [super loadView];
    
    SKView * mainView = [[SKView alloc] initWithFrame:self.view.bounds];
    self.view = mainView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    skViewMain = (SKView *)self.view;
    skViewMain.showsFPS = NO;
    skViewMain.showsNodeCount = NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
