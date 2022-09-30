Drop Table Payment;
DRop Table membership;
Drop Table Lesson;
Drop Table GP;
Drop Table Instructor;
Drop Table Lvl;
Drop Table Student;


CREATE TABLE Student (
    IDStudent integer   Primary Key,
    FName varchar2(50) ,
    Surname varchar2(50) ,
    DOB date  
) ;
Insert into Student Values( 1111, 'Olivia','Miller',
To_Date ('10-FEB-2009','DD-MON-YYYY'));
Insert into Student Values( 1121, 'Kelly','Lopez',
To_Date ('15-FEB-2008','DD-MON-YYYY'));
Insert into Student Values( 1113, 'Mary','Jane',
To_Date ('30-JAN-2010','DD-MON-YYYY'));
Insert into Student Values( 1134, 'Kim','Davis',
To_Date ('18-APR-2013','DD-MON-YYYY'));
Insert into Student Values( 1112, 'Rosie','Miller',
To_Date ('23-MAY-2011','DD-MON-YYYY'));
Insert into Student Values( 1117, 'Scott','Wilson',
To_Date ('21-MAR-2012','DD-MON-YYYY'));

CREATE TABLE Lvl (
    IdLevel integer   Primary Key,
    Lname varchar2(50) 
    
) ;
Insert into Lvl Values (1,'First Timer');
Insert into Lvl Values (2,'Beginner');
Insert into Lvl Values (3,'Intermediate');
Insert into Lvl Values (4,'Advance');

CREATE TABLE Instructor (
    IDInstructor integer   Primary Key,
    FName varchar2(50) ,
    Surname varchar2(50)  ,
    hiredate date  ,
    salary number(7,2)  
  
) ;

Insert into Instructor Values ( 2110, 'Jay','SMITH',
TO_DATE('17-MAR-2012', 'DD-MON-YYYY'), 3000);
Insert into Instructor Values ( 2112, 'Jhon','SMITH',
TO_DATE('17-MAR-2012', 'DD-MON-YYYY'), 3000);
Insert into Instructor Values ( 2053, 'Julia','SMITH',
TO_DATE('19-MAY-2010', 'DD-MON-YYYY'), 3200);
Insert into Instructor Values ( 2314, 'Kelvin','James',
TO_DATE('10-JAN-2009', 'DD-MON-YYYY'), 3520);
Insert into Instructor Values ( 2352, 'Tom','Cornel',
TO_DATE('10-JAN-2015', 'DD-MON-YYYY'), 2900);

CREATE TABLE GP (
    GpNumber integer   Primary key,
    Gpname varchar2(50) ,
    Gp_IDInstructor integer,
    GP_IDLevel integer,
    FOREIGN Key ( Gp_IDInstructor) References Instructor (IDInstructor),
    FOREIGN Key ( Gp_IDLevel) References Lvl (IDLevel)
    );
    
Insert into Gp values ( 10, 'A',2112,2);
Insert into Gp values ( 11, 'B',2053,3);
Insert into Gp values ( 12, 'C',2314,4);
Insert into Gp values ( 13, 'D', 2352,3);
Insert into Gp values ( 14, 'E', 2112,1);
Insert into Gp values ( 15, 'F', 2053,2);
Insert into Gp values ( 16, 'G', 2053,1);

CREATE TABLE Lesson (
    IDLesson integer  PRIMARY KEY,
    LDate date ,
    L_IDGP integer,
    FOREIGN Key ( L_IDGP) References GP ( GpNumber)
 
) ;
insert into Lesson Values(123,To_Date('05-JAN-2020','DD-MON-YYYY') ,10);
insert into Lesson Values(124,To_Date('06-JAN-2020 ','DD-MON-YYYY'),11);
insert into Lesson Values(125,To_Date('06-OCT-2020 ','DD-MON-YYYY'),12);
insert into Lesson Values(126,To_Date('10-DEC-2020 ','DD-MON-YYYY'),13);
insert into Lesson Values(127,To_Date('10-DEC-2020 ','DD-MON-YYYY'),14);
insert into Lesson Values(128,To_Date('10-DEC-2020 ','DD-MON-YYYY'),15);


