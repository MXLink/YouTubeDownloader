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
@interface tableItem : NSObject
//-------------------------------------------------------------------------------------------------------------------------------------------------

@property (nonatomic, retain) NSString	*itemid;

@property (nonatomic, retain) UIColor	*colorBack;

@property (nonatomic, retain) NSString	*image1;
@property (nonatomic, retain) NSString	*image2;
@property (nonatomic, retain) NSString	*image3;

@property (nonatomic) NSInteger lines1;
@property (nonatomic, retain) NSString	*text1;
@property (nonatomic, retain) UIFont	*font1;
@property (nonatomic, retain) UIColor	*color1;

@property (nonatomic) NSInteger lines2;
@property (nonatomic, retain) NSString	*text2;
@property (nonatomic, retain) UIFont	*font2;
@property (nonatomic, retain) UIColor	*color2;

@property (nonatomic) BOOL accessory;
@property (nonatomic) BOOL selection;

- (id)initWith:(NSString *)ItemId
	 ColorBack:(UIColor *)ColorBack
		Image1:(NSString *)Image1 Image2:(NSString *)Image2 Image3:(NSString *)Image3
		Lines1:(NSInteger)Lines1 Text1:(NSString *)Text1 Font1:(UIFont *)Font1 Color1:(UIColor *)Color1
		Lines2:(NSInteger)Lines2 Text2:(NSString *)Text2 Font2:(UIFont *)Font2 Color2:(UIColor *)Color2
	 Accessory:(BOOL)Accessory Selection:(BOOL)Selection;

@end
//-------------------------------------------------------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------------------------------------------------------
tableItem* itemMenu			(NSString *text);
tableItem* itemDetail		(NSString *text);
tableItem* itemDetailBold	(NSString *text);
//-------------------------------------------------------------------------------------------------------------------------------------------------
