/* http://imryan.mit-license.org/
 *
 * EQUINOX (1.0.3) IS A DISTRIBUTED DENIAL OF SERVICE (DDOS) ATTACK TESTER.
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
    
    // Fields to be inputted into attack
    IBOutlet NSTextField *ipField;
    IBOutlet NSTextField *portField;
    IBOutlet NSTextField *timeField;
    
    // Sidebar console
    IBOutlet NSTextView *logView;
    
    // Bottom window elements
    IBOutlet NSProgressIndicator *loader;
    IBOutlet NSTextField         *sendingStr;
    
    // Variables to hold values
    NSString *ip;
    NSString *port;
    NSString *size;
    NSString *time;
    
    // Loader timer
    NSTimer *timer;
    NSString *ti;
    int i;

}

- (IBAction)send:(id)sender;
- (IBAction)help:(id)sender;

@property (assign) IBOutlet NSWindow *window;

@end
