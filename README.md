![7blur](http://www.funtouchapps.com/github/7blur/images/7blur-overview.gif)

```HTML
Sample project animated .gif (4.4MB)
```

## Overview
![7blur](http://www.funtouchapps.com/github/7blur/images/Icon-60x60.png) IOS 7 introduces a new efficient snapshot API. The 7blur project builds apron these frameworks to produce Control Center and Notification Center like blur effects enforcing the 3rd design pattern of depth for iOS 7 apps. It should be noted that iOS 7 is no longer under developer NDA. 7blur can be used free and improved by the community.

7blur supports both two styles of blur, two styles of positioning and many blur color components.

* **Supported blurs**
 * Live real time blur
 * Static blur

* **Supported positioning**
 * Drop down menu style
 * Fixed position

* **Blur Color Components**
 * Blur radius
 * Tint color
 * Saturation Delta
 * Image Mask

By combining the attributes above one can produce many desired visual effects and human interfaces. 7blur only has a handful of API tasks and the view content can be visually edited in Interface Builder for productivity. The next section will go over the API followed by common use cases contained in the sample project. Let's get started.

## Getting Started
7blur only requires _**iOS 7**_ and _**Xcode 5**_. Integration is simple and entails 3 tasks. **(1)** Loading the view and possibly sliding it into place for drop down menu style, **(2)** blurring it with color components and lastly **(3)** unloading the view to remove. The API is listed below for reference.

## API

```Objective-C
BLRView.h

//Drop down menu style
+ (BLRView *) load:(UIView *) view;

//Fixed position style
+ (BLRView *) loadWithLocation:(CGPoint) point parent:(UIView *) view;

//Remove
- (void) unload;

//Down
- (void) slideDown;

//Up
- (void) slideUp;

//Static blur
- (void) blurWithColor:(BLRColorComponents *) components;

//Live real time blur
- (void) blurWithColor:(BLRColorComponents *) components updateInterval:(float) interval;
````

## Code : Sample Project
![7blur](http://www.funtouchapps.com/github/7blur/images/7blur-home.png)

The sample Xcode 5 project contains **(3)** common iOS 7 use cases and supports in-call status bar, 4" (iPhone 5S/5) and 3.5" (iPhone 4S, 4) retina devices.

## 1. Live real time blur
This is an example of the drop down menu style live real time blur. Background content is blurred in real time behind the foreground.

```Objective-C
LiveBlurVC.m

- (void) viewDidLoad {
    [super viewDidLoad];
    
    ...
    
    //Load BLRView with UITableView as background content
    self.blrView = [BLRView load:self.tableView];
    
    //Add BLRView to main view
    [self.view addSubview:self.blrView];
}

- (IBAction) toggleViewDirection:(id) sender {
    switch (self.viewDirection) {
        case KShouldMoveDown: {
            
            //Start live real time blur with .2f update interval
            [self.blrView blurWithColor:[BLRColorComponents lightEffect] updateInterval:.2f];
            
            //Slide down - drop down style
            [self.blrView slideDown];
            
            ...
        }
            
        case KShouldMoveUp: {
            
            //Slide up
            [self.blrView slideUp];
            
            ...
        }

        ...
    }
}

````

## 2. Static blur
Similar to the example above but this version stops the `UITableView` from scrolling, fades in a vignette and then drops down a static blurred view. Background content is blurred using a dark color behind the foreground while touch events are disable.

```Objective-C
StaticBlurVC.m

- (void) viewDidLoad {
    [super viewDidLoad];

    ...
    
    //Load BLRView with UITableView as background content
    self.blrView = [BLRView load:self.tableView];
    
    ...
    
    //Add BLRView to main view
    [self.view addSubview:self.blrView];
}

- (IBAction) toggleViewDirection:(id) sender {
    switch (self.viewDirection) {
        case KShouldMoveDown: {
            
            //Stop UITableView : UIScrollView from scrolling
            [self.tableView setContentOffset:self.tableView.contentOffset animated:NO];
            
            //Show vignette
            [UIView animateWithDuration:.2f animations:^{
                self.blackoutView.alpha = .2f;
            } completion:^(BOOL finished) {
                
            }];

            //Static blur with dark color components
            [self.blrView blurWithColor:[BLRColorComponents darkEffect]];
            
            //Slide down - drop down style
            [self.blrView slideDown];
            
            ...
        }
            
        case KShouldMoveUp: {
            
            //Hide vignette
            [UIView animateWithDuration:.5f animations:^{
                self.blackoutView.alpha = 0;
            } completion:^(BOOL finished) {
                
            }];
            
            //Slide up
            [self.blrView slideUp];
            
            ...
        }
        
        ...
    }
}

````

## 3. Live positioned blur
The final example differs from the previous two by supporting view positioning inside a subview.

```Objective-C
PositionedBlurVC.m

- (IBAction) toggleView:(id) sender {
    switch (self.viewDisplayAction) {
        case KShouldPresent: {
            
            //Location point to place BLRView
            CGPoint point = CGPointMake(0, 200);
            
            //Load BLRView with UIView as background content
            self.blrView = [BLRView loadWithLocation:point parent:self.backgroundView];
            
            //Container foreground frame updated to match BLRView (x, y, w, h)
            self.foregroundView.frame = CGRectMake(point.x, point.y, CGRectGetWidth(self.blrView.frame), CGRectGetHeight(self.blrView.frame));
            
            //Add BLRView to foreground view
            [self.foregroundView addSubview:self.blrView];
            
            //Start live real time blur with .2f update interval
            [self.blrView  blurWithColor:[BLRColorComponents lightEffect] updateInterval:.2f];
            
            ...
        }
            
        case KShouldDismiss: {
            
            //Remove BLRView
            [self.blrView unload];
            
            ...
        }
            
        ...
    }
}

````

### Unloading
All examples unload or remove `BLRView` from the view heirarchy.

```Objective-C
- (void) viewWillDisappear:(BOOL) animated {
    
    //Remove BLRView if not done previously
    [self.blrView unload];
}
````

## Interface Builder
7blur can be customized for many use cases entirely visually using Interface Builder. This promotes the MVC design pattern and increases productivity.

![7blur](http://www.funtouchapps.com/github/7blur/images/7blur-interfacebuilder.gif)

## Performance and Implementation Details

7blur is efficient for static blurs and live or real time blur perform averagely. One of the intentions about opening this project up to the community is to improve this. Before making these improvements lets discuss how 7blur works.

First **(1)** 7blur takes a snapshot using the new iOS 7 `UIView` (UISnapshotting) category `-drawViewHierarchyInRect:afterScreenUpdates:`. Apple in [WWDC 2013 - Session 226](http://devstreaming.apple.com/videos/wwdc/2013/226xbx5xinmlvbdabxux9k3kt/226/226.pdf) mentioned that this is the preferred method for graphical effects and performs very fast (56ms). API renamed in seed 2.

![7blur](http://www.funtouchapps.com/github/7blur/images/7blur-WWDC-226.png)

Pending screen updates are discarded for performance and live snapshots.

![7blur](http://www.funtouchapps.com/github/7blur/images/7blur-1.png)

Original - 320x568

Second **(2)** 7blur grabs the new snapshot image from the graphics context at x1 point scale and crops the background snapshot from the `BLRView` frame attributes. The sample project has a `BLRView` with the following dimensions 320x200.

![7blur](http://www.funtouchapps.com/github/7blur/images/7blur-2.png)

Cropped - 320x200

Third **(3)** the cropped snapshot is re-sized down by a scale factor of x4.

![7blur](http://www.funtouchapps.com/github/7blur/images/7blur-3.png)

Re-sized - 80x50

Forth **(4)** the scaled down image is applied the blur effect using Apple’s `UIImage+ImageEffects` `UIImage` categories. While this is not the most efficient method of producing the blur effect it produces results similar to Apple’s Control and Notification Centers. This operation is improved using the smaller image size from the previous step.

![7blur](http://www.funtouchapps.com/github/7blur/images/7blur-4a.png)

Blur applied - 80x50

![7blur](http://www.funtouchapps.com/github/7blur/images/7blur-4b.png)

Blur scaled up by UIImageView default contentMode - 320x200

Lastly **(5)** the blurred snapshot is assigned to the `backgroundImageView` property of `BLRView` and the default `contentMode` will scale it back up and retain the aspect ratio.

![7blur](http://www.funtouchapps.com/github/7blur/images/7blur-5.png)

Final - 320x568

### Threading

The two most expensive operations include cropping and re-sizing the background image. Both of these tasks are off loaded to a background global queue. Once complete the UI changes are synchronized on the main run loop. Low level GCD dispatch timers are used in favor of `NSTimer` for live real time blur implementation. On iOS, `NSTimer` events are suppressed during certain cocoa touch events such as `UIScrollView` scrolling as an example. By using GCD dispatch timers live blur effects can be achieved even during such events.

### What about Apple?

Apple’s live burs in the Control Center, Notification Center, status bar, under keyboards and in other views on iOS 7 are smooth and efficient. This is because UIKit is built on top of OpenGL. Apple has private APIs that can listen for child re-drawing cycles thus eliminating the need for inefficient polling. For example, the live real time sample project incurs resources even when the background content has not changed or been invalidated. Apple does not have to pay this tax.

Additionly, Apple's blur effect is implemented with GPU hardware [linear/bilinear texture filtering](http://en.wikipedia.org/wiki/Bilinear_filtering). Even using the _**Accelerate.framework**_ vImage processing occurs at the CPU and not the GPU. While these limitations do exist there is room for 3rd party developers to improve projects like 7blur. Please fork and improve.

## History
* Initial private (NDA) release : _8/28/2013_
* Initial public release 1.0.0 : _9/10/2013_

## Copyright and Software Licenses
* UIImage Alpha, Resize, RoundedCorner Category Methods : _Trevor Harmon_
* UIImage Image Effects Category Methods : _Apple, Inc._
* Eadweard Muybridge "Sallie Gardner at a Gallop" : _Palo Alto, CA 1878_
* Royalty Free F L A G S : _Naaty Design_
 * [http://www.content-pack.com/category/freebies/world-flags/](http://www.content-pack.com/category/freebies/world-flags/)

The MIT License (MIT)

Copyright (c) 2013 Justin M Fischer

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Contact
* Justin M Fischer : _justinmfischer@gmail.com_

## Links
* [iOS 7 UI Transition Guide](https://developer.apple.com/library/etc/redirect/WWDR/iOSUITransitionGuide)
* [iOS Human Interface Guidelines](https://developer.apple.com/library/etc/redirect/WWDR/iOSHIG)
