#import "PPSkill.h"

@implementation PPSkill

@synthesize skillName;
@synthesize animateTextures;
@synthesize HPChangeValue;
@synthesize MPChangeValue;
@synthesize skillType;
@synthesize skillObject;

-(id)init
{
    if (self = [super init]) {
        self.animateTextures = [[NSMutableArray alloc] init];
        self.HPChangeValue = - 193.0f;
        self.MPChangeValue = - 43.0f ;
    }
    return self;
}

@end
