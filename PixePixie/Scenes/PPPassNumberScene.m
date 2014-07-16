
@interface PPPassNumberScene()
{}
@property (retain, nonatomic) PPPassNumberScroll *menu;
@end

@implementation PPPassNumberScene
@synthesize menu;

-(void)willMoveFromView:(SKView *)view
{
    self.menu.hidden = YES;
    [self.menu removeFromSuperview];
}

- (id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        
        [self setBackTitleText:@"世界地图" andPositionY:450.0f];

    }
    return self;
}

- (void)didMoveToView:(SKView *)view
{
    // Called immediately after a scene is presented by a view.
    [super didMoveToView:view];
    self.backgroundColor = [UIColor grayColor];
    
    PPPassNumberScroll *pppassView=[[PPPassNumberScroll alloc] initWithFrame:CGRectMake(0.0, 150.0, 320.0f, 200)];
    NSDictionary *dictPassInfo=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PassInfo" ofType:@"plist"]];
    pppassView.target=self;
    pppassView.selector=@selector(chooseSpriteToBattle:);
    [pppassView creatPassNumberScroll:dictPassInfo with:self];
    [pppassView setBackgroundColor:[UIColor redColor]];
    self.menu=pppassView;
    self.menu.scene=self;
    [self.view addSubview:self.menu];
    
    
    
    
}

-(void)chooseSpriteToBattle:(NSNumber *)passName
{
    NSDictionary *dictPassInfo = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PassInfo" ofType:@"plist"]];
    NSArray *passArray = [[NSArray alloc ] initWithArray:[dictPassInfo objectForKey:@"transcriptinfo"]];
    
    NSInteger passCount = [passArray count];
    NSInteger index = [passName integerValue]-PP_PASSNUM_CHOOSE_TABLE_TAG;
    NSDictionary *passDictInfo = nil;
    if (passCount > index) {
        passDictInfo=[NSDictionary dictionaryWithDictionary:[passArray objectAtIndex:index]];
    }
    
    PPPetChooseScene * choosePetScene = [[PPPetChooseScene alloc] initWithSize:self.view.bounds.size];
    choosePetScene.passDictInfo=passDictInfo;
    choosePetScene.scaleMode = SKSceneScaleModeAspectFill;
    [self.view presentScene:choosePetScene transition:[SKTransition doorsCloseVerticalWithDuration:1.0f]];
}

@end
