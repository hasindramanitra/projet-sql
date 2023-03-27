/*creation de la base de données carmap et ses tables;*/

create table parking_floor(
    num_parking_floor int(11) primary key auto_increment,
    label_parking_floor varchar(255)
);

create parking_spot(
    num_parking_spot int(11) primary key auto_increment,
    color_parking_spot varchar(255),
    is_free boolean,
    num_parking_floor int(11),
    foreign key (num_parking_floor) references parking_floor(num_parking_floor)
);

create table exit_gate(
    num_exit_gate int(11) primary key auto_increment,
    label_exit_gate varchar(255),
    num_parking_floor int(11),
    foreign key (num_parking_floor) references parking_floor(num_parking_floor)
);

create table car(
    num_car varchar(255) primary key unique,
    brand_car varchar(255),
    model_car varchar(255),
    type_car varchar(255),
    color_car varchar(255)
);

create table parc(
    num_car varchar(255),
    num_parking_spot varchar(255),
    num_exit_gate varchar(255),
    date_time_arrival date,
    date_time_departure date,
    primary key(num_car, num_parking_spot, num_exit_gate),
    foreign key (num_car) references car(num_car),
    foreign key (num_parking_spot) references parking_spot(num_parking_spot),
    foreign key (num_exit_gate) references exit_gate(num_exit_gate)
);


/*modification de la table parking_spot et creation de la table parking_rate*/

use carmap;
drop hourly_price_parking_spot;

create table parking_rate(
    num_parking_rate int(11) primary key auto_increment,
    hourly_price float,
    discount int(11)
);

alter table parking_floor
add num_parking_rate int(11);

alter table parking_floor
add foreign key (num_parking_rate) references parking_floor(num_parking_rate);



/*les requêtes */

/*affichage de tous les parking floor*/
select * from parking_floor;

/*affichage de tous les parking_spot*/
select * from parking_spot;

/*affichage des parking_spot de couleur "red"*/
select * from parking_spot where color_parking_spot="red";

/*affichage du label des exit_gate appartenant au parking_floor numero"1"*/
select label_exit_gate from exit_gate where num_parking_floor = 1;

/*affichage de la marque et le type de toutes les car*/
select brand_car, type_car from car ;

/*affichage de toutes les car de marque "mercedes" ou "renault"*/
select * from car where brand_car="mercedes" or brand_car="renault";

/*affichage de nombres de car*/
select count(*) from car;

/*affichage des parking_spot pour chaque parking_floor*/
select * from parking_spot GROUP BY num_parking_floor;

/*affichage du total des parking_spot pour chaque parking_floor*/
SELECT  COUNT(*) FROM parking_spot GROUP BY num_parking_floor;;

/*affichage du numero, marque, modèle des car garé dans les parking_spot (par le label_parking_spot)*/
SELECT car.num_car, brand_car, model_car, label_parking_spot FROM car LEFT JOIN parc ON car.num_car = parc.num_car RIGHT JOIN parking_spot ON parc.num_parking_spot = parking_spot.num_parking_spot;


/*affichage de nombres d'utilisation de chaque parking_spot entre le 20 mars 2020 et 20 decembre 2020*/
select label_parking_spot, sum(is_free) from parking_spot  where is_free = 1 or is_free = 0 between "2020-03-20" and "2020-12-20" GROUP BY label_parking_spot;

/*affichage des voitures qui sont sorties par exit_gate "gate of death"*/
SELECT * FROM car LEFT JOIN parc ON car.num_car = parc.num_car RIGHT JOIN exit_gate ON parc.num_exit_gate = exit_gate.num_exit_gate WHERE label_exit_gate="gate of death";

/*