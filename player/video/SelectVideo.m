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

#import "UIImageView+AFNetworking.h"
#import "ProgressHUD.h"

#import "common.h"
#import "utilities.h"

#import "SelectVideo.h"
#import "TablePlayer.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
@implementation SelectVideo

@synthesize items;

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [super viewDidLoad];

	self.tableView.rowHeight = 90.f;

	items = [[NSMutableArray alloc] init];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillDisappear:(BOOL)animated
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewWillDisappear:animated];

	if ([self isMovingFromParentViewController]) [ProgressHUD dismiss];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	return YES;
}

#pragma mark - Table view data source

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	return 1;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	return [items count];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	videoItem *video = [items objectAtIndex:indexPath.row];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	cell.textLabel.text = video.title;
	cell.textLabel.font = [UIFont fontWithName:FONT_BOLD size:12];
	cell.textLabel.numberOfLines = 2;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\n%@ views", video.author, FormatViewCount(video.viewcnt)];
	cell.detailTextLabel.font = [UIFont fontWithName:FONT_NORMAL size:12];
	cell.detailTextLabel.numberOfLines = 2;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[cell.imageView setImageWithURL:[NSURL URLWithString:video.thumb] placeholderImage:[UIImage imageNamed:@"blankvideo"]];
	[cell.imageView.layer setBorderWidth:2];
	[cell.imageView.layer setBorderColor:[UIColor whiteColor].CGColor];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	return cell;
}

#pragma mark - Table view delegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	videoItem *video = [items objectAtIndex:indexPath.row];
	TablePlayer *tablePlayer = [[TablePlayer alloc] initWith:video];
	[self.navigationController pushViewController:tablePlayer animated:YES];
}

@end
