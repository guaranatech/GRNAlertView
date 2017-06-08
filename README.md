# GRNAlertView #

This library has been created by [www.guarana.io](http://www.guarana.io)

This very easy to use alert view allows you to interact in a nice way with your users while preserving the aesthetics of the screen.

## Version

Project has been updated to Swift.
For Objective-C use 1.0.3 release.

## Installation 

* Cocoapods

``` 
pod 'GRNAlertView', '~> 2.0'
```

[Click here](https://guides.cocoapods.org/using/getting-started.html) more information about cocoapods and how to install it 

* Manual

Drag the folder GRNAlertView into your project.


## How to use it

Alert can be initialized in two ways.

``` swift
init(title: String, message: String? = nil)
init(content: GRNAlertContent, layout: GRNAlertLayout? = nil, firstButtonHandler: GRNAlertHandler? = nil, secondButtonHandler: GRNAlertHandler? = nil)
```

The easiest - just pass title and message as arguments. Message is optional.
It initalizes default alert with title and/or message and simple 'OK' button, which dismiss the alert.

``` swift
let alert = GRNAlertViewController(title: "Title", message: "Message")
```

Show the alert like so

``` swift
alert.show(on: self)
```

## Customization

For customization, there are two structures.

``` swift
struct GRNAlertLayout {
    var backgroundType: GRNAlertViewController.BackgroundType = .transparentDark
    var titleFont: UIFont = .boldSystemFont(ofSize: 17.0)
    var subtitleFont: UIFont = .systemFont(ofSize: 14.0)
    var messageFont: UIFont = .systemFont(ofSize: 16.0)
    var buttonsFont: UIFont = .boldSystemFont(ofSize: 16.0)
    var textColor: UIColor = .black
    var backgroundColor: UIColor = .white
    var cornerRadius: CGFloat = 8.0
}

struct GRNAlertContent {
    var title: String?
    var subtitle: String?
    var message: String?
    var image: UIImage?
    var firstButtonTitle: String?
    var secondButtonTitle: String?
}
```

When you want to customize it, just create custom objects and set whatever you want.
Layout and handlers parameters are optional in init method with default nil values.
``` swift
var content = GRNAlertContent()
var layout = GRNAlertLayout()
// ... configure content and layout objects as you want
let alert = GRNAlertViewController(content: content, layout: layout)

// alert only with custom content
let alert = GRNAlertViewController(content: content)

// alert with custom content and handlers
let alert = GRNAlertViewController(content: content, firstButtonHandler: { alert in
        // first button handler, do whatever you want    
}) { alert in
        // second button handler, do whatever you want   
}
```

If you want to have two buttons, just set the title for the secondButtonTitle in the content object.

``` swift
var content = GRNAlertContent()
content.secondButtonTitle = "Cancel"
```

There are 3 possible background types:
``` swift
enum BackgroundType {
        case clear, transparentLight, transparentDark
}
```

*   .clear (background is transparent)

*   .transparentLight (background is white with an alpha)

![Light](https://github.com/guaranatech/GRNAlertView/blob/master/screenshots/screenshot1.png)

*   .transparentDark (background is black with an alpha)

![Dark](https://github.com/guaranatech/GRNAlertView/blob/master/screenshots/screenshot2.png)

## Coming soon
* Custom transitions
* Blurred background