CREATE TABLE membership (
   Idmembership integer PRIMARY KEY ,
   StartDate Date,
   EndDate Date,
   M_IDStudent integer ,
   M_IDGP integer,
   FOREIGN Key ( M_IDStudent) References Student ( IDStudent),
   FOREIGN Key ( M_IDGP) References GP( GpNumber)
   
) ;
insert into membership values (105,To_Date('05-JAN-2020','DD-MON-YYYY'), 
To_Date('06-FEB-2020','DD-MON-YYYY'),1111,15);
insert into membership values (106,To_Date('06-DEC-2020','DD-MON-YYYY'), 
To_Date('06-JAN-2020','DD-MON-YYYY'),1121, 13);
insert into membership values (107,To_Date('05-OCT-2020','DD-MON-YYYY'), 
To_Date('06-NOV-2020','DD-MON-YYYY'),1113,14);
insert into membership values (108,To_Date('05-NOV-2020','DD-MON-YYYY'), 
To_Date('06-DEC-2020','DD-MON-YYYY'),1134,11);
insert into membership values (109,To_Date('05-NOV-2020','DD-MON-YYYY'), 
To_Date('06-DEC-2020','DD-MON-YYYY'),1112,12);
insert into membership values (110,To_Date('05-OCT-2020','DD-MON-YYYY'), 
To_Date('06-NOV-2020','DD-MON-YYYY'),1117,10);


CREATE TABLE Payment (
    IDPayment integer  Primary KEY,
    PaymentMethod varchar2(50) ,
    Pdate date ,
    amount number(7,2),
    P_IDmembership integer,
    FOREIGN Key (P_IDmembership ) References membership (IDmembership)   
) ;
Insert into Payment values(1213, 'card',To_Date('21-DEC-2020','DD-MON-YYYY'),100,105);
Insert into Payment values(1210, 'cash',To_Date('01-NOV-2020','DD-MON-YYYY'),120,106);
Insert into Payment values(1215, 'Bank Transfer',To_Date('25-SEP-2020','DD-MON-YYYY'),90,107);
Insert into Payment values(1214, 'card',To_Date('13-OCT-2020','DD-MON-YYYY'),120,108);
Insert into Payment values(1212, 'cash',To_Date('22-OCT-2020','DD-MON-YYYY'),150,109);
Insert into Payment values(1218, 'BLIK',To_Date('21-SEP-2020','DD-MON-YYYY'),100,110);
commit;

Select *
From Student;

Select *
From Instructor;

Select *
From Lvl;

select *
From membership;

select *
From Gp;

select *
From Lesson;

select *
From Payment;
drop table c1_lnstructor;
CREATE TABLE c1_lnstructor as 
select * from Instructor;


SET SERVEROUTPUT ON;

--1.Create a procedure which change group levels from giving by the first parameter to job giving by the second parameter.
drop table cGP;
Create table cGp as
Select * from Gp;

CREATE OR REPLACE PROCEDURE CHANGE_LVL (level1 integer,level2 integer)
as noLevel1 Exception;
countLevel1 number;
CURSOR GpLevel is select GPNUMBER from CGP where GP_IDLEVEL= level1;
GpNum NUMBER;
BEGIN
SELECT COUNT(GPNUMBER) INTO countLevel1
FROM CGP
WHERE GP_IDLEVEL= level1;
IF countLevel1=0 THEN RAISE noLevel1;
ELSE OPEN GpLevel;
LOOP
FETCH GpLevel into GpNum;
exit when GpLevel%notfound;
UPDATE CGP 
SET GP_IDLEVEL=level2
where GPNUMBER=GpNum;
END LOOP;
END IF;
CLOSE GpLevel;
EXCEPTION WHEN noLevel1 THEN
DBMS_OUTPUT.PUT_LINE('there is no group in level '|| level1);
END;


EXEC CHANGE_LVL (2,3);
SELECT * FROM GP;
SELECT * FROM CGP;

