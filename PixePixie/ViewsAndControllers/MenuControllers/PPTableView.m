//
//  PPTableView.m
//  PixelPixie
//
//  Created by xiefei on 14-4-2.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import "PPTableView.h"
@interface PPTableView()
{
    NSArray *tableArray;
    NSMutableArray *cellArray;
}
@end
@implementation PPTableView
@synthesize choosePassNumberSel=_choosePassNumberSel;
@synthesize choosePassNumber=_choosePassNumber;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        // Initialization code
    }
    return self;
}
-(void)ppsetTableViewWithData:(NSArray *)Tmparray
{

    tableArray=[[NSArray alloc] initWithArray:Tmparray];
    cellArray=[[NSMutableArray alloc] init];

    for (int i=0; i<6; i++) {
        UITableViewCell* cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sbliu"];
        cell.textLabel.text =[tableArray objectAtIndex:i];
        [cellArray addObject:cell];
    }
    
    UITableView *tableTest=[[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
    tableTest.delegate=self;
    tableTest.dataSource=self;
    [self addSubview:tableTest];
    
    
}
#pragma mark - UITableView delegate methods
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat rotationAngleDegrees = 0;
    CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
    CGPoint offsetPositioning = CGPointMake(-200,0);
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, rotationAngleRadians, 0.0, 0.0, 1.0);
    transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, 0.0);
    
    UIView *card = [cell contentView];
    card.layer.transform = transform;
    card.layer.opacity = 0.8;
    
    [UIView animateWithDuration:indexPath.row*0.3 animations:^{
        card.layer.transform = CATransform3DIdentity;
        card.layer.opacity = 1;
    }];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [cellArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
//    static NSString *CellIdentifier = @"sbliu";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    cell.textLabel.text =[tableArray objectAtIndex:indexPath.row];
    return [cellArray objectAtIndex:indexPath.row];
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.choosePassNumber!=nil&&self.choosePassNumberSel!=nil&&[self.choosePassNumber respondsToSelector:self.choosePassNumberSel]) {
        

        [self.choosePassNumber performSelectorInBackground:self.choosePassNumberSel withObject:[NSNumber numberWithInt:(int)indexPath.row]];
    }
//
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
