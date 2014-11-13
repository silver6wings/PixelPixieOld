
@interface PPSkill : NSObject

@property (nonatomic, retain) NSString * skillName;
@property (nonatomic, retain) NSMutableArray * animateTextures;
@property (nonatomic, assign) CGFloat HPChangeValue;
@property (nonatomic, assign) CGFloat MPChangeValue;
@property (nonatomic, assign) int skillType;   // 0:被动 1:主动
@property (nonatomic, assign) int skillObject; // 0:作用于自身 1:作用于对方

@end
