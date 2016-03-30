# GRNAlertView #

This library has been created by [www.guarana.io](http://www.guarana.io)

This very easy to use AlertView allows you to interact in a nice way with your users while preserving the aesthetics of the screen.

## Installation 

* Cocoapods


``` 
pod 'GRNAlertView', '~> 1.0'
```

[CLick here](https://guides.cocoapods.org/using/getting-started.html) more information about cocoapods and how to install it 

* Manual

Drag the folder GRNAlertView into your project.


## How to use it

Instantiate your AlertContoller

Note : If you want only one button, just let the rightButtonTitle string empty.

``` objectivec
AlertController * alert = [[AlertController alloc] initWithTitle:@"My Title" subTitle:@"With a sub-title here" content:@"This is an alert view whith image Type some content here." leftButtonTitle:@"OK" rightButtonTitle:@"" andImage:[UIImage imageNamed:@"globe"]];
```

Set the button actions

``` objectivec
[alert setLeftButtonAction:^(AlertController * controller) {
    // Do something here
    
}];

[alert setRightButtonAction:^(AlertController *controller) {
    // Do something here
    
}];
```


Show the alert like so

``` objectivec
[alert showOn:self];
    
```

Set the type of background you want :

``` objectivec
alert.backgroundType = BackgroundTypeTransparentLight;
```

*   BackgroundTypeDefault (background is transparent)

*   BackgroundTypeTransparentLight (background is white with an alpha)

![Light](https://github.com/guaranatech/GRNAlertView/blob/master/screenshots/screenshot1.png)

*   BackgroundTypeTransparentDark (background is black with an alpha)

![Dark](https://github.com/guaranatech/GRNAlertView/blob/master/screenshots/screenshot2.png)

*   BackgroundTypeBlurred  (background is blurred)

![Blurred](https://github.com/guaranatech/GRNAlertView/blob/master/screenshots/screenshot3.png)


## Customization



``` objectivec
//label text colors
titleColor
subtitleColor
contentColor

//button tint colors
leftButtonColor
rightButtonColor

//background of the alertview frame
alertBackgroundColor
//background of the buttons
leftButtonBackgroundColor
rightButtonBackgroundColor

//alertview radius
cornerRadius
//alertview shadow opacity
shadowOppacity
//alertview shadow spread
shadowSpread
```



## Coming soon

* More Transitions
* More Animations
* Dynamic buttons (vertical/horizontal)
* Rating options
* Cocoapods
