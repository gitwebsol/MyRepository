//
//  Config.m
//  Emerald
//
//  Created by ColtBoys on 12/21/12.
//  Copyright (c) 2012 coltboy. All rights reserved.
//

#import "Config.h"
#import "Tools.h"

// DO NOT EDIT
#define FeedCellSize 240;
#define PhotoCellSize 240;
#define VideoCellSize 240;
// END DO NOT EDIT




//Controllers
#define TabControllers @"feed/トップ,social/ポイント,more/説明,game/ゲーム,otherGame/リアトモ"


// Style
#define MainFont @"パズルアイドル"
#define MainFontSize 20
#define MainColor @"#A83F6F"
//Feed
#define FeedSharingMessage @""
#define FeedUrl @"http://iphone.lparty.jp/events/xml"
#define FeedSearchUrl @"http://iphone.lparty.jp/events/search"
//@"http://iphone.lparty.jp/events/search"
#define FeedTitleColor @"#000000"
#define FeedArticleFontSize 14
#define FeedTitleFontSize 14
#define FavouritesEnabled @"YES"
#define FeedRibbonEnabled @"YES"
#define FeedArticleTextColor @"#000000"
//Photo
#define PhotoSharingMessage @"写真をシェアします: "
#define PhotoUrl @"http://coltboy.com/products/Emerald/photos.xml"
#define PhotoTitleColor @"#000000"

#define PhotoRibbonEnabled @"YES"
//Video
#define VideoSharingMessage @"You can change this text : "
#define VideoUrl @"http://182.48.52.97/a0/index.xml"
#define VideoTitleColor @"#000000"

