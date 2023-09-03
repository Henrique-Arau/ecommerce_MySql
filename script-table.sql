-- Criação do banco de dados para o cenário de E-commerce

create database ecommerce;

use ecommerce;

-- criar as tabela cliente

show tables;
create table clients (
       idClient int auto_increment primary key,
       Fname varchar(10),
       MInit char(3),
       Lname varchar(20),
       CPF char(11) not null,
       Address varchar(50),
       constraint unique_cpf_client unique (CPF)
);

insert into Clients (Fname, MInit, Lname, CPF, Address) 
        values ('Maria','M','Silva','123456789','rua do Novogama');
        
select * from clients;

-- criar tabela produto

create table product (
       idProduct int auto_increment primary key,
       Pname varchar(10) not null,
       classification_kids bool default false,
       Category enum('Eletrrônico','Vestimenta','Brinquedo','Alimentos','Moveis') not null,
       Avaliação float default 0,
       size varchar(10)
);

insert into product (Pname, classification_kids, category, avaliação, size) values
                   ('Fone',false,'Eletrrônico','4',null);
select * from product;

--
create table payments(
      idClient int,
      idPayment int,
      typePayment enum('Boleto','Cartão','Dois Cartões'),
      limitAvailable float,
      primary key(idClient, idPayment),
      constraint fk_orders_payments foreign key (idPayment) references payments(idClient)
);

-- criar tabela pedido

create table orders(
       idOrder int auto_increment primary key,
       idOrderClient int,
       orderStatus enum('Cancelado','Confirmado','Em Processamento') default 'Em processamento',
       orderDescription varchar(255),
       sendValue float default 10,
       paymentCash bool default false,
       constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
);

insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) value
                   (1,null,'compra via aplicativo',null,1); 
                   
select * from orders;

-- Deletar a Tabela

drop table orders;


-- criar tabela estoque

create table productStorage(
       idProdStorage int auto_increment primary key,
       storageLocation varchar(255),
       quantity int default 0
);

insert into productStorage (storageLocation, quantity) values
                         ('Rio de janeiro',1000);
                         
select * from productStorage;

select c.idClient, Fname, count(*) as Number_of_orders from clients c inner join orders o ON c.idClient = o.idOrderClient
                                           inner join productOrder p on p.idPOorder = o.idOrder
							group by idClient;


-- criar tabela fornecedor

create table supplier(
       idSupplier int auto_increment primary key,
       socialName varchar(255),
       CNPJ char(15) not null,
       contact varchar(11)not null,
       constraint unique_supplier unique (CNPJ)
);


-- criar tabela vendedor

create table seller(
      idSeller int auto_increment primary key,
      SocialName varchar(255) not null,
      AbstName varchar(255),
      CNPJ char(15),
      CPF char(9),
      location varchar(255),
      contact char(11) not null,
      constraint unique_cnpj_seller unique (CNPJ),
      constraint unique_cpf_seller unique (CPF)
);


-- criar tabela produto

create table productSeller(
      idPseller int,
      idProduct int,
      prodQuantity int default 1,
      primary key (idPseller, idProduct),
      constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
      constraint fk_product_product foreign key (idProduct) references product(idProduct)
);

create table productOrder(
      idPOproduct int,
      idPOorder int,
      poQuantity int default 1,
      poStatus enum('Disponivel','Sem estoque') default 'Disponivel',
      primary key (idPOproduct, idPOorder),
      constraint fk_product_seller1 foreign key (idPOproduct) references product(idProduct),
      constraint fk_product_product1 foreign key (idPOorder) references orders(idOrder)
);

insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
                         (1,1,2,null);
                         
select * from productOrder;

create table storageLocation(
      idLproduct int,
      idLstorage int,
      location varchar(255) not null,
      primary key (idLproduct, idLstorage),
      constraint fk_product_seller2 foreign key (idLproduct) references product(idProduct),
      constraint fk_product_product2 foreign key (idLstorage) references productStorage(idProdStorage)
);


desc storageLocation;

create table productSupplier(
          idPsSupplier int,
          idPsProduct int,
          quantity int not null,
          primary key (idPsSupplier, idPsproduct),
          constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
          constraint fk_product_supplier_prodcut foreign key (idPsProduct) references product(idProduct)
);

show databases;

use information_schema;

show tables;

desc referential_constraints;

select * from referential_constraints where constraint_schema = 'ecommerce';






