//
//  TestViewController.m
//  Runner
//
//  Created by Charles on 2020/2/26.
//

#import "TestViewController.h"
#import <WebKit/WebKit.h>
#import "JDHttpTool.h"

// 账号信息
NSString * const HWAppKey = @"3212157982";
NSString * const HWRedirectURI = @"http://www.baidu.com";
NSString * const HWAppSecret = @"3f24b3b21f75d8cf5d4201dc3683167f";

@interface TestViewController ()<WKNavigationDelegate>
@property(nonatomic, strong)WKWebView *webView;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", HWAppKey, HWRedirectURI];
    self.view.backgroundColor = [UIColor redColor];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    self.webView.navigationDelegate = self;
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.webView loadRequest:request];
    
    [self.view addSubview:self.webView];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}



    // 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString * urlStr = navigationAction.request.URL.absoluteString;
    NSLog(@"发送跳转请求：%@",urlStr);
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length != 0) { // 是回调地址
        // 截取code=后面的参数值
        NSUInteger fromIndex = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:fromIndex];
        // 利用code换取一个accessToken
        [self accessTokenWithCode:code];
        // 禁止加载回调地址
        decisionHandler(WKNavigationActionPolicyCancel);
        
    }else{
      decisionHandler(WKNavigationActionPolicyAllow);
    }

}

/**
 *  利用code（授权成功后的request token）换取一个accessToken
 *
 *  @param code 授权成功后的request token
 */
- (void)accessTokenWithCode:(NSString *)code
{
    // 1.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = HWAppKey;
    params[@"client_secret"] = HWAppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = HWRedirectURI;
    params[@"code"] = code;
    
    [JDHttpTool POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(id json) {
        NSLog(@"josn == %@",json);
    } failure:^(NSError *error) {
        NSLog(@"error == %@",error);
    }];

}
    
   

@end
