//
//  ViewController.m
//  GNRAlertView
//
//  Created by Antoine Marliac on 16-03-25.
//  Copyright © 2016 Guaranà. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    AlertController* alert;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)showAlertViewWithOneWithImageButton:(id)sender
{
    alert = [[AlertController alloc] initWithTitle:@"My Title" subTitle:@"With a sub-title here" content:@"This is an alert view whith image Type some content here." leftButtonTitle:@"OK" rightButtonTitle:@"" andImage:[UIImage imageNamed:@"alertIcon"]];
    
    [alert setLeftButtonAction:^(AlertController * controller) {
        // Do something here
        
    }];
    
    
    [alert setRightButtonAction:^(AlertController *controller) {
        // Do something here
        
    }];
    alert.cornerRadius = 8.0f;
    alert.backgroundType = BackgroundTypeTransparentLight;
    
    [alert showOn:self];
}

- (IBAction)showAlertViewWithOneWithoutImageButton:(id)sender
{
    alert = [[AlertController alloc] initWithTitle:@"My Title" subTitle:@"With a sub-title here" content:@"This is an alert view whitout image Type some content here." leftButtonTitle:@"OK" rightButtonTitle:@"" andImage:nil];
    
    [alert setLeftButtonAction:^(AlertController * controller) {
        // Do something here
        
    }];
    
    
    [alert setRightButtonAction:^(AlertController *controller) {
        // Do something here
        
    }];
    
    alert.cornerRadius = 20.0f;
    alert.backgroundType = BackgroundTypeTransparentDark;

    [alert showOn:self];
}

- (IBAction)showAlertViewWithTwoButton:(id)sender
{
    alert = [[AlertController alloc] initWithTitle:@"My Title" subTitle:@"With a sub-title here" content:@"Type some content here." leftButtonTitle:@"OK" rightButtonTitle:@"CANCEL" andImage:[UIImage imageNamed:@"alertIcon"]];
    
    [alert setLeftButtonAction:^(AlertController * controller) {
        // Do something here

    }];
    
    [alert setRightButtonAction:^(AlertController *controller) {
        // Do something here
        
    }];
    alert.cornerRadius = 8.0f;
    alert.backgroundType = BackgroundTypeBlurred;

    [alert showOn:self];
}


@end