--2.Create a procedure which change the salaray of instructor who started working in 2012 for 5% bigger.
Drop table c_instructor;
CREATE TABLE c_Instructor as 
select * from Instructor;

CREATE OR REPLACE PROCEDURE CHANGE_SAL 
AS noInstructor EXCEPTION;
countInst number;
CURSOR  inst is
SELECT IDINSTRUCTOR 
FROM C_Instructor 
WHERE HIREDATE BETWEEN '31-12-2011' AND '01-01-2013';
idI number;
BEGIN
SELECT COUNT(IDINSTRUCTOR) INTO countInst
FROM c_Instructor
WHERE HIREDATE BETWEEN '31-12-2011' AND '01-01-2013';
IF countInst=0 THEN RAISE noInstructor;
ELSE OPEN inst ;
LOOP
FETCH inst INTO idI;
EXIT WHEN inst%notfound;
UPDATE c_Instructor
SET SALARY = SALARY*1.05
WHERE HIREDATE BETWEEN '31-12-2011' AND '01-01-2013';
END LOOP;
END IF;
CLOSE INST;
EXCEPTION WHEN noInstructor  THEN
DBMS_OUTPUT.PUT_LINE('THERE IS NO ONE WHO STARTED WORKING IN 2012');
END;

EXEC CHANGE_SAL ;
SELECT * FROM INSTRUCTOR;
SELECT * FROM C_INSTRUCTOR;


--3. Create a procedure which change the date of the lesson in 10-12-2020 to 5-01-2021.
DROP TABLE C_LESSON ;
CREATE TABLE C_LESSON AS
SELECT * FROM LESSON;


CREATE OR REPLACE PROCEDURE CHANGE_DATE 
AS noLesson EXCEPTION;
CURSOR LES IS SELECT IDLESSON FROM C_LESSON WHERE LDATE='10-12-2020';
countLes NUMBER;
idL number;
BEGIN 
SELECT COUNT(IDLESSON) INTO countLes
FROM C_LESSON WHERE LDATE='10-12-2020';
IF countLes=0 THEN RAISE noLesson;
ELSE OPEN LES;
LOOP
FETCH LES INTO idL;
EXIT WHEN LES%notfound;
UPDATE C_LESSON
SET LDATE= '5-01-2021'
WHERE LDATE='10-12-2020';
END LOOP;
END IF;
CLOSE LES;
EXCEPTION WHEN  noLesson THEN
DBMS_OUTPUT.PUT_LINE('THERE IS NO LESSON AT 10-12-2020');
END;

EXEC CHANGE_DATE ;
SELECT * FROM LESSON;
SELECT * FROM C_LESSON;

SET SERVEROUTPUT ON;
--TRIGGER
--1.created triggers on lessons to show how many GROUPS HAVE lessons on 10.12.2020 after insert or update or delete a row.
DROP TABLE C1_LESSON ;
CREATE TABLE C1_LESSON AS
SELECT * FROM LESSON;

create OR REPLACE TRIGGER TR_LESSON
after insert or update OR DELETE
on C1_LESSON
declare
Cursor S is select L_IDGP from C1_LESSON where LDATE='10-12-2020' ;
L_id INT;
NUM_L INT;
NOLESSON EXCEPTION;
BEGIN
select DISTINCT COUNT(L_IDGP) into NUM_L from C1_LESSON where LDATE='10-12-2020' ;
IF  NUM_L=0 THEN RAISE NOLESSON ;
ELSE OPEN S;
LOOP
FETCH S INTO L_id;
 EXIT WHEN S%NOTFOUND;
 DBMS_OUTPUT.PUT_LINE( 'Group number ' || L_id || ' has lesson on 2020-12-10' );
 END LOOP;
 DBMS_OUTPUT.PUT_LINE(NUM_L ||' GROUPS HAVE LESSONS ON 2020-12-10 ');
 END IF;
 CLOSE S;
 EXCEPTION WHEN NOLESSON  THEN 
  DBMS_OUTPUT.PUT_LINE('THERE IS NO LESSON ' );
END;         

