//
// Copyright (c) 2014 Related Code - http://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AFNetworking.h"
#import "ProgressHUD.h"

#import "common.h"

#import "AppDelegate.h"
#import "TableSearch.h"

@implementation AppDelegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[[TableSearch alloc] init]];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	navController.navigationBar.translucent = NO;
	navController.navigationBar.barTintColor = COLOR_TITLE;
	navController.navigationBar.tintColor = COLOR_TITLETEXT;
	navController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:COLOR_TITLETEXT};
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[self.window setRootViewController:navController];
	[self.window makeKeyAndVisible];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	return YES;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)downloadVideo:(NSString *)link
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[ProgressHUD showSuccess:@"Download started."];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	NSString *dir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *file = [NSString stringWithFormat:@"%d.mov", (NSInteger) [[NSDate date] timeIntervalSince1970]];
	NSString *path = [dir stringByAppendingPathComponent:file];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:link]];
	AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
											{ [self saveVideo:path]; }
									 failure:^(AFHTTPRequestOperation *operation, NSError *error)
											{ [ProgressHUD showError:@"Video download error."]; }];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[[NSOperationQueue mainQueue] addOperation:operation];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)saveVideo:(NSString *)path
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path))
	{
		UISaveVideoAtPathToSavedPhotosAlbum(path, self, @selector(video:didFinishSavingWithError:contextInfo:), NULL);
	}
	else [ProgressHUD showError:@"Cannot save video."];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if (error == nil)
	{
		[ProgressHUD showSuccess:@"Video saved successfully."];
	}
	else [ProgressHUD showError:@"Video save error."];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)applicationDidBecomeActive:(UIApplication *)application
//-------------------------------------------------------------------------------------------------------------------------------------------------
{

}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)applicationWillResignActive:(UIApplication *)application
//-------------------------------------------------------------------------------------------------------------------------------------------------
{

}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)applicationDidEnterBackground:(UIApplication *)application
//-------------------------------------------------------------------------------------------------------------------------------------------------
{

}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)applicationWillEnterForeground:(UIApplication *)application
//-------------------------------------------------------------------------------------------------------------------------------------------------
{

}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)applicationWillTerminate:(UIApplication *)application
//-------------------------------------------------------------------------------------------------------------------------------------------------
{

}

@end
