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

#import "TableBlank.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
@implementation TableBlank

@synthesize headers;
@synthesize sections;

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (id)init
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	self = [super initWithStyle:UITableViewStyleGrouped];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	return self;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewDidLoad];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	headers = [[NSMutableArray alloc] init];
	sections = [[NSMutableArray alloc] init];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillDisappear:(BOOL)animated
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewWillDisappear:animated];
	//---------------------------------------------------------------------------------------------------------------------------------------------
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
	return [sections count];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	return [[sections objectAtIndex:section] count];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if ([headers count] == 0) return nil;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	return [headers objectAtIndex:section];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	tableItem *tmp = [[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	cell.backgroundColor = (tmp.colorBack == nil) ? [UIColor whiteColor] : tmp.colorBack;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	tableItem *tmp = [[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	CGRect r1 = CGRectZero, r2 = CGRectZero;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	CGSize size = CGSizeMake([self widthText], CGFLOAT_MAX);
	NSInteger options = NSStringDrawingUsesLineFragmentOrigin;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (tmp.text1 != nil)
	{
		if (tmp.lines1 != 0) r1 = [@"AAAAAA" boundingRectWithSize:size options:options attributes:@{NSFontAttributeName:tmp.font1} context:NULL];
		if (tmp.lines1 == 0) r1 = [tmp.text1 boundingRectWithSize:size options:options attributes:@{NSFontAttributeName:tmp.font1} context:NULL];
	}
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (tmp.text2 != nil)
	{
		if (tmp.lines2 != 0) r2 = [@"AAAAAA" boundingRectWithSize:size options:options attributes:@{NSFontAttributeName:tmp.font2} context:NULL];
		if (tmp.lines2 == 0) r2 = [tmp.text2 boundingRectWithSize:size options:options attributes:@{NSFontAttributeName:tmp.font2} context:NULL];
	}
	//---------------------------------------------------------------------------------------------------------------------------------------------
	CGFloat height1 = (tmp.lines1 == 0) ? r1.size.height : r1.size.height * tmp.lines1;
	CGFloat height2 = (tmp.lines2 == 0) ? r2.size.height : r2.size.height * tmp.lines2;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	CGFloat height = height1 + height2 + 20;
	if (height < 44) height = 44;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	return height;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (float)widthText
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	CGFloat margin;
	CGFloat width = self.tableView.frame.size.width;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (width <= 400) margin = 20;
	if (width >= 401 && width < 547) margin = 40;
	if (width >= 547 && width < 560) margin = 41;
	if (width >= 560 && width < 573) margin = 42;
	if (width >= 573 && width < 586) margin = 43;
	if (width >= 586 && width < 599) margin = 44;
	if (width >= 599 && width < 612) margin = 45;
	if (width >= 612 && width < 625) margin = 46;
	if (width >= 625 && width < 639) margin = 47;
	if (width >= 639 && width < 652) margin = 48;
	if (width >= 652 && width < 665) margin = 49;
	if (width >= 665 && width < 678) margin = 50;
	if (width >= 678 && width < 691) margin = 51;
	if (width >= 691 && width < 704) margin = 52;
	if (width >= 704 && width < 717) margin = 53;
	if (width >= 717) margin = 55;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	return width - 2 * margin;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	tableItem *tmp = [[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	cell.textLabel.text = tmp.text1;
	cell.textLabel.font = tmp.font1;
	cell.textLabel.textColor = tmp.color1;
	cell.textLabel.numberOfLines = tmp.lines1;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	cell.detailTextLabel.text = tmp.text2;
	cell.detailTextLabel.font = tmp.font2;
	cell.detailTextLabel.textColor = tmp.color2;
	cell.detailTextLabel.numberOfLines = tmp.lines2;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	cell.accessoryType = tmp.accessory ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
	cell.selectionStyle = tmp.selection ? UITableViewCellSelectionStyleBlue : UITableViewCellSelectionStyleNone;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	cell.imageView.image = nil;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if ((tmp.image1 != nil) && (tmp.image2 != nil))
		[cell.imageView setImageWithURL:[NSURL URLWithString:tmp.image1] placeholderImage:[UIImage imageNamed:tmp.image2]];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (tmp.image3 != nil) cell.imageView.image = [UIImage imageWithContentsOfFile:tmp.image3];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	return cell;
}

@end
