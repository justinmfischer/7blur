```HTML
Note : ...
````

## Overview
![7blur](http://www.funtouchapps.com/github/7blur/images/Icon-60x60.png) IOS 7 introduces a new efficient snapshot API. The 7blur project builds apron these frameworks to produce Control Center and Notification Center like blur effects enforcing the 3rd design pattern of depth for iOS 7 apps. It should be noted that iOS 7 is no longer under developer NDA. 7blur can be used free and improved by the community.

7blur supports both two styles of blur, two styles of positioning and many blur color components.

* **Supported blurs**
 * Live real time blur
 * Static blur

* **Support positioning**
 * Drop down menu style
 * Fixed position

* **Blur Color Components**
 * Blur radius
 * Tint color
 * Saturation Delta
 * Image Mask

By combining the attributes above one can produce many desired visual effects and human interfaces. 7blur only has a handful of API tasks and the view content can be visually edited in Interface Builder for productivity. The next section will go over the API followed by common use cases contained in the sample project. Let's get started.

## Getting Started
7blur requires _**iOS 7**_ and linking the _**Accelerate.framework**_ to help with image processing (DSP). Integration is simple and entails 3 tasks. **(1)** Loading the view and possibly sliding it into place for drop down menu style, **(2)** blurring it with color components and lastly **(3)** unloading the view to remove. The API is listed below for reference.

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
![Sample Project](http://www.funtouchapps.com/github/7blur/images/project-home.png)

The sample Xcode project contains (3) common iOS 7 use cases.

## 1. Live real time blur
This is an example of the drop down menu style live real time blur. Background content is blurred in real time behind the foreground.

```Objective-C
code
````

## 2. Static blur
Similar to the example above but this version stops the UITableView from scrolling, fades in a vignette and then drops down a static blurred view. Background content is blurred using a dark color behind the foreground while touch events are disable.

```Objective-C
code
````

## 3. Live positioned blur
The final example differs from the previous two by supporting view positioning inside a subview.

```Objective-C
code
````

## Interface Builder
7blur can be customized for many use cases entirely visual using Interface Builder. This promotes the MVC design pattern and increases productivity.

## Performance and Implementation Details

7blur is efficient for static blurs and live or real time blur perform averagely. One of the intentions about opening this project up to the community is to improve this. Before making these improvements lets discuss how 7blur works.

First **(1)** 7blur takes a snapshot using the new iOS 7 UIView (snapshotting) category -drawViewHierarchyInRect:afterScreenUpdates:. Apple in WWDC 2013 (session 226) mentioned that this is the preferred method for graphical effects and performs very fast (86ms). Pending updates are discarded for performance and live snapshots.

![...](http://www.funtouchapps.com/github/7blur/images/project-original.png)
Original - 320x568

Second **(2)** 7blur grabs the new snapshot image from the graphics context at x1 point scale and crops the background snapshot from the BLRView frame attributes. The sample project has a BLRView with the following dimensions 320x200.

![...](http://www.funtouchapps.com/github/7blur/images/project-cropped.png)
Cropped - 320x200

Third **(3)** the cropped snapshot is re-sized down by a scale factor of x4.

![...](http://www.funtouchapps.com/github/7blur/images/project-re-sized.png)
Re-sized - 80x50

Forth **(4)** the scaled down image is applied the blur effect using Apple’s UIImage+ImageEffects UIImage categories. While this is not the most efficient method of producing the blur effect it produces results similar to Apple’s Control and Notification Centers. This operation is improved using the smaller image size from the previous step.

![...](http://www.funtouchapps.com/github/7blur/images/project-blurred.png)
Blur applied - 80x50

Lastly **(5)** the blurred snapshot is assigned to the backgroundImage property of BLRView and the default contentMode will scale it back up and retain the aspect ratio.

![...](http://www.funtouchapps.com/github/7blur/images/project-final.png)
Final - 320x568

### Threading

The two most expensive operations include cropping and re-sizing the background image. Both of these tasks are off loaded to a background global queue. Once complete the UI changes are synchronized on the main run loop. Low level GCD dispatch timers are used in favor of NSTimer for live real time blur implementation. On iOS, NSTimer events are suppressed during certain cocoa touch events such as UIScrollView scrolling as an example. By using GCD dispatch timers live blur effects can be achieved even during such events.

Apple’s live burs in the status bar, under keyboards and in other views on iOS 7 are smooth and efficient. While probably implemented in lower level private APIs and GPU level DSP image processing there is still room for 3rd party developers to improve projects like 7blur. Please fork and improve.

## History
Initial release : _9/03/2013_

## Copyright and Software Licenses
* UIImage Alpha, Resize, RoundedCorner Category Methods : _Trevor Harmon_
* UIImage Image Effects Category Methods : _Apple, Inc._

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
