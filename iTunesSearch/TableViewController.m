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

@interface TableViewController () {
    NSArray *midias;
}

@end

@implementation TableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    iTunesManager *itunes = [iTunesManager sharedInstance];
    midias = [itunes buscarMidias:@"Apple"];
    
//#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
    self.tableview.tableHeaderView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, self.textfield.bounds.size.height+90.f)];
    
    //textfield
    self.textfield = [[UITextField alloc] initWithFrame:CGRectMake(15.f, 51.f, 230.f, 30.f)];
    [self.textfield setBorderStyle:UITextBorderStyleRoundedRect];
    [self.tableview.tableHeaderView addSubview:self.textfield];
    
    //button Search
    self.buttonSearch = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.buttonSearch.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.buttonSearch.titleLabel.font = [UIFont fontWithName:@"FranklinGothicStd-ExtraCond" size:20.0];
    [self.buttonSearch setTitle:@"Search" forState:UIControlStateNormal];
    [self.buttonSearch setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.buttonSearch.frame = CGRectMake(self.textfield.bounds.size.width+20.f, 51.f, 65.f, 30.f);
    self.buttonSearch.layer.borderWidth = 2.0f;
    self.buttonSearch.layer.borderColor = [UIColor grayColor].CGColor;
    self.buttonSearch.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.buttonSearch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [midias count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    Filme *filme = [midias objectAtIndex:indexPath.row];
    
    [celula.nome setText:filme.nome];
    [celula.trackId setText:[NSString stringWithFormat:@"%@",filme.trackId]];
    [celula.artista setText:filme.artista];
    [celula.duracao setText:[NSString stringWithFormat:@"%@",filme.duracao]];
    [celula.genero setText:filme.genero];
    [celula.pais setText:filme.pais];
    [celula.tipo setText:@"Filme"];
    
    return celula;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 210;
}


@end
