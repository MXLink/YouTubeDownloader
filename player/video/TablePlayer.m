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

#import <AVFoundation/AVFoundation.h>
#import "AFNetworking.h"
#import "ProgressHUD.h"

#import "parseutils.h"
#import "utilities.h"

#import "TablePlayer.h"
#import "AppDelegate.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface TablePlayer()
{
	videoItem *video;

	NSMutableArray *items1;
	NSMutableArray *items2;

	NSDictionary *resolutions;
	NSMutableDictionary *links;
}
@end
//-------------------------------------------------------------------------------------------------------------------------------------------------

@implementation TablePlayer

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (id)initWith:(videoItem *)video_
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	self = [super init];
	video = video_;
	return self;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewDidLoad];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackStateChanged)
												 name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished)
												 name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	links = [[NSMutableDictionary alloc] init];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	resolutions = @{
	  @"5" : @"240p", @"6" : @"270p", @"13" : @"N/A", @"17" : @"144p", @"18" : @"270p/360p", @"22" : @"720p", @"34" : @"360p", @"35" : @"480p",
	  @"36" : @"240p", @"37" : @"1080p", @"38" : @"3072p", @"43" : @"360p", @"44" : @"480p", @"45" : @"720p", @"46" : @"1080p", @"82" : @"360p",
	  @"83" : @"240p", @"84" : @"720p", @"85" : @"520p", @"100" : @"360p", @"101" : @"360p", @"102" : @"720p", @"120" : @"720p", @"133" : @"240p",
	  @"134" : @"360p", @"135" : @"480p", @"136" : @"720p", @"137" : @"1080p", @"139" : @"N/A", @"140" : @"N/A", @"141" : @"N/A", @"160" : @"144p"};
	//---------------------------------------------------------------------------------------------------------------------------------------------
	items1 = [[NSMutableArray alloc] init];
	items2 = [[NSMutableArray alloc] init];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[items1 addObject:itemDetailBold(video.title)];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[items1 addObject:itemDetail([NSString stringWithFormat:@"%@ views", FormatViewCount(video.viewcnt)])];
	[items1 addObject:itemDetail([NSString stringWithFormat:@"Uploaded by %@", video.author])];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[items2 addObject:itemMenu(@"Share")];
	[items2 addObject:itemMenu(@"Download")];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[self.sections addObject:items1];
	[self.sections addObject:items2];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewWillAppear:animated];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if ([self isMovingToParentViewController] == YES)
	{
		CGFloat width = self.view.bounds.size.width;
		CGFloat height = width / 320 * 200;
		//-----------------------------------------------------------------------------------------------------------------------------------------
		UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
		headerView.backgroundColor = [UIColor blackColor];
		self.tableView.tableHeaderView = headerView;
		//-----------------------------------------------------------------------------------------------------------------------------------------
		[self playVideo:video.videoid];
	}
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if ([self isMovingToParentViewController] == NO) [self.player.view setFrame:self.tableView.tableHeaderView.bounds];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillDisappear:(BOOL)animated
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewWillDisappear:animated];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if ([self isMovingFromParentViewController]) [self.player stop];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[self.player.view setFrame:self.tableView.tableHeaderView.bounds];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (isPhone())
	{
		if ((self.player.playbackState == MPMoviePlaybackStatePlaying) &&
			(UIDeviceOrientationIsLandscape([self interfaceOrientation])))	[self.player setFullscreen:YES animated:YES];
	}
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void) playbackStateChanged
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if (isPhone())
	{
		if ((self.player.playbackState == MPMoviePlaybackStatePlaying) &&
			(UIDeviceOrientationIsLandscape([self interfaceOrientation])))	[self.player setFullscreen:YES animated:YES];
	}
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void) playbackFinished
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[self.player setFullscreen:NO animated:YES];
}

#pragma mark - Table view delegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	tableItem *tmp = [[self.sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if ([tmp.text1 isEqualToString:@"Share"])
	{
		NSString *link = [NSString stringWithFormat:@"http://www.youtube.com/watch?v=%@", video.videoid];
		//-----------------------------------------------------------------------------------------------------------------------------------------
		NSArray *data = @[video.title, link];
		//-----------------------------------------------------------------------------------------------------------------------------------------
		UIActivityViewController* activityController = [[UIActivityViewController alloc] initWithActivityItems:data applicationActivities:nil];
		[self presentViewController:activityController animated:YES completion:^{}];
	}
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if ([tmp.text1 isEqualToString:@"Download"])
	{
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select video resolution" delegate:self cancelButtonTitle:nil
												   destructiveButtonTitle:nil otherButtonTitles:nil, nil];
		//-----------------------------------------------------------------------------------------------------------------------------------------
		for (NSString *item in [links allKeys]) [actionSheet addButtonWithTitle:item];
		//-----------------------------------------------------------------------------------------------------------------------------------------
		actionSheet.cancelButtonIndex = [links count]; [actionSheet addButtonWithTitle:@"Cancel"];
		//-----------------------------------------------------------------------------------------------------------------------------------------
		[actionSheet showInView:self.view];
	}
}

#pragma mark - UIActionSheetDelegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if ([buttonTitle isEqualToString:@"Cancel"] == NO)
	{
		AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		[app downloadVideo:[links valueForKey:buttonTitle]];
	}
}

#pragma mark - Playing video

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)playVideo:(NSString *)videoid
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	NSString *link = [NSString stringWithFormat:@"https://www.youtube.com/get_video_info?video_id=%@", videoid];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:link]];
	AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
											{ [self didComplete:operation.responseData]; }
									 failure:^(AFHTTPRequestOperation *operation, NSError *error)
											{ NSLog(@"playVideo failed: %@", error); }];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[[NSOperationQueue mainQueue] addOperation:operation];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)didComplete:(NSData *)response
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	NSString *linkVideo = @"";
	//---------------------------------------------------------------------------------------------------------------------------------------------
	NSString *videoQuery = [[NSString alloc] initWithData:response encoding:NSASCIIStringEncoding];
	NSDictionary *videoDict = DictionaryWithQueryString(videoQuery, NSUTF8StringEncoding);
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (videoDict[@"errorcode"] != nil) { [ProgressHUD showError:@"Sorry, this video can only be played on YouTube."]; return; }
	//---------------------------------------------------------------------------------------------------------------------------------------------

	//---------------------------------------------------------------------------------------------------------------------------------------------
	NSArray *streamQueries = [videoDict[@"url_encoded_fmt_stream_map"] componentsSeparatedByString:@","];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	for (NSString *streamQuery in streamQueries)
	{
		NSDictionary *stream = DictionaryWithQueryString(streamQuery, NSUTF8StringEncoding);
		if ([AVURLAsset isPlayableExtendedMIMEType:stream[@"type"]])
		{
			NSString *itag = stream[@"itag"];
			NSString *link = [NSString stringWithFormat:@"%@&signature=%@", stream[@"url"], stream[@"sig"]];
			//-------------------------------------------------------------------------------------------------------------------------------------
			if ([itag isEqualToString:@"37"] == NO) if ([linkVideo isEqualToString:@""]) linkVideo = link;
			//-------------------------------------------------------------------------------------------------------------------------------------
			[links setObject:link forKey:[resolutions valueForKey:itag]];
		}
	}
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if ([linkVideo isEqualToString:@""] == NO)
	{
		self.player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:linkVideo]];
		[self.player prepareToPlay];
		[self.player.view setFrame:self.tableView.tableHeaderView.bounds];
		[self.tableView.tableHeaderView addSubview:self.player.view];
		[self.player play];
	}
}

@end
