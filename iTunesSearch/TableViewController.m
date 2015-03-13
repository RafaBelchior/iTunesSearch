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
    self.tableview.tableHeaderView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, self.textfield.bounds.size.height+90.f)];
    
    //textfield
    self.textfield = [[UITextField alloc] initWithFrame:CGRectMake(15.f, 51.f, 200.f, 30.f)];
    [self.textfield setBorderStyle:UITextBorderStyleRoundedRect];
    [self.tableview.tableHeaderView addSubview:self.textfield];
    
    //button Search
    self.buttonSearch = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.buttonSearch.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.buttonSearch.titleLabel.font = [UIFont fontWithName:@"FranklinGothicStd-ExtraCond" size:20.0];
    [self.buttonSearch setTitle:NSLocalizedString(@"Search", nil) forState:UIControlStateNormal];
    [self.buttonSearch setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.buttonSearch.frame = CGRectMake(self.textfield.bounds.size.width+20.f, 51.f, 95.f, 30.f);
    self.buttonSearch.layer.borderWidth = 2.0f;
    self.buttonSearch.layer.borderColor = [UIColor grayColor].CGColor;
    self.buttonSearch.backgroundColor = [UIColor clearColor];
    [self.buttonSearch addTarget:self action:@selector(buttonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonSearch];
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
    
    NSInteger contagem;
    
    switch (section) {
        case 0:
            contagem = [itunes.movies count];
            break;
        case 1:
            contagem = [itunes.podcasts count];
            break;
        case 2:
            contagem = [itunes.songs count];
            break;
        case 3:
            contagem = [itunes.tvepisodes count];
            break;
        default:
            contagem = 0;
            break;
    }
    return contagem;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    Filme *filme;
    switch (indexPath.section) {
        case 0:
            filme = [itunes.movies objectAtIndex:indexPath.row];
            break;
        case 1:
            filme = [itunes.podcasts objectAtIndex:indexPath.row];
            break;
        case 2:
            filme = [itunes.songs objectAtIndex:indexPath.row];
            break;
        case 3:
            filme = [itunes.tvepisodes objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }
    
    [celula.nome setText:filme.nome];
    [celula.trackId setText:[NSString stringWithFormat:@"#%@",filme.trackId]];
    [celula.artista setText:filme.artista];
    [celula.duracao setText:[NSString stringWithFormat:@"%dmin",[filme.duracao intValue]/60000]];
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
    switch (indexPath.section) {
        case 0:
            dvc.filme = [itunes.movies objectAtIndex:indexPath.row];
            break;
        case 1:
            dvc.filme = [itunes.podcasts objectAtIndex:indexPath.row];
            break;
        case 2:
            dvc.filme = [itunes.songs objectAtIndex:indexPath.row];
            break;
        case 3:
            dvc.filme = [itunes.tvepisodes objectAtIndex:indexPath.row];
            break;
        default:
            dvc.filme = [itunes.movies objectAtIndex:indexPath.row];
            break;
    }
    [self.navigationController pushViewController:dvc animated:YES];
    
}

-(IBAction) buttonTouchUpInside:(id)sender{
    self.buttonSearch = sender;
    midias = [itunes buscarMidias:self.textfield.text];
    [self.textfield resignFirstResponder];
    [self.tableview reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName = NSLocalizedString((@"%@",[itunes.sectionsOrden objectAtIndex:section]), nil);
    return sectionName;
}
@end
