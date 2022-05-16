rm87553 catarina
rm85846 joao pedro marques

set serveroutput on
set verify off

DECLARE
v_ano number(4);
BEGIN
for v_ano in 2000..2100 loop
if (mod(v_ano, 4) = 0) and (mod(v_ano, 100)!= 0) or (mod(v_ano, 4100) = 0) then
    dbms_output.put_line(v_ano);
end if;
end loop;
END;


set serveroutput on
set verify off

DECLARE
v_veiculo number(10,2):= &veiculo;
v_final number(10,2);
f_pagamento number(3):= &formapagamento;
-- 1 = A vista

BEGIN
    if f_pagamento = 1 then
        v_final := v_veiculo - (v_veiculo * 0.05);
        dbms_output.put_line('o valor do veiculo é de: '||v_veiculo|| ' ,foi pago a vista '|| 
        ',com 5% de desconto' || ' e o valor final de: '|| v_final);
    elsif f_pagamento = 3 or f_pagamento < 11 then
        dbms_output.put_line('o valor do veiculo é de: '||v_veiculo|| ' ,foi pago em até 10x '|| 
        'sem desconto' || ' e o valor final de: '|| v_veiculo);
    elsif f_pagamento >=11 or f_pagamento = 20 then
        v_final := v_veiculo * 1.15;
        dbms_output.put_line('o valor do veiculo é de: '||v_veiculo|| ' ,foi pago em até 20x '||
        'com acréscimo no valor de 15%' || ' e o valor final de: '|| v_final);   
    else
        dbms_output.put_line('erro');
    end if;
END;



CREATE TABLE LUCRO (
ANO NUMBER(4),
VALOR NUMBER(9,2));

INSERT INTO LUCRO VALUES (2007,1200000);
INSERT INTO LUCRO VALUES (2008,1500000);
INSERT INTO LUCRO VALUES (2009,1400000);

CREATE TABLE SALARIO (
MATRICULA NUMBER(4),
VALOR NUMBER(7,2));

INSERT INTO SALARIO VALUES (1001,2500);
INSERT INTO SALARIO VALUES (1002,3200);

declare
    val_ano NUMBER(4) := &ano ;
    val_matricula NUMBER(4):= &matricula ;
    val_valor NUMBER(9,2);
    val_valSalario NUMBER(7,2);
    bonus number(10,2);
begin   
    select valor into val_valor from lucro where ano = val_ano;
    select valor into val_valSalario from salario where matricula = val_matricula;
    bonus := val_valor * 0.01 + val_valSalario * 0.05;
    dbms_output.put_line('O funcionario de matricula: '||val_matricula||'ganhou de bonus: '||bonus);
end;

select * from LUCRO
select * from salario

drop table lucro
drop table salario
