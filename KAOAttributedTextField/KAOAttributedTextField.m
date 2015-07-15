//
//  KAOColoredTextField.m
//  KAOColoredTextFieldTest
//
//  Created by Andrey Kravchenko on 7/15/15.
//  Copyright (c) 2015 Kievkao. All rights reserved.
//

#import "KAOAttributedTextField.h"

//-----------------------------------------------
@interface KAOAttributedTextFieldColorSet : NSObject

@property (nonatomic, strong) UIColor *color;
@property (nonatomic) NSRange range;

- (instancetype)initWithColor:(UIColor *)color range:(NSRange)range;

@end

@implementation KAOAttributedTextFieldColorSet

- (instancetype)initWithColor:(UIColor *)color range:(NSRange)range {
    
    self = [super init];
    
    if (self) {
        _color = color;
        _range = range;
    }
    
    return self;
}

@end
//-----------------------------------------------

@interface KAOAttributedTextField()

@property (nonatomic, strong) NSMutableArray *colorAttributes;
@property (nonatomic, strong) UIColor *initialColor;

@property (nonatomic, strong) NSDictionary *colorAttr;
@property (nonatomic, copy) NSString *previousText;

@end

@implementation KAOAttributedTextField

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self customSetup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customSetup];
    }
    return self;
}

- (void)customSetup {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myTextDidChange) name:UITextFieldTextDidChangeNotification object:self];
    self.initialColor = self.textColor;
}

- (void)setTextColor:(UIColor *)textColor {
    [super setTextColor:textColor];
    
    self.initialColor = textColor;
}

- (void)setColor:(UIColor *)color forRange:(NSRange)range
{
    KAOAttributedTextFieldColorSet *colorSet = [[KAOAttributedTextFieldColorSet alloc] initWithColor:color range:range];
    
    [self.colorAttributes addObject:colorSet];
}

- (void)myTextDidChange
{
    if ([self isNeedToFixCurrentSymbols]) {
        self.text = self.previousText;
    }
    else {
        self.previousText = self.text;
    }
    
    NSDictionary *attributes = [self typingAttributesForCurrentText];
    if (attributes) {
        self.typingAttributes = attributes;
    }
}

- (NSDictionary *)typingAttributesForCurrentText
{
    NSDictionary *colorDict = nil;
    
    for (KAOAttributedTextFieldColorSet *colorSet in self.colorAttributes) {
        if ((colorSet.range.location + colorSet.range.length) > self.text.length &&
            colorSet.range.location <= self.text.length) {
            colorDict = @{NSForegroundColorAttributeName : colorSet.color};
            break;
        }
    }
    
    return colorDict ? colorDict : @{NSForegroundColorAttributeName : self.initialColor};
}

- (BOOL)isNeedToFixCurrentSymbols
{
    return (self.nonRemovableCount && (self.text.length < self.previousText.length) && self.text.length < self.nonRemovableCount);
}

- (NSMutableArray *)colorAttributes
{
    if (!_colorAttributes) {
        _colorAttributes = [NSMutableArray array];
    }
    
    return _colorAttributes;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
