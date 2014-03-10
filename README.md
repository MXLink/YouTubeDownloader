[![RelatedCode](http://relatedcode.com/github/header.png)](http://relatedcode.com)

## OVERVIEW

YouTubeDownloader is a full native iPhone app to search, list, play and download YouTube videos.

![YouTubeDownloader](http://relatedcode.com/github/youtubedownloader1.png)
.
![YouTubeDownloader](http://relatedcode.com/github/youtubedownloader2.png)
.
![YouTubeDownloader](http://relatedcode.com/github/youtubedownloader3.png)
<br>
![YouTubeDownloader](http://relatedcode.com/github/youtubedownloader4.png)
.
![YouTubeDownloader](http://relatedcode.com/github/youtubedownloader5.png)
.
![YouTubeDownloader](http://relatedcode.com/github/youtubedownloader6.png)

The video player is using MPMoviePlayerController (not WebView) so it's fast and the video quality is better.

The video list is using native UITableView with automatic loading at the bottom (endless scrolling). You can sort the search list by Relevance, Upload Date, View Count and Rating.

You can choose the quality of the video when clicking download.

You can share the videos with iOS built in options (Facebook, Twitter, Flickr, Mail, SMS).

Really easy to setup, just copy/paste the code and use your custom search terms.

## FEATURES

- Search, list, play and download YouTube videos
- Full screen and embedded video playback
- Infinite video listing (endless scrolling)
- Sort videos by Relevance, Upload Date, View Count and Rating
- Share videos (Facebook, Twitter, Flickr, Mail, SMS)
- Using MPMoviePlayerController
- Native user interface
- Video quality options on download

## REQUIREMENTS

- Xcode 5
- iOS 7
- ARC

## INSTALLATION

1., All YouTubeDownloader files located in *player* directory. Vendor files located in *vendor* directory. Simply add *player* and *vendor* directories to your project.

2., You need the following iOS (built in) libraries: UIKit.framework, CoreGraphics.framework, Foundation.framework.

To add libraries follow these steps: Click on the Targets → Your app name → and then the 'Build Phases' tab and then expand 'Link Binary With Libraries'. Click the plus button in the bottom left of the 'Link Binary With Libraries' section and choose library items from the list.

3., The *Prefix.pch* should contain:

```
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
```

4., You also need two external libraries: AFNetworking, ProgressHUD (which are included). But if you need, you can download from here:

https://github.com/AFNetworking/AFNetworking<br>
https://github.com/relatedcode/ProgressHUD<br>

To use this two libraries, just add AFNetworking and ProgressHUD directories to your project.

5., You should use your own YouTube API key. You can get your YouTube API key here:

https://developers.google.com/youtube/registering_an_application<br>
https://code.google.com/apis/console<br>

6., Replace existing API key in *common.h*:

```
#define YOUTUBE_KEY @"AIzaSyAY5wyhp7vnjxHnmMG7iYFvytVfsf6M3Dc"
```

## CONTACT

Do you have any questions or idea? My email is: info@relatedcode.com or you can find some more info at [relatedcode.com](http://relatedcode.com)

## LICENSE

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
