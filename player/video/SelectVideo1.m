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
#import "structures.h"

#import "SelectVideo1.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface SelectVideo1()
{
	NSString *selected;
	
	NSInteger start;
	NSString *orderby;
}
@end
//-------------------------------------------------------------------------------------------------------------------------------------------------

@implementation SelectVideo1

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (id)initWith:(NSString *)selected_
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	self = [super init];
	selected = [selected_ copy];
	return self;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [super viewDidLoad];
	self.title = selected;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sort" style:UIBarButtonItemStyleBordered
																			 target:self action:@selector(sortButtonPress:)];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	start = 1;
	orderby = @"relevance";
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[NSThread detachNewThreadSelector:@selector(loadVideo:) toTarget:self withObject:nil];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)sortButtonPress:(id)sender
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Search Options: Sort by" delegate:self cancelButtonTitle:@"Cancel"
								destructiveButtonTitle:nil otherButtonTitles:@"Relevance", @"Upload Date", @"View Count", @"Rating", nil];
	[actionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if ([buttonTitle isEqualToString:@"Relevance"])		orderby = @"relevance";
	if ([buttonTitle isEqualToString:@"Upload Date"])	orderby = @"published";
	if ([buttonTitle isEqualToString:@"View Count"])	orderby = @"viewCount";
	if ([buttonTitle isEqualToString:@"Rating"])		orderby = @"rating";
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if ([buttonTitle isEqualToString:@"Cancel"] == NO)
	{
		start = 1; [self.items removeAllObjects]; [self.tableView reloadData];
		//-----------------------------------------------------------------------------------------------------------------------------------------
		[NSThread detachNewThreadSelector:@selector(loadVideo:) toTarget:self withObject:nil];
	}
}

#pragma mark - Table view data source

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if (indexPath.row == [self.items count]-1) [NSThread detachNewThreadSelector:@selector(loadVideo:) toTarget:self withObject:nil];
}

#pragma mark - Loading videos

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)loadVideo:(id)sender
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[ProgressHUD show:@"Loading..."];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	NSString *tmp = [selected stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	NSString *link = [NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos?alt=json&v=2&key=%@&format=1", YOUTUBE_KEY];
	link = [link stringByAppendingFormat:@"&safeSearch=none&q=%@&start-index=%ld&max-results=50&orderby=%@", tmp, (long) start, orderby];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:link]];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
	operation.responseSerializer = [AFJSONResponseSerializer serializer];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
											{ [self didComplete:responseObject]; start += 50; }
									 failure:^(AFHTTPRequestOperation *operation, NSError *error)
											{ [ProgressHUD showError:@"Failed"]; }];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[[NSOperationQueue mainQueue] addOperation:operation];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)didComplete:(NSDictionary *)response
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	NSInteger count = [[response valueForKeyPath:@"feed.entry"] count];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (count == 0) { [ProgressHUD showError:@"No video found."]; return; }
	//---------------------------------------------------------------------------------------------------------------------------------------------
	for (NSInteger i=0; i<count; i++)
	{
		NSDictionary *entry = [[response valueForKeyPath:@"feed.entry"] objectAtIndex:i];
		//-----------------------------------------------------------------------------------------------------------------------------------------
		NSString *videoid	= [entry valueForKeyPath:@"media$group.yt$videoid.$t"];
		NSString *thumb		= [[[entry valueForKeyPath:@"media$group.media$thumbnail"] objectAtIndex:1] valueForKey:@"url"];
		NSString *title		= [entry valueForKeyPath:@"title.$t"];
		NSString *author	= [[[entry valueForKeyPath:@"media$group.media$credit"] objectAtIndex:0] valueForKey:@"yt$display"];
		NSString *viewcnt	= [entry valueForKeyPath:@"yt$statistics.viewCount"];
		//-----------------------------------------------------------------------------------------------------------------------------------------
		videoItem *item = [[videoItem alloc] initWith:videoid Thumb:thumb Title:title Author:author ViewCnt:viewcnt];
		[self.items addObject:item];
	}
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[ProgressHUD dismiss];
	[self.tableView reloadData];
}

@end
