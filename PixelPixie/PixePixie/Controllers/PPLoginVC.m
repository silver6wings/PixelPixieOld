//
//  PPLoginVC.m
//  PixelPixie
//
//  Created by liuxiaoyu on 14-3-8.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import "PPLoginVC.h"

static const NSInteger validNameLength = 6;

@interface PPLoginVC () <UITextFieldDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@end

@implementation PPLoginVC

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	if (textField.text.length >= validNameLength) {
		self.confirmBtn.enabled = YES;
	} else {
		self.confirmBtn.enabled = NO;
	}
	return YES;
}

- (IBAction)confirmToPixieVC:(UIButton *)sender {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"像素精灵", @"")
                                                    message:NSLocalizedString(@"用这个名字去征服它们吗？",@"")
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"取消",@"")
                                          otherButtonTitles:NSLocalizedString(@"确定", @""), nil];
	[alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:NSLocalizedString(@"确定", @"")]) {
		UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PPStoryboard" bundle:nil];
		PPSelectPixieVC *pixieVC = [storyboard instantiateViewControllerWithIdentifier:@"PPSelectPixieVC"];
		[self.navigationController pushViewController:pixieVC animated:YES];
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
