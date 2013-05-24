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

#import "AppDelegate.h"

@implementation AppDelegate

- (IBAction)help:(id)sender
{
    NSBeginAlertSheet(@"IP Formatting", @"OK", nil, nil, [[NSApp delegate]window], self, @selector(sheetDidEnd:resultCode:contextInfo:), NULL, NULL, @"IP Address must be numerical, like this: '192.168.1.1'. To get this, ping the IP in Terminal: 'ping http://google.com' to acquire an IP, or open Network Utility > Ping. Then, enter the hostname. The first number returned is the IP address for the hostname.");
}

- (IBAction)send:(id)sender
{
    // Get system's current time & add information to log (console)
    NSDateFormatter *formatter;
    NSString        *timeStr;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyy HH:mm"];
    timeStr = [formatter stringFromDate:[NSDate date]];
    [formatter release];
 
    // Check if all fields are valid and assign the values to variables
    if ([ipField.stringValue isEqualToString:@""] || [timeField.stringValue isEqualToString:@""] || [portField.stringValue isEqualToString:@""])
    {
        NSBeginAlertSheet(@"Some fields are missing.", @"OK", nil, nil, [[NSApp delegate]window], self, @selector(sheetDidEnd:resultCode:contextInfo:), NULL, NULL, @"In order to attack the IP, we're going to need an IP to connect to, a port, and a duration.");
        
        NSString *timeLog = [NSString stringWithFormat:@"+ %@: %@\n- - - - - - - - - -\n", timeStr, @"Attack not sent!"];
        
        [logView.textStorage.mutableString appendString:timeLog];
        
    } else {
        
    // Retrieve the data to be sent
    ip   = ipField.stringValue;
    port = portField.stringValue;
    time = timeField.stringValue;
        
    ti = [NSString stringWithFormat:@"%d", [time intValue]];
    
    // Open the path to the Perl script
    NSString *path = [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] pathForResource:@"equinox" ofType:@"pl"]];

    // Tell Terminal to open the Perl script, replace the %@ values, and run the script
    NSString *s = [NSString stringWithFormat:@"tell application \"Terminal\" to do script \"perl %@ %@ %@ 0 %@\"", path, ip, port, time];
    
    NSAppleScript *as = [[NSAppleScript alloc] initWithSource:s];
    [as executeAndReturnError:nil];
    
    // Hide the Terminal
    NSString *c = [NSString stringWithFormat:@"set win to \"Terminal\" tell application \"System Events\" to tell process win to keystroke \"h\" using command down"];
    
    NSAppleScript *hw = [[NSAppleScript alloc] initWithSource:c];
    [hw executeAndReturnError:nil];
        
    NSString *timeLog = [NSString stringWithFormat:@"+ %@: %@\n- - - - - - - - - -\n", timeStr, @"Attack sent!"];
    [logView.textStorage.mutableString appendString:timeLog];
    
        
        // Display 'sending...' and start the loader
        [sendingStr setHidden:false];
        [loader setHidden:false];
        [loader startAnimation:loader];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(stopLoader) userInfo:nil repeats:YES];
    }
}

- (void)stopLoader
{
    i++;
    if (i==[ti intValue]) {
        [timer invalidate];
        [loader stopAnimation:loader];
        [loader setHidden:true];
        [sendingStr setHidden:true];
        i = 0;
    }
}

// Method that handles the alert sheet hiding
- (void)sheetDidEnd:(NSWindow *)sheet resultCode:(NSInteger)resultCode contextInfo:(void *)contextInfo {}

- (void)dealloc
{
    [super dealloc];
    
    // Release unused variables here...
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [_window setReleasedWhenClosed:false];
    [loader setHidden:true];
    [sendingStr setHidden:true];
    
    // Sidebar console properties
    [logView setEditable:false];
    [logView setRichText:false];
    [logView setAlignment:NSCenterTextAlignment];
    [logView setBackgroundColor:[NSColor gridColor]];
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag
{
    [_window setIsVisible:true];
    return true;
}

@end
