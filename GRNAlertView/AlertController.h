//
//  AlertController.h
//  Raden
//
//  Created by Antoine Marliac on 16-01-28.
//  Copyright © 2016 Guaranà Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaterialButton.h"


@interface AlertController : UIViewController <MaterialButton>


enum BackgroundType : NSUInteger {
    BackgroundTypeDefault = 0,
    BackgroundTypeTransparentLight = 1,
    BackgroundTypeTransparentDark = 2,
    BackgroundTypeBlurred = 3
};

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet MaterialButton *btn1;
@property (weak, nonatomic) IBOutlet MaterialButton *btn2;

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIView *shadowView;

@property (weak, nonatomic) IBOutlet UIButton *backgroundButton;


//constraints
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn1Width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn2Width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTopMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subTitleTopMargin;


//block for the right button
@property (nonatomic, copy) void (^rightButtonAction)(AlertController* controller);
//block for the left button
@property (nonatomic, copy) void (^leftButtonAction)(AlertController* controller);


//customization

//background type
@property (assign, nonatomic) enum BackgroundType backgroundType;



//colors
@property (strong, nonatomic) UIColor* imageTintColor;


@property (strong, nonatomic) UIColor* titleColor;
@property (strong, nonatomic) UIColor* subtitleColor;
@property (strong, nonatomic) UIColor* contentColor;
@property (strong, nonatomic) UIColor* leftButtonColor;
@property (strong, nonatomic) UIColor* rightButtonColor;

@property (strong, nonatomic) UIColor* alertBackgroundColor;
@property (strong, nonatomic) UIColor* leftButtonBackgroundColor;
@property (strong, nonatomic) UIColor* rightButtonBackgroundColor;


//fonts
@property (strong, nonatomic) UIFont* titleFont;
@property (strong, nonatomic) UIFont* subtitleFont;
@property (strong, nonatomic) UIFont* contentFont;
@property (strong, nonatomic) UIFont* buttonFont;

@property (assign, nonatomic) float cornerRadius;

@property (assign, nonatomic) float shadowOppacity;
@property (assign, nonatomic) float shadowSpread;


- (instancetype)initWithTitle:(NSString*) title
                     subTitle:(NSString*) subTitle
                      content:(NSString*) content
              leftButtonTitle:(NSString*) leftBtnTitle
             rightButtonTitle:(NSString*) rightBtnTitle
                     andImage:(UIImage*) image;


- (void) showOn:(UIViewController *) controller;

- (IBAction)dismiss:(id)sender;


@end
