//
//  PPMainScene.h
//  PixelPixie
//
//  Created by xiefei on 5/21/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPBasicScene.h"

@interface PPMainScene : PPBasicScene
{

}
//回调对象
@property(nonatomic,assign) id chooseTarget;
//回调方法
@property(nonatomic,assign) SEL chooseCouterpartSel;
@end
