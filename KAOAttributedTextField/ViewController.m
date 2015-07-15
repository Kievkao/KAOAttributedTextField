//
//  ViewController.m
//  KAOColoredTextFieldTest
//
//  Created by Andrey Kravchenko on 7/15/15.
//  Copyright (c) 2015 Kievkao. All rights reserved.
//

#import "ViewController.h"
#import "KAOAttributedTextField.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet KAOAttributedTextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Non-removable amount of symbols was set in Storyboard as IBInspectable property
    [self.textField setTextColor:[UIColor greenColor]];
    [self.textField setColor:[UIColor redColor] forRange:NSMakeRange(3, 2)];
    [self.textField setColor:[UIColor blueColor] forRange:NSMakeRange(5, 3)];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

@end