#define VideoRibbonEnabled @"YES"
//Audio
#define AudioUrl @"http://coltboy.com/products/Emerald/audio.xml"
#define AudioFontSize 19
#define AudioTextColor @"#ffffff"
#define AudioRibbonEnabled @"YES"
#define AudioColor @"#22967c"
#define AudioSharingMessage @"You can change this text : "
//More
#define MoreCells @"favorites#お気に入り;url#http://lparty.jp/company#運営会社;text#\n1．著作権当ウェブサイトに記載されている内容の著作権は、NRIグループ及びコンテンツの作者に帰属します。当ウェブサイト及びそのコンテンツを使用できるのは、著作権法上「私的使用のための複製」及び「引用」などの場合に限られています。この場合、出典を明記してください。なお、「私的使用のための複製」や「引用」の範囲を超える場合には、NRIの使用許諾が必要になります。使用許諾のお申し込みやお問い合わせは、NRIコーポレートコミュニケーション部（Tel.03-6270-8100／information@nri.co.jp）にご連絡ください。\n\n2．リンク当ウェブサイトへのリンクは自由です。ただし、違法または公序良俗に反するとNRIが考えるサイトからのリンクや、当ウェブサイトへのリンクであるということが不明確になる手段でのリンクについてはお断りすることがあります。トップページ以外にリンクされた場合には、そのページのコンテンツやURLが、予告なしに変更又は廃止される可能性があることをご了解ください。\n\n3．準拠法および管轄裁判所当ウェブサイトおよび「サイト利用規定」の解釈および適用は、日本国法に準拠します。また、当ウェブサイトに関わる全ての紛争については、他に別段の定めのない限り、東京地方裁判所を第一審の専属管轄裁判所とします。\n\n4．対応ブラウザ当ウェブサイトを閲覧する際には、Microsoft Internet Explorer 6.0以上、Firefox 3.0以上のブラウザの使用を推奨します。これら推奨ブラウザ以外でご覧いただく場合、画面の一部が正しく表示されないことがありますので、ご了解ください。\n\n5．プラグイン当ウェブサイトに収録されているPDFファイルをご覧いただくには、Adobe Readerが必要です。当ウェブサイトに収録されている一部コンテンツはFlashが使われております。これらのコンテンツをご覧いただくためには、Adobe Flashが必要です。この他、コンテンツによっては別途プラグインが必要となる場合もあります。各コンテンツのプラグイン情報等をご参照ください。\n\n6．お問い合わせ先当ウェブサイト・当社についてご意見・ご質問などがある場合は、「お問い合わせ」ページをご確認の上、各担当までメールにてご連絡下さい。お問い合わせ先が不明の場合は、NRIコーポレートコミュニケーション部（Tel.03-6270-8100）にご連絡ください。\n\n\n\n\n\n#利用規定;url#http://lparty.jp/contract#お問い合わせ;text#プライバシーポリシー\n\nレディースパーティー 公式街コンサイトでは、当ホームページ（以下、「当サイト」といいます。）の運営に 際し、お客様のプライバシーを尊重し個人情報に対して十分な配慮を行うと共に大切に保護し、適正 な管理を行うことに努めております。\n\n法令及び規範の遵守\n当委員会は、当委員会が収集し利用する個人情報を保護するため、個人情報に関する法令及びその 他の関係法令およびこれに基づくガイドライン等の規範を遵守します。\n\n個人情報の範囲\n当事務局の事業活動の過程で収集した、個人を特定できる情報を範囲とします。 当委員会の業務内 容につきましては、ホームページに掲載している、業務内容等をご覧下さい。 具体的には、当事務局が 業務活動の過程で、書面、電子媒体、ウェブ等を介して収集した、氏名、住所、電話番号、メールアドレ ス、勤務先、役職、生年月日その他の記述により当該　個人を識別できるもの（当該情報のみでは識別 できないが、他の情報から容易に照合することができ、それにより当該個人を識別できるものを含みま す）を個人情報保護の対象範囲とします。\n\n個人情報の利用目的\n法令により認められる場合を除き、次の各号の利用目的の範囲内で個人情報を取扱います。 クライ アント、委託元から委託される懸賞・キャンペーンなどの販売促進業務の遂行のため、応募者の個人 情報を取扱います。 商品・サービス、キャンペーン、イベント等のご案内に関するメール送信のため、送 信に同意いただいた方の個人情報を取扱います。 ECビジネス等における決済・物流サービスの遂行 のため、利用者の個人情報を取扱います。 お問合せ時のご本人確認ならびに内容確認のため、ご本 人の個人情報を取扱います。 イベントへの参加募集行為、またイベントスタッフの採用に関するご応 募をいただく際の審査のため、応募店及び応募者の個人情報を取扱います。 人事・労務管理のため、 従業員の個人情報を取扱います。 セキュリティ管理のため、来訪者の画像を取扱います。\n\n個人情報の第三者提供\n法令等による場合、業務の一部を外部に委託する場合を除き、本人の同意を得ずに個人情報を第三 者に提供することはありません。\n\n個人情報取扱いの委託\n業務運営上、お客様により良いサービスを提供するために、業務の一部を外部に委託することがあり ます。その際に業務委託先に個人情報を預けることがあります。この場合、十分な個人情報の保護 の水準を満たしている委託先を選定し、個人情報の保護に関する委託契約を締結すると共に、委託 先に対する管理・監督を徹底します。\n\n個人情報についての苦情・相談・権利\nご本人より個人情報に関する利用目的の通知または開示、訂正・追加・削除、利用の停止・消去（以 下併せて「開示等」といいます。）のお申し出があったときは、法令等に従い、誠実に対応致します。\n\n個人情報の訂正・削除・開示\nご本人から、登録されている個人情報について訂正・削除・開示の請求があった場合は、迅速に対応 致します。\n\nお問合せ窓口\n個人情報についての苦情・相談または個人情報の開示等のお問合せはお問い合わせフォームからお 願い致します。\n\n個人情報を提供されることの任意性について\n当委員会へ個人情報を提供されるかどうかは、ご本人の任意によるものです。ただし、必要な項目を 提供頂けない場合、契約の締結やサービスの提供が行えない場合がございます。 当社の個人情報保 護方針に重要な変更がある場合は、当社ホームページに掲載することにより告知致します。\n\n年令制限について\n年令制限に関しては、お申込みの時点で本街コンに同意することになります。また、20才未満の方のご参加についてはご遠慮させていただきます。\n\nダイレクトメールの取扱いについて\n当社が提供するサービスにおいて、お客様に対しお客様本人の同意の下、ダイレクトメールを送る場合 があります。このダイレクトメールは当社が現在、あるいは将来において提供するさまざまな商品やサー ビスに関連する情報ならびに広告主からの情報を電子メールで知らせするものです。 これらのダイレ クトメールを送信するのは、当社もしくはお客様が同意いただき、かつ、当社と機密保持契約を取り交 わした協力企業に限られ、当該ダイレクトメールを送信する場合は、提供元を明記致します。\n\nその他個人情報の取扱いについての留意点\nインターネット上で個人情報を誰もがアクセスできる形で公開した場合、その情報は、他のインターネ ット利用者によって収集されまたは利用される可能性があることにご留意下さい。お客様ご自身の個 人情報の取扱いには十分にご注意くださいますようお願いします。個別のサービス毎に特に定める場 合を除き、本ホームページの検索結果や掲載広告などのコンテンツからリンクされている第三者のサ イトおよびサービスは、当社とは独立した個人情報の保護に関する規定やデータの収集の規定を定め ております。当事務局は、これらの独立した規約や活動に対していかなる義務や責任も負いかねます。 個人情報の提供にあたっては、各サイトの定める規約等を事前にご確認下さい。#プライバシーポリシー"
#define MoreFontSize 19
#define MoreTextColor @"#000000"
//Strings
#define StringLoading @"読込中"
#define StringPublishOn @"公開中"
#define StringRemoveFromList @"お気に入りから外す"
#define StringReadItLater @"お気に入り登録"
#define StringShare @"シェアする"
#define StringCancel @"キャンセル"
#define StringOK @"OK"
#define StringTwitterAccountMissing @"Twitterのアカウントがありません。"
#define StringTwitterAccountMissingMessage @"Twitterのアカウントが設定されていません。設定からアカウントを登録してください。"
#define StringFacebookAppMissing @"Facebook App missing"
#define StringFacebookAppMissingMessage @"Please download the official facebook application to share this content."
#define StringError @"Error"
#define StringErrorMessage @"We are unable to refresh the content at this time. Please try again in a moment"
#define StringNetworkError @"No network connection"
#define StringNetworkErrorMessage @"It appears there is no avalaible network connection. Try to find a WiFi point or look at your device settings"
#define StringAudioStreamingError @"We can not load this song at the moment, please try again later"
//
@implementation Config
+(NSString *)getTabControllers{
    return TabControllers;
}

