#import "IAMovie.h"
#import "IAFormatterHelper.h"
#import "IAGenre.h"

@implementation IAMovie

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"movieId": @"id",
             @"title": @"title",
             @"overview": @"overview",
             @"budget" : @"budget",
             @"releaseDate" : @"release_date",
             @"genres": @"genres",
             @"urlImage" : @"poster_path",
             @"runtime" : @"runtime",
             @"revenue" : @"revenue",
             @"voteAverage" : @"vote_average"
             };
}

+(NSValueTransformer *) genresJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:IAGenre.class];
}


@end
