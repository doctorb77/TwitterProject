# Project 6 - TwitterDark

TwitterDark is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: 15 hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User sees app icon in home screen and styled launch screen
- [x] User can sign in using OAuth login flow
- [x] User can Logout
- [x] Data model classes
- [x] User can view last 20 tweets from their home timeline with the user profile picture, username, tweet text, and timestamp.
- [x] User can pull to refresh.
- [x] User can tap the retweet and favorite buttons in a tweet cell to retweet and/or favorite a tweet.
- [x] Using AutoLayout, the Tweet cell should adjust it's layout for iPhone 7, Plus and SE device sizes as well as accommodate device rotation.

The following **stretch** features are implemented:

- [x] The current signed in user will be persisted across restarts
- [x] Each tweet should display the relative timestamp for each tweet "8m", "7h"
- [x] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [x] Links in tweets are clickable.
- [ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.

The following **additional** features are implemented:

- [x] Retweet icon to signify if a given tweet is original content or was retweeted by the useradditional
- [x] Custom retweet and favorite icons made to support the dark theme
- [x] Highlighted Hashtags and User mentions
- [x] Username set as title and custom navBarButton with the user's profile picture
- [x] Customized UIActivityIndicator for when tweets are loading in
- [x] Refresh background displays the user's twitter background picture if they have one whenever they pull down to refresh the page
- [x] Detail view has custom animaitons on buttons for following and replying to tweets / users
- [x] Favorite and retweet icons have custom animations
- [x] Custom theming on detail view to show accounts associated with tweet

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):


## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://i.imgur.com/u1k0g94.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

This walkthrough shows the user persitence:
<img src='https://i.imgur.com/w2BnxxO.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Could not for the life of me figure out how to do infinite scrolling

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [ActiveLabel](https://github.com/optonaut/ActiveLabel.swift) - custom label library
- [DateTools](https://github.com/MatthewYork/DateTools) - robust date library

## License

Copyright 2018 Brendan Raftery

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
