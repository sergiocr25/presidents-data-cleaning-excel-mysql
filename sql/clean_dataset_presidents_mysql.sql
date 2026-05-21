select * from raw_dataset_presidents;

select president, party, vice, salary,
count(*) as duplicados
from data_cleaning_excel_to_mysql_working
group by president, party, vice, salary 
having count(*) > 1;

-- Observo duplicados

/*
	Creo una nueva tabla sin duplicados, llamada clean.
*/

CREATE TABLE data_cleaning_excel_to_mysql_clean AS
WITH cte_duplicados AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY 
                president,
                party,
                vice,
                salary
            ORDER BY `S.No.`
        ) AS fila
    FROM data_cleaning_excel_to_mysql_working
)
SELECT *
FROM cte_duplicados
WHERE fila = 1;

-- Compruebo que no haya duplicados

select * from data_cleaning_excel_to_mysql_clean
order by `S.NO.` asc;

-- Elimino una tabla innecesaria

alter table data_cleaning_excel_to_mysql_clean
drop column MyUnknownColumn;

-- Arreglo la columna president

select president, upper(trim(president)) 
from data_cleaning_excel_to_mysql_clean
order by `S.NO.` asc;

update data_cleaning_excel_to_mysql_clean
set president = upper(trim(president));

-- Elimino una tabla innecesaria

alter table data_cleaning_excel_to_mysql_clean
drop column prior;

select * from data_cleaning_excel_to_mysql_clean
order by `S.NO.` asc;

-- Arreglo la columna vice

select vice, upper(trim(vice)) 
from data_cleaning_excel_to_mysql_clean
order by `S.NO.` asc;

update data_cleaning_excel_to_mysql_clean
set vice = upper(trim(vice));

-- Sigo observando

select * from data_cleaning_excel_to_mysql_clean
order by `S.NO.` asc;

select distinct party 
from  data_cleaning_excel_to_mysql_clean
order by party asc;

-- Tengo que arreglar la columna party

update data_cleaning_excel_to_mysql_clean
set party = 'Democratic'
where party = 'Demorcatic';

update data_cleaning_excel_to_mysql_clean
set party = 'Republican'
where party = 'Republicans';

update data_cleaning_excel_to_mysql_clean
set party = 'Whig'
where party = 'Whig   April 4, 1841  â€“  September 13, 1841';
/*
	El democratic- Republican no sé bien cómo hacerlo,
    no sé si es un bipartidismo o un error.
*/

select * from data_cleaning_excel_to_mysql_clean
order by `S.NO.` asc;

/*
	Tengo que arreglar la columna salary, 
    actualmente es type text y encima con un
    caracter especial.
*/ 

alter table data_cleaning_excel_to_mysql_clean
add column salary_clean int;

update data_cleaning_excel_to_mysql_clean
set salary_clean = replace(replace(replace(salary, '$', ''), '.', ''), ',00', '') + 0;

select salary, salary_clean 
from data_cleaning_excel_to_mysql_clean;

alter table data_cleaning_excel_to_mysql_clean
drop column salary;

alter table data_cleaning_excel_to_mysql_clean
rename column salary_clean to salary;

select * from data_cleaning_excel_to_mysql_clean
order by `S.NO.` asc;

/*
	Ya he arreglado la columna salary, lo primero creo una columna
    salary_clean, le asigno los valores de salary pero aquí viene el truco, 
    reemplazo el $, el . y el ,00 por '' que es un valor vacío, es decir,
    no es nada, y por último el truco es sumarle 0 para convertirlo en type int.
*/

/*
	Voy a eliminar la columna fila que me acabo de dar cuenta que la sigo teniendo,
    es la columna que creé para identificar duplicados
*/

alter table data_cleaning_excel_to_mysql_clean
drop column fila;

select * from data_cleaning_excel_to_mysql_clean
order by `S.NO.` asc;

/*
	Acabo de darme cuenta que en vice tenemos espacios dobles
    entre nombre y apellidos en algunos casos, voy a solucionarlo
*/

select vice from data_cleaning_excel_to_mysql_clean
order by `S.NO.` asc;

select vice, upper(trim(regexp_replace(vice, '[[:space:]]+', ' '))) 
as vice_fixed
from data_cleaning_excel_to_mysql_clean;

update data_cleaning_excel_to_mysql_clean
set vice = upper(trim(regexp_replace(vice, '[[:space:]]+', ' ')));

/*
	REGEXP_REPLACE(..., '[[:space:]]+', ' ')
	convierte varios espacios seguidos en uno solo
*/

select * from data_cleaning_excel_to_mysql_clean
order by `S.NO.` asc;

/*
	Por último faltan las fechas, son type text 
    y además tienen diferente formato,
    voy a resolverlo como hice con salary.
*/

select `date updated` 
from data_cleaning_excel_to_mysql_clean
order by `date updated` desc;

alter table data_cleaning_excel_to_mysql_clean
add column `date updated fixed` date;

--

update data_cleaning_excel_to_mysql_clean
set `date updated fixed` =
    case
        when `date updated` like '%/%/%'
            then STR_TO_DATE(`date updated`, '%d/%m/%Y')
        when `date updated` like '%julio%'
            then STR_TO_DATE('14/07/2021', '%d/%m/%Y')
    end;

--

/*
	esta función detecta la fecha en type text con
    el formato '%/%/%' y le aplica un string to date
    cogiendo date updated para setearlo a la nueva,
    luego detectamos julio ya que ambas son de julio, 
    intenté con una versión genérica pero sql no lo detectaba
    y lo mismo, le aplica el string to date
*/

select `date updated`, `date updated fixed`
from data_cleaning_excel_to_mysql_clean
order by `date updated` desc;

alter table data_cleaning_excel_to_mysql_clean
drop column `date updated`;

alter table data_cleaning_excel_to_mysql_clean
rename column `date updated fixed` to `date updated`;

select * from data_cleaning_excel_to_mysql_clean
order by `S.NO.` asc;

-- mismo proceso con date created

select `date created` 
from data_cleaning_excel_to_mysql_clean
order by `date created` desc;

alter table data_cleaning_excel_to_mysql_clean
add column `date created fixed` date;

update data_cleaning_excel_to_mysql_clean
set `date created fixed` =
    case
        when `date created` like '%/%/%'
            then STR_TO_DATE(`date created`, '%d/%m/%Y')
        when `date created` like '%febrero%'
            then STR_TO_DATE('01/02/2020', '%d/%m/%Y')
    end;

select `date created`, `date created fixed`
from data_cleaning_excel_to_mysql_clean
order by `date created` desc;

alter table data_cleaning_excel_to_mysql_clean
drop column `date created`;

alter table data_cleaning_excel_to_mysql_clean
rename column `date created fixed` to `date created`;

select * from data_cleaning_excel_to_mysql_clean
order by `S.NO.` asc;

/*
	He seguido el mismo proceso que en date updated para
    arreglar date created, crear una nueva columna, setear bien los valores,
    compruebo que se ha arreglado, elimino la columna que está mal, renombro 
    la columna buena, compruebo y fin
*/

/*
	Ya solo faltaría exportar la tabla como wizard a un dataset en excel
    y comprobar que todo esté igual, tal vez haya que separar las columnas en excel
    al princpipio con lo de commas.
    Datos --> Texto en columnas
    Delimitados
    Coma
    Finalizar
    Pero ojo solo por si acaso.
*/
