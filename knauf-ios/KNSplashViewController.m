//
//  KNSplashViewController.m
//  knauf-ios
//
//  Created by User on 19.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNSplashViewController.h"
#import "KNDataClient.h"
#import "KNChoiceViewController.h"

#import "AFNetworking.h"
#import <SSZipArchive/SSZipArchive.h>
#import <Reachability/Reachability.h>


@interface KNSplashViewController () <KNDataClientDelegate>

@property (nonatomic) AFURLSessionManager *sessionManager;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic) BOOL connected;
@property (strong, nonatomic) KNDataClient *dataClient;

@end

@implementation KNSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self.throbber startAnimating];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [self updateInterfaceWithReachability:self.internetReachability];
    
    if (self.connected) {
        [self loadBD];

    } else {
        [self errorMessage];
    }
}

-(void)updateInterfaceWithReachability: (Reachability*) curReach
{
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    if ((netStatus  > 0) && (!self.connected)) {
        self.connected = YES;
    }
    if (netStatus == 0) {
        self.connected = NO;
    }
}

-(void)reachabilityChanged:(NSNotification* )note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    [self updateInterfaceWithReachability: curReach];
}

-(void)loadBD
{
    NSURLRequest *requestBD = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:urlBD]];
    
    self.sessionManager = [[AFURLSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    self.sessionManager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];

    [[self.sessionManager downloadTaskWithRequest:requestBD progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *url = [[[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil] URLByAppendingPathComponent:response.suggestedFilename];
        
        return url;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//                NSFileManager *filemgr;
//        
//                filemgr = [NSFileManager defaultManager];
//                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//                NSString *docs = [paths objectAtIndex:0];
//                NSString* path =  [docs stringByAppendingFormat:@"/test1.sqlite"];
////                NSString *newPath = [[path stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"/Images1.zip"];
////                NSURL *assa = [NSURL URLWithString:path];
////                [[NSFileManager defaultManager] moveItemAtPath:path toPath:newPath error:nil];
//                if ([filemgr fileExistsAtPath: path ] == YES)
//                    NSLog (@"File exists");
//                else
//                    NSLog (@"File not found");
//                [SSZipArchive unzipFileAtPath:path toDestination: docs];
//                NSDirectoryEnumerator *fileEnumerator = [filemgr enumeratorAtPath:docs];
//        
//                for (NSString *filename in fileEnumerator) {
//                    NSLog(@"filename %@", filename);
//                }
        if (!error) {
            self.dataClient = [KNDataClient sharedInstance];
            self.dataClient.delegate = self;
            [self loadImages];
//            self.dataClient = [KNDataClient sharedInstance];
//            self.dataClient.delegate = self;
        } else {
            [self errorMessage];
        }
        NSLog(@"completionHandler %@ %@",filePath, error);
        
    }] resume];
//
    [self.sessionManager setDownloadTaskDidWriteDataBlock:^(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        CGFloat progress = (CGFloat)totalBytesWritten/totalBytesExpectedToWrite;
        //[downloadTask cancel];
             NSLog(@"downloadTaskDidWrite %f <%@>",progress,downloadTask);
    }];

}

-(void) loadImages
{
//                    NSFileManager *filemgr;
//    
//                    filemgr = [NSFileManager defaultManager];
//                    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//                    NSString *docs = [paths objectAtIndex:0];
//                    NSString* path =  [docs stringByAppendingFormat:@"/test1.sqlite"];
//    //                NSString *newPath = [[path stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"/Images1.zip"];
//    //                NSURL *assa = [NSURL URLWithString:path];
//    //                [[NSFileManager defaultManager] moveItemAtPath:path toPath:newPath error:nil];
//                    if ([filemgr fileExistsAtPath: path ] == YES)
//                        NSLog (@"File exists");
//                    else
//                        NSLog (@"File not found");
//                    NSDirectoryEnumerator *fileEnumerator = [filemgr enumeratorAtPath:docs];
//    
//                    for (NSString *filename in fileEnumerator) {
//                        NSLog(@"filename %@", filename);
//                    }
//    NSURLRequest *requestImages = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:urlImages]];
//    [[self.sessionManager downloadTaskWithRequest:requestImages progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//        NSURL *url = [[[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil] URLByAppendingPathComponent:response.suggestedFilename];
//        return url;
//    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//                        NSFileManager *filemgr;
//                        filemgr = [NSFileManager defaultManager];
//                        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//                        NSString *docs = [paths objectAtIndex:0];
//                        NSString* path =  [docs stringByAppendingFormat:@"/Images.zip"];
//                        NSString *newPath = [[path stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"/Images1.zip"];
//                        NSURL *assa = [NSURL URLWithString:path];
//                        [[NSFileManager defaultManager] moveItemAtPath:path toPath:newPath error:nil];
//                        if ([filemgr fileExistsAtPath: path ] == YES)
//                            NSLog (@"File exists");
//                        else
//                            NSLog (@"File not found");
//                        [SSZipArchive unzipFileAtPath:newPath toDestination: docs];
//                        NSDirectoryEnumerator *fileEnumerator = [filemgr enumeratorAtPath:docs];
//        
//                        for (NSString *filename in fileEnumerator) {
//                            NSLog(@"filename %@", filename);
//                        }
//        if (!error) {
//            self.dataClient = [KNDataClient sharedInstance];
//
//        } else {
//            [self errorMessage];
//        }
//        NSLog(@"completionHandler %@ %@",filePath, error);
//        
//    }] resume];
//    
//    [self.sessionManager setDownloadTaskDidWriteDataBlock:^(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
//        CGFloat progress = (CGFloat)totalBytesWritten/totalBytesExpectedToWrite;
//             NSLog(@"1downloadTaskDidWrite %f <%@>",progress,downloadTask);
//    }];

}

-(void)errorMessage
{
    UIAlertController * view = [UIAlertController
                                alertControllerWithTitle:@"!!!"
                                message:@"Сетевая ошибка"
                                preferredStyle:UIAlertControllerStyleAlert ];
    UIAlertAction * cancel= [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action) {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                             }];
    [view   addAction: cancel];
    
    //проверка есть ли база
    [self presentViewController:view animated:YES completion:nil];
}

-(void)loadData
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    KNChoiceViewController *vc = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([KNChoiceViewController class])];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:vc];
    navVC.navigationBar.hidden = YES;
    [self presentViewController:navVC animated:YES completion:nil];
}

@end
