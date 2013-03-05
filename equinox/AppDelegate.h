/* Copyright (c) 2013. All Right Reserved, http://imryan.net/
 *
 * EQUINOX (1.0.2) IS A DISTRIBUTED DENIAL OF SERVICE (DDOS) ATTACK TESTER.
 * USE IT TO CHECK YOUR SITE PROTECTION/ETC.
 *
 * This source is subject to the Microsoft Permissive License.
 * Please see the License.txt file for more information.
 * All other rights reserved.
 *
 * DO NOT REDISTRIBUTE.
 *
 * THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
 * KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
 * PARTICULAR PURPOSE.
 */

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    
    /* gui elements that pass data */
    IBOutlet NSTextField *ipField;
    IBOutlet NSTextField *portField;
    IBOutlet NSTextField *timeField;
    
    /* sidebar log */
    IBOutlet NSTextView *logView;
    
    /* lower screen elements */
    IBOutlet NSProgressIndicator *loader;
    IBOutlet NSTextField *sendingStr;
    
    /* vars to store data in */
    NSString *ip;
    NSString *port;
    NSString *size;
    NSString *time;
    
    /* loader timer */
    NSTimer *timer;
    NSString *ti;
    int i;

}
- (IBAction)send:(id)sender;
- (IBAction)help:(id)sender;
@property (assign) IBOutlet NSWindow *window;
@end
