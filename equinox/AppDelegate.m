// AppDelegate.m
//
// Copyright (c) 2012-2013 Ryan Cohen
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AppDelegate.h"

@implementation AppDelegate

- (IBAction)help:(id)sender
{
    NSBeginAlertSheet(@"IP Formatting", @"OK", nil, nil, [[NSApp delegate]window], self, @selector(sheetDidEnd:resultCode:contextInfo:), NULL, NULL, @"IP Address must be numerical, like this: '192.168.1.1'. To get this, ping the IP in Terminal: 'ping http://google.com' to acquire an IP, or open Network Utility > Ping. Then, enter the hostname. The first number returned is the IP address for the hostname.");
}

- (IBAction)settings:(id)sender
{
    [settingsPanel makeKeyAndOrderFront:self];
}

- (IBAction)browseFile:(id)sender
{
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    [openPanel setCanChooseFiles:true];
    [openPanel setCanChooseDirectories:true];
    
    [openPanel runModal];
}

- (IBAction)save:(id)sender
{
    [settingsPanel orderOut:self];
    logView.backgroundColor = bcWell.color;
    
    NSData *colorData = [NSArchiver archivedDataWithRootObject:logView.backgroundColor];
    [[NSUserDefaults standardUserDefaults] setObject:colorData forKey:@"colorKey"];
}

- (IBAction)send:(id)sender
{
    // Get system's current time & add information to log (console)
    NSDateFormatter *formatter;
    NSString        *timeStr;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyy HH:mm"];
    timeStr = [formatter stringFromDate:[NSDate date]];
 
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


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    settingsPanel.isVisible = false;
    
    [_window setReleasedWhenClosed:false];
    [loader setHidden:true];
    [sendingStr setHidden:true];
    
    // Sidebar console properties
    [logView setEditable:false];
    [logView setRichText:false];
    [logView setAlignment:NSCenterTextAlignment];
    [logView setBackgroundColor:[NSColor gridColor]];
    
    // Restore saved preferences
    NSColor *color = nil;
    NSData  *data  = [[NSUserDefaults standardUserDefaults] dataForKey:@"colorKey"];
    
    if (data != nil) {
        color = (NSColor*)[NSUnarchiver unarchiveObjectWithData:data];
        logView.backgroundColor = color;
    }
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag
{
    [_window setIsVisible:true];
    return true;
}

@end
