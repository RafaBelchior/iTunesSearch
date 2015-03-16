//
//  iTunesManager.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "iTunesManager.h"
#import "Entidades/Filme.h"

@implementation iTunesManager

static iTunesManager *SINGLETON = nil;

static bool isFirstAccess = YES;
@synthesize sections, sectionsOrden, tvepisodes, songs, movies, podcasts, musicvideos, outros;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}


- (NSArray *)buscarMidias:(NSString *)termo {
    if (!termo) {
        termo = @"";
    }
    
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    NSError *error;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    if (error) {
        //NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
        return nil;
    }
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    NSMutableArray *filmes = [[NSMutableArray alloc] init];
    sections = [[NSMutableArray alloc] init];
    songs = [[NSMutableArray alloc] init];
    movies = [[NSMutableArray alloc] init];
    podcasts = [[NSMutableArray alloc] init];
    tvepisodes = [[NSMutableArray alloc] init];
    musicvideos = [[NSMutableArray alloc] init];
    outros = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in resultados) {
        Filme *filme = [[Filme alloc] init];
        [filme setNome:[item objectForKey:@"trackName"]];
        [filme setTrackId:[item objectForKey:@"trackId"]];
        [filme setArtista:[item objectForKey:@"artistName"]];
        [filme setDuracao:[item objectForKey:@"trackTimeMillis"]];
        [filme setGenero:[item objectForKey:@"primaryGenreName"]];
        [filme setPais:[item objectForKey:@"country"]];
        [filme setTipo:[item objectForKey:@"kind"]];
        [filme setImagem:[item objectForKey:@"artworkUrl100"]];
        
        if ([SINGLETON.sections containsObject:filme.tipo] ) {
            
        }else{
            [SINGLETON.sections addObject:filme.tipo];
        }
        
        if ([filme.tipo  isEqualToString: @"feature-movie"]) {
            [SINGLETON.movies addObject:filme];
        }else{
            if ([filme.tipo isEqualToString:@"music-video"]) {
                [SINGLETON.musicvideos addObject:filme];
            }else{
                if ([filme.tipo isEqualToString:@"podcast"]) {
                    [SINGLETON.podcasts addObject:filme];
                }else{
                    if ([filme.tipo isEqualToString:@"song"]) {
                        [SINGLETON.songs addObject:filme];
                    }else{
                        if ([filme.tipo isEqualToString:@"tv-episode"]){
                            [SINGLETON.tvepisodes addObject:filme];
                        }else{
                            [SINGLETON.outros addObject:filme];
                        }
                    }
                }
            }
        }
        [filmes addObject:filme];
    }

    sectionsOrden = [sections sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    return filmes;
}




#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[iTunesManager alloc] init];
}

- (id)mutableCopy
{
    return [[iTunesManager alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    return self;
}


@end
