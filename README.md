# Open Kickflip SDK for iOS

This is a spinoff from the original [Kickflip](http://kickflip.io) opensource project and commercial platform.

Open Kickflip takes the best of the awesome Kickflip and allows you to directly upload the streaming to your own s3 bucket. It also removes the dependency on the Kickflip API.

Open Kickflip provides a complete video broadcasting solution for your iOS application. You can use our pre-built `KFBroadcastViewController` to stream live video with one line of code. 

## Quickstart

```objc
#import <OpenKickflip/OpenKickflip.h>

...

- (void) broadcastButtonPressed {
    
    KFS3Stream* s3Config     = [[KFS3Stream alloc] init];
    NSString* random         = [KFS3Stream randomStringWithLength:6];
    s3Config.bucketName      = [@"*** YOUR BUCKET NAME/PATH ***/" stringByAppendingPathComponent:random];
    s3Config.awsAccessKey    =  @"*** YOUR AWS TOKEN ***";
    s3Config.awsSecretKey    =  @"*** YOUR AWS SECRET TOKEN ***";
    s3Config.awsRegion       =  @"*** YOUR S3 BUCKET REGION ****"; // i.e. "us-east-1"
    s3Config.awsPrefix       =  @""; // Mandatory to set and leave blank.
    
    [OpenKickflip presentBroadcasterFromViewController:self
                                        s3Configuration:s3Config
                                                 ready:^(KFStream *stream) {
        if (stream.streamURL) {
            NSLog(@"Stream is ready at URL: %@", stream.streamURL);
        }
    } completion:^(BOOL success, NSError* error){
        if (!success) {
            NSLog(@"Error setting up stream: %@", error);
        } else {
            NSLog(@"Done broadcasting");
        }
    }];
}

```

## How do I get an AWS S3 Temporal Upload Token?

TODO (Use of Cognito makes more sense than using direct access/secret keys)

## Cocoapods Setup

You'll need to install [Cocoapods](http://cocoapods.org) first.
    
Add the following line to your `Podfile`:

    source 'https://github.com/OpenKickflip/openkickflip-ios-sdk.git'
    pod 'OpenKickflip', '~> 1.5'

Then run Cocoapods to install all of the dependencies:

    $ pod install

As with all projects that depend on Cocoapods, make sure to open the new `.xcworkspace` file, not your `.xcodeproj` file.
    
## Documentation

TODO

## Screenshots

[![kickflip app screenshot](https://i.imgur.com/QPtggd9m.jpg)](https://i.imgur.com/QPtggd9.png)
[![kickflip live broadcast screenshot](https://i.imgur.com/VHB6iQQm.jpg)](https://i.imgur.com/VHB6iQQ.png)
[![kickflip live consumption screenshot](https://i.imgur.com/IZbiyhRm.jpg)](https://i.imgur.com/IZbiyhR.png)

[Screenshots Gallery](http://imgur.com/a/IwuZ7)

    
## License

TODO TOASK TOREV

Apache 2.0

	Copyright 2014 OpenWatch, Inc.
	
	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at
	
	    http://www.apache.org/licenses/LICENSE-2.0
	
	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
