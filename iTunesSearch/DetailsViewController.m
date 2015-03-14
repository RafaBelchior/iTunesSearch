//
//  DetailsViewController.m
//  iTunesSearch
//
//  Created by Rafael Souza Belchior da Silva on 12/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    Filme *filme = self.filme;
    [self.nome setText:filme.nome];
    [self.trackId setText:[NSString stringWithFormat:@"#%@",filme.trackId]];
    [self.artist setText:filme.artista];
    [self.duracao setText:[NSString stringWithFormat:@"%.02fmin",[filme.duracao floatValue]/60000]];
    [self.genero setText:filme.genero];
    [self.pais setText:filme.pais];
    [self.tipo setText:filme.tipo];
    NSURL* aURL = [NSURL URLWithString:filme.imagem];
    NSData* data = [[NSData alloc] initWithContentsOfURL:aURL];
    [self.image setImage:[UIImage imageWithData:data]];
    
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
