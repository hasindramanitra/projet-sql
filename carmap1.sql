/*creation de la base de données carmap et ses tables;*/

create table parking_floor(
    num_parking_floor int(11) primary key auto_increment,
    label_parking_floor varchar(255)
);

create parking_spot(
    num_parking_spot int(11) primary key auto_increment,
    hourly_price_parking_spot float ,
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