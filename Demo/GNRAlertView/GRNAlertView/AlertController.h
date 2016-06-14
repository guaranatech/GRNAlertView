//
//  AlertController.h
//  Raden
//
//  Created by Antoine Marliac on 16-01-28.
//  Copyright © 2016 Guaraná Technologies Inc Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaterialButton.h"


@interface AlertController : UIViewController

//Alert
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIButton *backgroundButton;

@property (weak, nonatomic) IBOutlet MaterialButton *btn1;
@property (weak, nonatomic) IBOutlet MaterialButton *btn2;

//Constraints
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn1Width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn2Width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTopMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subTitleTopMargin;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * lineHeight;


//Block for the right button
@property (nonatomic, copy) void (^rightButtonAction)(AlertController* controller);
//Block for the left button
@property (nonatomic, copy) void (^leftButtonAction)(AlertController* controller);


//Customization

enum BackgroundType : NSUInteger {
    BackgroundTypeDefault = 0,
    BackgroundTypeTransparentLight = 1,
    BackgroundTypeTransparentDark = 2,
    BackgroundTypeBlurred = 3
};

//background type
@property (assign, nonatomic) enum BackgroundType backgroundType;



//Colors
//@property (strong, nonatomic) UIColor* imageTintColor;
@property (strong, nonatomic) UIColor* titleColor;
@property (strong, nonatomic) UIColor* subtitleColor;
@property (strong, nonatomic) UIColor* contentColor;
@property (strong, nonatomic) UIColor* leftButtonColor;
@property (strong, nonatomic) UIColor* rightButtonColor;

//Background Colors
@property (strong, nonatomic) UIColor* alertBackgroundColor;
@property (strong, nonatomic) UIColor* leftButtonBackgroundColor;
@property (strong, nonatomic) UIColor* rightButtonBackgroundColor;

//Fonts
@property (strong, nonatomic) UIFont* titleFont;
@property (strong, nonatomic) UIFont* subtitleFont;
@property (strong, nonatomic) UIFont* contentFont;
@property (strong, nonatomic) UIFont* buttonFont;

//Alert Frame Attributes
@property (assign, nonatomic) float cornerRadius;
@property (assign, nonatomic) float shadowOppacity;
@property (assign, nonatomic) float shadowRadius;



- (instancetype)initWithTitle:(NSString*) title
                     subTitle:(NSString*) subTitle
                      content:(NSString*) content
              leftButtonTitle:(NSString*) leftBtnTitle
             rightButtonTitle:(NSString*) rightBtnTitle
                     andImage:(UIImage*) image;


- (void) showOn:(UIViewController *) controller;
- (IBAction)dismiss:(id)sender;


@end
