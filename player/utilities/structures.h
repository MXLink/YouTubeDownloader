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

//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface videoItem : NSObject
//-------------------------------------------------------------------------------------------------------------------------------------------------

@property (nonatomic, retain) NSString	*videoid;
@property (nonatomic, retain) NSString	*thumb;
@property (nonatomic, retain) NSString	*title;
@property (nonatomic, retain) NSString	*author;
@property (nonatomic, retain) NSString	*viewcnt;

- (id)initWith:(NSString *)videoid_ Thumb:(NSString *)thumb_ Title:(NSString *)title_ Author:(NSString *)author_ ViewCnt:(NSString *)viewcnt_;

@end
