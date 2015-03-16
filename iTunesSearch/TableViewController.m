//
//  ViewController.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import "Filme.h"
#import "DetailsViewController.h"

@interface TableViewController () {
    NSArray *midias;
    iTunesManager *itunes;
}

@end

@implementation TableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    itunes = [iTunesManager sharedInstance];
    midias = [[NSArray alloc] init];
    
//#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
    self.tableview.tableHeaderView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, self.textfield.bounds.size.height+50.f)];
    
    //textfield
    self.textfield = [[UITextField alloc] initWithFrame:CGRectMake(15.f, 9.f, 200.f, 30.f)];
    [self.textfield setBorderStyle:UITextBorderStyleRoundedRect];
    [self.tableview.tableHeaderView addSubview:self.textfield];
    
    //button Search
    self.buttonSearch = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.buttonSearch.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.buttonSearch.titleLabel.font = [UIFont fontWithName:@"FranklinGothicStd-ExtraCond" size:20.0];
    [self.buttonSearch setTitle:NSLocalizedString(@"Search", nil) forState:UIControlStateNormal];
    [self.buttonSearch setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.buttonSearch.frame = CGRectMake(self.textfield.bounds.size.width+20.f, 9.f, 95.f, 30.f);
    self.buttonSearch.layer.borderWidth = 2.0f;
    self.buttonSearch.layer.borderColor = [UIColor grayColor].CGColor;
    self.buttonSearch.backgroundColor = [UIColor clearColor];
    self.buttonSearch.hidden = true;
    [self.buttonSearch addTarget:self action:@selector(buttonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonSearch];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.textfield.text = [defaults objectForKey:@"infoString"];
    midias = [itunes buscarMidias:self.textfield.text];
    self.textfield.returnKeyType = UIReturnKeyDone;
    [self.textfield setDelegate:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [itunes.sectionsOrden count];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Ideia inicial
//    int contagem;
//    for (int m=0; m< [itunes.sections count]; m++) {
//        for (int i=0; i< [midias count]; i++) {
//            Filme *filme = [midias objectAtIndex:i];
//            if ([itunes.sections objectAtIndex:m] == filme.tipo) {
//                contagem++;
//            }
//        }
//    }
//    return contagem;
    
    //Funcionando mas troca arrays
//    NSInteger contagem;
//    
//    switch (section) {
//        case 0:
//            contagem = [itunes.movies count];
//            break;
//        case 1:
//            contagem = [itunes.podcasts count];
//            break;
//        case 2:
//            contagem = [itunes.songs count];
//            break;
//        case 3:
//            contagem = [itunes.tvepisodes count];
//            break;
//        default:
//            contagem = 0;
//            break;
//    }
//    return contagem;
    
    
    //ideia:Comparar o elemento i do vetor de sections, com o elemento 1 do vetor de cada tipo!!!!!!!
    //FAZER UM ARRAY DE ARRAY, MOVIES SERIA A POSICAO 0. SOH PEGAR PELA SECTION
    NSInteger contagem;

    if ([[itunes.sectionsOrden objectAtIndex:section] isEqualToString: @"feature-movie"]) {
        contagem = [itunes.movies count];
    }else{
        if ([[itunes.sectionsOrden objectAtIndex:section] isEqualToString:@"music-video"]) {
            contagem = [itunes.musicvideos count];
        }else{
            if ([[itunes.sectionsOrden objectAtIndex:section] isEqualToString:@"podcast"]) {
                contagem = [itunes.podcasts count];
            }else{
                if ([[itunes.sectionsOrden objectAtIndex:section] isEqualToString:@"song"]) {
                    contagem = [itunes.songs count];
                }else{
                    if ([[itunes.sectionsOrden objectAtIndex:section] isEqualToString:@"tv-episode"]) {
                        contagem = [itunes.tvepisodes count];
                    }else{
                        contagem = [itunes.outros count];
                    }
                }
            }
        }
    }
    
    return contagem;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    Filme *filme;
//    switch (indexPath.section) {
//        case 0:
//            filme = [itunes.movies objectAtIndex:indexPath.row];
//            break;
//        case 1:
//            filme = [itunes.podcasts objectAtIndex:indexPath.row];
//            break;
//        case 2:
//            filme = [itunes.songs objectAtIndex:indexPath.row];
//            break;
//        case 3:
//            filme = [itunes.tvepisodes objectAtIndex:indexPath.row];
//            break;
//        default:
//            break;
//    }
    
    if ([[itunes.sectionsOrden objectAtIndex:indexPath.section] isEqualToString: @"feature-movie"]) {
        filme = [itunes.movies objectAtIndex:indexPath.row];
    }else{
        if ([[itunes.sectionsOrden objectAtIndex:indexPath.section] isEqualToString:@"music-video"]) {
            filme = [itunes.musicvideos objectAtIndex:indexPath.row];
        }else{
            if ([[itunes.sectionsOrden objectAtIndex:indexPath.section] isEqualToString:@"podcast"]) {
                filme = [itunes.podcasts objectAtIndex:indexPath.row];
            }else{
                if ([[itunes.sectionsOrden objectAtIndex:indexPath.section] isEqualToString:@"song"]) {
                    filme = [itunes.songs objectAtIndex:indexPath.row];
                }else{
                    if ([[itunes.sectionsOrden objectAtIndex:indexPath.section] isEqualToString:@"tv-episode"]){
                        filme = [itunes.tvepisodes objectAtIndex:indexPath.row];
                    }else{
                        filme = [itunes.outros objectAtIndex:indexPath.row];
                    }
                }
            }
        }
    }
    
    [celula.nome setText:filme.nome];
    [celula.trackId setText:[NSString stringWithFormat:@"#%@",filme.trackId]];
    [celula.artista setText:filme.artista];
    [celula.duracao setText:[NSString stringWithFormat:@"%.02fmin",[filme.duracao floatValue]/60000]];
    [celula.genero setText:filme.genero];
    [celula.pais setText:filme.pais];
    [celula.tipo setText:filme.tipo];
    NSURL* aURL = [NSURL URLWithString:filme.imagem];
    NSData* data = [[NSData alloc] initWithContentsOfURL:aURL];
    [celula.imagem setImage:[UIImage imageWithData:data]];
    
    return celula;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 210;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsViewController *dvc = [[DetailsViewController alloc] init];
//    switch (indexPath.section) {
//        case 0:
//            dvc.filme = [itunes.movies objectAtIndex:indexPath.row];
//            break;
//        case 1:
//            dvc.filme = [itunes.podcasts objectAtIndex:indexPath.row];
//            break;
//        case 2:
//            dvc.filme = [itunes.songs objectAtIndex:indexPath.row];
//            break;
//        case 3:
//            dvc.filme = [itunes.tvepisodes objectAtIndex:indexPath.row];
//            break;
//        default:
//            dvc.filme = [itunes.movies objectAtIndex:indexPath.row];
//            break;
//    }
    if ([[itunes.sectionsOrden objectAtIndex:indexPath.section] isEqualToString: @"feature-movie"]) {
        dvc.filme = [itunes.movies objectAtIndex:indexPath.row];
    }else{
        if ([[itunes.sectionsOrden objectAtIndex:indexPath.section] isEqualToString:@"music-video"]) {
            dvc.filme = [itunes.musicvideos objectAtIndex:indexPath.row];
        }else{
            if ([[itunes.sectionsOrden objectAtIndex:indexPath.section] isEqualToString:@"podcast"]) {
                dvc.filme = [itunes.podcasts objectAtIndex:indexPath.row];
            }else{
                if ([[itunes.sectionsOrden objectAtIndex:indexPath.section] isEqualToString:@"song"]) {
                    dvc.filme = [itunes.songs objectAtIndex:indexPath.row];
                }else{
                    if ([[itunes.sectionsOrden objectAtIndex:indexPath.section] isEqualToString:@"tv-episode"]){
                        dvc.filme = [itunes.tvepisodes objectAtIndex:indexPath.row];
                    }else{
                        dvc.filme = [itunes.outros objectAtIndex:indexPath.row];
                    }
                }
            }
        }
    }
    [self.navigationController pushViewController:dvc animated:YES];
}

-(IBAction) buttonTouchUpInside:(id)sender{
    self.buttonSearch = sender;
    self.buttonSearch.hidden = true;
    midias = [itunes buscarMidias:self.textfield.text];
    [self.textfield resignFirstResponder];
    [self.tableview reloadData];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:self.textfield.text forKey:@"infoString"];
    [defaults synchronize];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSString *sectionName = NSLocalizedString((@"%@",[itunes.sectionsOrden objectAtIndex:section]), nil);
//    return sectionName;
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.tableview.frame.size.width,0)];
    sectionView.backgroundColor = [UIColor grayColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, tableView.frame.size.width, 18)];
    NSString *sectionName = NSLocalizedString((@"%@",[itunes.sectionsOrden objectAtIndex:section]), nil);
    label.text = sectionName;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(300, 3, 16, 16)];
    imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",sectionName]];
    [sectionView addSubview:imgView];
    [sectionView addSubview:label];
    return sectionView;
}

-(void) textFieldDidBeginEditing:(UITextField *)textField{
    self.buttonSearch.hidden = YES;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self validateTextField:self.textfield.text];
    return YES;
}

-(void) validateTextField:(NSString *)termo{
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[A-Z0-9a-z]{1,100}$" options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *match = [regex firstMatchInString:termo options:0 range:NSMakeRange(0, [termo length])];
    if (match) {
        self.buttonSearch.hidden = false;
    }
}

@end