//Style
+(UIColor *)getMainColor{
    return [Tools colorWithHexString:MainColor];
}
+(UIFont *)getMainFont{
    return [UIFont fontWithName:MainFont size:MainFontSize];
}
//Feed
+(NSString *)getFeedSharingMessage{
    return FeedSharingMessage;
}
+(NSString *)getFeedUrl{
    return FeedUrl;
}
+(NSString *)getFeedSearchUrl{
    return FeedSearchUrl;
}

+(NSString *)getFeedFontString{
    return MainFont;
}
+(float)getFeedArticleSize{
    return FeedArticleFontSize;
}
+(UIFont *)getFeedFont{
    return [UIFont fontWithName:MainFont size:FeedTitleFontSize];
}
+(UIColor *)getFeedTitleColor{
    return [Tools colorWithHexString:FeedTitleColor];
}
+(CGFloat)getFeedCellSize{
    return FeedCellSize;
}
+(BOOL)isFavouritesEnabled{
    if ([FavouritesEnabled isEqualToString:@"YES"]) {
        return YES;
    }
    else
    {
        return NO;
    }
}
+(BOOL)isFeedRibbonEnabled{
    if ([FeedRibbonEnabled isEqualToString:@"YES"]) {
        return YES;
    }
    else
    {
        return NO;
    }
}
+(UIColor *)getFeedArticleTextColor{
    return [Tools colorWithHexString:FeedArticleTextColor];
}
+(NSString *)getFeedArticleTextColorString{
    return FeedArticleTextColor;
}
//Photo
+(NSString *)getPhotoSharingMessage{
    return PhotoSharingMessage;
}
+(NSString *)getPhotoUrl{
    return PhotoUrl;
}
+(UIColor *)getPhotoTitleColor{
    return [Tools colorWithHexString:PhotoTitleColor];
}
+(CGFloat)getPhotoCellSize{
    return PhotoCellSize;
}
+(BOOL)isPhotoRibbonEnabled{
    if ([PhotoRibbonEnabled isEqualToString:@"YES"]) {
        return YES;
    }
    else
    {
        return NO;
    }
}
//Video
+(NSString *)getVideoSharingMessage{
    return VideoSharingMessage;
}
+(NSString *)getVideoUrl{
    return VideoUrl;
}
+(UIColor *)getVideoTitleColor{
    return [Tools colorWithHexString:PhotoTitleColor];
}
+(CGFloat)getVideoCellSize{
    return VideoCellSize;
}
+(BOOL)isVideoRibbonEnabled{
    if ([VideoRibbonEnabled isEqualToString:@"YES"]) {
        return YES;
    }
    else
    {
        return NO;
    }
}
//Audio
+(NSString *)getAudioUrl{
    return AudioUrl;
}
+(UIFont *)getAudioFont{
    return [UIFont fontWithName:MainFont size:AudioFontSize];
}
+(UIColor *)getAudioTextColor{
    return [Tools colorWithHexString:AudioTextColor];
}
+(BOOL)getAudioRibbonEnabled{
    if ([AudioRibbonEnabled isEqualToString:@"YES"]) {
        return YES;
    }
    else
    {
        return NO;
    }
}
+(UIColor *)getAudioColor{
    return [Tools colorWithHexString:AudioColor];
}
+(NSString *)getAudioSharingMessage{
    return AudioSharingMessage;
}
//More
+(NSString *)getMoreCellString{
    return MoreCells;
}
+(UIFont *)getMoreFont{
    return [UIFont fontWithName:MainFont size:MoreFontSize];
}
+(UIColor *)getMoreTextColor{
    return [Tools colorWithHexString:MoreTextColor];
}
//Strings
+(NSString *)getStringPublishedOn{
    return StringPublishOn;
}
+(NSString *)getStringRemoveFromList{
    return StringRemoveFromList;
}
+(NSString *)getStringReadItLater{
    return StringReadItLater;
}
+(NSString *)getStringShare{
    return StringShare;
}
+(NSString *)getStringCancel{
    return StringCancel;
}
+(NSString *)getStringOK{
    return StringOK;
}
+(NSString *)getStringTwitterAccountMissing{
    return StringTwitterAccountMissing;
}
+(NSString *)getStringTwitterAccountMissingMessage{
    return StringTwitterAccountMissingMessage;
}
+(NSString *)getStringFacebookAppMissing{
    return StringFacebookAppMissing;
}
+(NSString *)getStringFacebookAppMissingMessage{
    return StringFacebookAppMissingMessage;
}
+(NSString *)getStringError{
    return StringError;
}
+(NSString *)getStringErrorMessage{
    return StringErrorMessage;
}
+(NSString *)getStringNetworkError{ 
    return StringNetworkError;
}
+(NSString *)getStringNetworkErrorMessage{
    return StringNetworkErrorMessage;
}
+(NSString *)getStringAudioError{
    return StringAudioStreamingError;
}

+(BOOL)isiPhone5 {
    return ([UIScreen mainScreen].bounds.size.height == 568.0)?YES:NO;
}
@end
