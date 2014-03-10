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

#import "TableSearch.h"
#import "SelectVideo1.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface TableSearch()
{
	NSMutableArray *items;
}
@end
//-------------------------------------------------------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------------------------------------------------------
@implementation TableSearch

@synthesize searchbar;

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewDidLoad];
	self.title = @"Search";
	//---------------------------------------------------------------------------------------------------------------------------------------------
	searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	searchbar.delegate = self;
	self.tableView.tableHeaderView = searchbar;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	items = [[NSMutableArray alloc] init];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
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
	if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

	cell.textLabel.text = [items objectAtIndex:indexPath.row];

	return cell;
}

#pragma mark - Table view delegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	self.searchbar.text = @"";
	[self.searchbar resignFirstResponder];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	NSString *selected = [items objectAtIndex:indexPath.row];
	SelectVideo1 *selectVideo1 = [[SelectVideo1 alloc] initWith:selected];
	[self.navigationController pushViewController:selectVideo1 animated:YES];
}

#pragma mark - UISearchBarDelegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar	{	[searchBar setShowsCancelButton:YES animated:YES];	}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar		{	[searchBar setShowsCancelButton:NO animated:YES];	}
//-------------------------------------------------------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	searchBar.text = @"";
	[searchBar resignFirstResponder];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	NSString *entered = searchBar.text;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	searchBar.text = @"";
	[searchBar resignFirstResponder];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	SelectVideo1 *selectVideo1 = [[SelectVideo1 alloc] initWith:entered];
	[self.navigationController pushViewController:selectVideo1 animated:YES];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[items insertObject:entered atIndex:0];
	[self.tableView reloadData];
}

@end
