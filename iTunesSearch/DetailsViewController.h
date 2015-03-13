//
//  DetailsViewController.h
//  iTunesSearch
//
//  Created by Rafael Souza Belchior da Silva on 12/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Filme.h"
@interface DetailsViewController : UIViewController
@property (strong,nonatomic) Filme *filme;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *nome;
@property (weak, nonatomic) IBOutlet UILabel *trackId;
@property (weak, nonatomic) IBOutlet UILabel *artist;
@property (weak, nonatomic) IBOutlet UILabel *duracao;
@property (weak, nonatomic) IBOutlet UILabel *genero;
@property (weak, nonatomic) IBOutlet UILabel *pais;
@property (weak, nonatomic) IBOutlet UILabel *tipo;

@end
