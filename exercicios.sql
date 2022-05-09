Drop table fornecedor cascade constraints;

CREATE TABLE fornecedor (
n_for		number(5) PRIMARY KEY,
nome		varchar2(15) NOT NULL,
endereco        varchar2(30) NOT NULL,
cpf		varchar2(14) NOT NULL,
estrelas	varchar2(1) NOT NULL,
dt_atualiza	DATE NOT NULL,
vendas          number(11,2) not null ,
comissoes       number(11,2) not null,
valor_desconto  number(11,2) not null,
Valor_Juros     number(11,2) not null, 
lucro           number(11,2) not null);
 
INSERT INTO fornecedor VALUES (
10,'RENATA', 'Rua dos Gusmoes','052.433.545-82','3','10-04-2001',300.00,80.00,10.00, 13, 133);
INSERT INTO fornecedor VALUES (
20,'PAULO','Rua B','556.747.639-68','5','14-03-2001',800.00,90.00,20.00,2,30);
INSERT INTO fornecedor VALUES (
30,'ANA','Rua Diamantina','078.876.420-90','1','10-01-2001',1000.00,95.00,30.00,7,128);

Drop table conta cascade constraints;

CREATE TABLE conta (
n_conta	number(5) PRIMARY KEY,
n_for		  number(5) NOT NULL,
tipo		  varchar(1) NOT NULL,
bloqueada	  varchar2(1) NOT NULL,
saldo		  number(12,2) NOT NULL,
dt_ult_limp	  DATE,
dt_ult_lanc	  DATE NOT NULL,	
CONSTRAINT fornec_fk FOREIGN KEY (n_for) REFERENCES fornecedor(n_for));
 	
INSERT INTO conta VALUES (1,20,'C','N',240000,'01-04-2001','22-04-2001');
INSERT INTO conta VALUES (2,20,'P','N',210000,'01-03-2001','01-04-2001');
INSERT INTO conta VALUES (3,10,'C','N',89000,'01-04-2001','20-04-2001');	
INSERT INTO conta VALUES (4,30,'C','N',11300,'01-04-2001','21-04-2001');
INSERT INTO conta VALUES (5,30,'C','N',2500,'15-03-2001','15-03-2001');

Drop table lanc cascade constraints;

CREATE TABLE lanc (
dt_lanc	DATE NOT NULL,
n_conta	number(5) NOT NULL,
n_lanc	number(5) PRIMARY KEY,
valor		number(12,2) NOT NULL,
historico	varchar2(30),
CONSTRAINT conta_fk FOREIGN KEY (n_conta) REFERENCES conta (n_conta));
 
INSERT INTO lanc VALUES ('01-03-2001',2,106,2000000,'Deposito inicial');
INSERT INTO lanc VALUES ('15-03-2001',5,107,32500,'Cartão de crédito');
INSERT INTO lanc VALUES ('01-04-2001',1,108,-100000,'Saque');
INSERT INTO lanc VALUES ('01-04-2001',2,109,100000,'Deposito');
INSERT INTO lanc VALUES ('20-04-2001',3,110,80000,'Deposito');
INSERT INTO lanc VALUES ('21-04-2001',4,111,-8700,'Conta de telefone');
INSERT INTO lanc VALUES ('21-04-2001',1,112,-5000,'Saque p/ transferência');
INSERT INTO lanc VALUES ('21-04-2001',4,113,5000,'Deposito de transferência');
INSERT INTO lanc VALUES ('22-04-2001',1,114,35000,'deposito');
 
Drop table a_fazer;

CREATE TABLE a_fazer (
feito	varchar2(1),
Data 	DATE NOT NULL ,
Observ 	varchar2(60) NOT NULL);
 
INSERT INTO a_fazer VALUES ('S','14-03-2001','Avisar ANA: cartão de credito = 32500');
INSERT INTO a_fazer VALUES ('S','01-04-2001','Enviar extrato da poupança 2 para RENATA');
INSERT INTO a_fazer VALUES ('S','14-04-2001','Enviar conta de telefone para ANA');

Drop table erro;

CREATE TABLE erro (
data		DATE NOT NULL,
descricao	varchar2(60));
 	
INSERT INTO erro  VALUES (
'01-04-2001','Saque de 12000 de conta 5 não realizado por falta de fundos');

Drop table cliente cascade constraints;

create table cliente (
nome           varchar2(15),
endereco       varchar2(30),
estado         varchar2(02),
cep            varchar2(08),
vendas         number(11,2),
valor_juros    number(11,2),
valor_desconto number(11,2),
codigo         number(05),
primary key (codigo),
data_nasc     date,
parcelas      number(05),
status        varchar2(01),
valor_nota    number(11,2),
emissao_nota  date);

INSERT INTO cliente VALUES(
'MARIA', 'Rua dos trilhos','SP','03040010', 7500.00,00020,null,5,'10-10-58',5,'A',2000.00,'29-09-05');
INSERT INTO cliente VALUES(
'ANTONIO','Rua matilde','SP','07050001',5000.00,00010,null,8,'08-08-60',8,'A',3000.00, '01-10-05');
INSERT INTO cliente VALUES(
'ITAMAR', 'Av. Emilio Ribas','SP','07050001', 6000.00,00030,null,10,'01-01-80',10,'I',1000.00,'01-04-05');

drop table titulo;

CREATE TABLE titulo (
Codigo         number(05) not null,
foreign key (Codigo) references cliente (Codigo),
num_titulo     number(05) not null,
primary key (num_titulo),
valor_titulo   number(11,2) not null,
valor_juros    number(11,2) not null,
valor_desconto number(11,2) not null,
valor_pago     number(11,2) not null,
data_emissão   date,
data_vencto    date,
data_pagto     date);


insert into titulo values (5,1000,15000,1,1,1,sysdate,sysdate,sysdate);
insert into titulo values (8,2000,100,1,1,1,sysdate,sysdate,sysdate);
insert into titulo values (10,3000,1000,1,1,1,sysdate,sysdate,sysdate);


*********************************************************

**exercicio 1**

set serveroutput on
set verify off

DECLARE

nm_titulo number(10):= &numerodotitulo;
v_titulo number(10);

BEGIN
    SELECT VALOR_TITULO INTO v_titulo FROM TITULO WHERE NUM_TITULO = nm_titulo;
    if v_titulo <= 1000 then
        update titulo set valor_pago = v_titulo * 1.15 where num_titulo = nm_titulo;
        dbms_output.put_line('VALOR PAGO CALCULADO = '||v_titulo*1.15);
    else
        update titulo set valor_pago = v_titulo * 1.3 where num_titulo = nm_titulo;
        dbms_output.put_line('VALOR PAGO CALCULADO = '||v_titulo*1.3);
    end if;


END;

SELECT * FROM TITULO


**exercicio 1**

DECLARE

v_cd_cliente number(3):= &codigo;
v_vendas number(10);

BEGIN

SELECT VENDAS INTO V_VENDAS FROM CLIENTE WHERE CODIGO = V_CD_CLIENTE;
    if v_vendas <= 300 then
        update cliente set valor_juros = v_vendas * 0.2 where codigo = v_cd_cliente;
        dbms_output.put_line('VALOR CALCULADO DOS JUROS = '||v_vendas*0.2);
    else
        update cliente set valor_juros = v_vendas * 0.4 where codigo = v_cd_cliente;
        dbms_output.put_line('VALOR CALCULADO DOS JUROS = '||v_vendas*0.4);
    end if;
END;

SELECT * FROM CLIENTE




