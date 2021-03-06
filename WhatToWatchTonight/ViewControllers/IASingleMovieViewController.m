#import "IASingleMovieViewController.h"
#import "IAMovie.h"
#import "IAMovieDbClient.h"
#import "IAUrlConstants.h"
#import "MBProgressHUD.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "IAAppDelegate.h"
#import "IAUIConstants.h"

@implementation IASingleMovieViewController
{
    IAMovie *_movie;
    IAMovieDbClient *_client;
    NSDictionary *_parameters;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadMovie];

}

-(void) loadMovie {
    _client = [[IAMovieDbClient alloc] init];
    _parameters = @{
                    IAApiKeyName : IAApiKeyValue
                    };
    NSString *url = [IAUrlMovieById stringByAppendingString:[NSString stringWithFormat:@"%ld", self.movieID]];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak id weakSelf = self;
    [_client GET:url parameters:_parameters completion:^(OVCResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            IAAppDelegate *delegate = (IAAppDelegate *)[UIApplication sharedApplication].delegate;
            
            UIAlertController *alert = [delegate showErrorWithTitle:@"ERROR" andMessage:[error localizedDescription]];
            [MBProgressHUD hideHUDForView:[weakSelf view] animated:YES];
            if (error != nil) {
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
            else {
                _movie = response.result;
                [self setMovie];
            }
        });
    }];
}

-(void)setMovie {
    UIImage *defaultImage = [UIImage imageNamed:@"noImage"];

    self.title = _movie.title;
    if (_movie.budget) {
        self.budget.text = [NSString stringWithFormat:@"%@ $", [_movie.budget stringValue]];

    }
    else {
        self.budget.text = IANoInformation;
    }
    if (_movie.urlImage != nil) {
        NSURL *imageUrl = [NSURL URLWithString:[IAImageBigBaseUrl stringByAppendingString:_movie.urlImage]];
        [self.image sd_setImageWithURL:imageUrl
                      placeholderImage:defaultImage];
    }
    else {
        self.image.image = defaultImage;
    }
    if (_movie.genres) {
        self.genres.text = [self appendGenres];
    }
    else {
        self.genres.text = IANoInformation;
    }
    if (_movie.releaseDate) {
        self.releaseDate.text = _movie.releaseDate;
    }
    else {
        self.releaseDate.text = IANoInformation;
    }
    if (_movie.runtime != 0) {
        self.runtime.text = [NSString stringWithFormat:@"%@ minutes",[_movie.runtime stringValue]];
    }
    else {
        self.runtime.text = IANoInformation;
    }
    if (_movie.revenue != 0) {
        self.revenue.text = [NSString stringWithFormat:@"%@ $", [_movie.revenue stringValue]];
    }
    else {
        self.revenue.text = IANoInformation;
    }
    if (_movie.voteAverage != 0) {
        self.voteAverage.text = [_movie.voteAverage stringValue];
    }
    else {
        self.voteAverage.text = IANoInformation;
    }
    if (_movie.overview) {
        self.overview.text = _movie.overview;
    }
    else {
        self.overview.text = IANoInformation;
    }
    
    [self.overview setNumberOfLines:0];
    [self.overview sizeToFit];
}
-(NSString *) appendGenres {
    NSMutableString *genres = [[NSMutableString alloc] init];
    for (int i = 0; i < _movie.genres.count; i++) {
        NSString *genre = [_movie.genres[i] name];
        [genres appendString:genre];
        if (i != _movie.genres.count - 1) {
            [genres appendString:@", "];
        }
    }
    
    return genres;
}
@end