insert into C1_Lesson Values(130,To_Date('10-DEC-2020 ','DD-MON-YYYY'),16);
UPDATE C1_Lesson SET LDATE='11-12-2020' WHERE IDLESSON=128;
DELETE FROM C1_Lesson WHERE IDLESSON=130;

SET SERVEROUTPUT ON;
--2.create the trigger to check the updated salary is greater or lower than the old one.if it's lower, it prevent updating.
Drop table c1_instructor;
CREATE TABLE c1_Instructor as 
select * from Instructor;

CREATE OR REPLACE TRIGGER TR_SAL 
after update ON c1_instructor
FOR EACH ROW
declare 
cursor SAL IS SELECT IDINSTRUCTOR FROM c1_lnstructor WHERE :new.salary >: old.salary;
iDS INT;
COUNT_ID int;
LOW_SAL EXCEPTION;
BEGIN
if :new.salary <: old.salary THEN RAISE LOW_SAL;
ELSE OPEN SAL;
LOOP
FETCH SAL INTO IDS;
EXIT WHEN SAL%NOTFOUND;
 update C1_lnstructor set salary=:new.salary;
END LOOP;
END IF;
CLOSE SAL;
EXCEPTION WHEN LOW_SAL THEN
 raise_application_error (-20102, 'You are not allowed to update salary');
END;

update c1_instructor set salary= 2700 where IDInstructor = 2352;
update c1_instructor set salary= 3000 where IDInstructor = 2352;
select * from Instructor;
select * from C1_Instructor;

SET SERVEROUTPUT ON;
--3.create triggers  which show the the students who born after 2010  after inserting or updating on students.
drop table c_student;
Create table c_student as
Select * from Student;

DROP trigger oldestStudent;
create or replace trigger oldestStudent
after insert or update
on c_student
declare
Cursor DOB is select IDSTUDENT from c_student where DOB > '31-12-2010';
S_id INT;
NUM_S INT;
NO_student EXCEPTION;
BEGIN
select COUNT(IDSTUDENT) into NUM_S from c_student where DOB > '31-12-2010';
IF  NUM_S=0 THEN RAISE NO_student;
ELSE OPEN DOB;
LOOP
FETCH DOB INTO S_id;
 EXIT WHEN DOB%NOTFOUND;
 DBMS_OUTPUT.PUT_LINE( S_id || ' WAS BORN AFTER 2010' );
 END LOOP;
 END IF;
 CLOSE DOB;
 EXCEPTION WHEN  NO_student THEN 
  DBMS_OUTPUT.PUT_LINE('THERE IS NO STUDENT' );
END;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
 
Insert into C_Student Values( 1118, 'TAYLOR','Miller',
To_Date ('10-FEB-2007','DD-MON-YYYY'));
Insert into C_Student Values( 2000, 'rose','Miller',
To_Date ('10-FEB-20011','DD-MON-YYYY'));
UPDATE C_Student SET DOB= '10-FEB-2005' WHERE IDSTUDENT= 1112;
Select * from C_Student;

SET SERVEROUTPUT ON;
--4.created triggers on lvl to prevent deleting or inserting new data if there is already 4 level. 
drop table c_LVL;
Create table c_LVL as
Select * from LVL;

CREATE OR REPLACE TRIGGER TR_LVL
BEFORE INSERT OR DELETE
ON C_LVL
DECLARE 
ROW_COUNT INT;
E_LVL EXCEPTION;
CURSOR LVL IS SELECT IDLEVEL FROM C_LVL;
IDL NUMBER;
BEGIN
SELECT COUNT(IDLEVEL) INTO ROW_COUNT FROM C_LVL;
IF ROW_COUNT= 4 THEN RAISE E_LVL;
ELSE OPEN LVL;
LOOP 
FETCH LVL INTO IDL;
EXIT WHEN LVL%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('YOU CAN INSERT OR DELETE A ROW');
END LOOP;
END IF;
CLOSE LVL;
EXCEPTION WHEN E_LVL THEN 
raise_application_error (-20102, 'You are not allowed to change or delete the table Lvl');
END;

insert into C_lvl(IDlevel) values ('6');
SELECT * FROM C_LVL;



