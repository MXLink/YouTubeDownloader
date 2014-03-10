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

#import "utilities.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
BOOL isPad(void)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	static NSInteger isPad = -1;
	if (isPad < 0)
	{
		isPad = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) ? 1 : 0;
	}
	return isPad == 1;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
BOOL isPhone(void)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	static NSInteger isPhone = -1;
	if (isPhone < 0)
	{
		isPhone = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) ? 1 : 0;
	}
	return isPhone == 1;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
NSString* FormatViewCount(NSString *viewCount)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	return [formatter stringFromNumber:[NSNumber numberWithInteger:[viewCount integerValue]]];
}
