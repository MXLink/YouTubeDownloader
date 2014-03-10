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

#import "structures.h"

@implementation videoItem

@synthesize videoid, thumb, title, author, viewcnt;

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (id)initWith:(NSString *)videoid_ Thumb:(NSString *)thumb_ Title:(NSString *)title_ Author:(NSString *)author_ ViewCnt:(NSString *)viewcnt_
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	self = [super init];
	videoid	= [videoid_ copy];
	thumb	= [thumb_ copy];
	title	= [title_ copy];
	author	= [author_ copy];
	viewcnt	= [viewcnt_ copy];
	return self;
}

@end
