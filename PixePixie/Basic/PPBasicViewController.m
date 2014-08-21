#import "PPBasicViewController.h"

@interface PPBasicViewController ()
@end

@implementation PPBasicViewController

-(void)loadView
{
    [super loadView];
    
    SKView * selfView = [[SKView alloc] initWithFrame:self.view.bounds];
    self.view = selfView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    SKView * tempSKView = (SKView *)self.view;
    tempSKView.showsFPS = NO;
    tempSKView.showsNodeCount = NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
