//
//  KAOColoredTextField.h
//  KAOColoredTextFieldTest
//
//  Created by Andrey Kravchenko on 7/15/15.
//  Copyright (c) 2015 Kievkao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KAOAttributedTextField : UITextField

@property (nonatomic) IBInspectable NSUInteger nonRemovableCount;

- (void)setColor:(UIColor *)color forRange:(NSRange)range;

@end
