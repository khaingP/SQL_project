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


select distinct S.salary
from instructor S
where 2 =( select count(IDinstructor)
from instructor
where salary=S.salary)

select salary
from instructor
group by salary
having count (IDinstructor)=5;


--1.Find all firstname and lastname in one column as  'students' who is in Group A and also students who is in intermediate level.
--The name should be in alphabetic order
Select Fname ||' '|| surname as student
From student,membership
where student.IDStudent= membership.M_IDStudent and m_IDGp = (
select Gpnumber
from GP
where Gpname= 'A' )
union
Select Fname ||' '|| surname as student
From student,membership
where student.IDStudent= membership.M_IDStudent and m_IDGp in (
select Gpnumber
From GP,Lvl
where  Lvl.IDlevel=GP.GP_IDlevel and Lname Like 'Intermediate')
order by 1 ASC ; 

--2.Is there any group which has no student? Show the name and number of that groups.
select GPnumber, GPname
From GP,membership 
where membership.m_IDGP(+)= GP.GPnumber
Having count(m_IDstudent)<1
Group by GPnumber, GPname;

select GPnumber
from Gp
where GPnumber not in ( select M_IDGP
from membership)



--3. Find the name and ID of the youngest student who is in Instructor Julia's Group?
Select Fname, IDstudent
From student
Where DOB in (Select max(DOB)
from student s , membership m
where s.Idstudent=m. M_IDStudent and M_IDGp in (
select Gpnumber
From GP G,Instructor I
Where G.Gp_IDInstructor = I.IDInstructor and Fname Like 'Julia'))

--4.Show   names of instructors in one  column who got yearly  salary more than Tom's but noone  who teach level 3.
Select Fname ||' '|| surname as FullName
From Instructor
Where salary*12 > ( select salary*12
from Instructor
Where Fname like 'Tom')
minus
Select Fname ||' '|| surname as FullName
From Instructor i,GP g
Where i.IDInstructor= g.Gp_IDInstructor and g.Gp_IDlevel = 3;

--5.Which Group has  lesson not the same day as Group 13.
Select A.L_IDGP
from lesson A
where not exists ( select IDLesson
From Lesson
where  L_IDGp= 13 and LDate=A.Ldate);

--6 is there any student who is the firstmember of lv2.Show the name and Date of birth of that student.
Select IDStudent,Fname, Surname, DOB
from student, membership
where student.IDStudent= membership.M_IDStudent and startdate in (select min(startdate)
from membership
where M_IDGP in(
select GPnumber
From Gp
where GP_IdLevel=2));

/*7. Among instructors who has firstname starts with J' or ends with m and one who
is in more than 1 group,  who employed as the last one?  */
Select Fname
From Instructor 
Where  hiredate > any (
select hiredate
from Instructor
Where Fname like 'J%' or Fname like '%m')
intersect
Select Fname
From Instructor I,GP G
where I.IDInstructor=G.Gp_IDinstructor
Having count(GP_IDInstructor)>1
Group by Fname;


--8 which 2 payment methods got the highest amount of money.
select  distinct P.paymentmethod
from payment P
Where 2>( select  count(paymentmethod)
from payment
where amount > P. amount
)


--9 how much money got from each payment method in 2020.Show the highest amount fitst.
select paymentmethod, sum(amount)
from payment
where Pdate between '31-DEC-2019' and '1-Jan-2021'
having sum( amount) in (select sum(amount)
from payment
Group by paymentmethod)
group by paymentmethod
Order by sum(amount) DESC;


--10 Find the instructor who only teach 1 level and name contains at least 3 character.
Select Fname 
from instructor I,Gp A
where I.IDinstructor = A.GP_IDinstructor and Fname like '%___%' 
Having count(A.GP_IDLevel) =1
Group by Fname;

select sum(amount), M_IDGP
from payment,membership M
where payment.P_Idmembership= M.Idmembership 
Group by M_IDGP;


set serveroutput on;
--1.create triggers on payment which prevents updating the amount if it is lower than 90;the error message need to be shown.;
Create or replace trigger Tr_payment
Before update on Payment
for each row
Declare
 n_amount payment.amount%type;
 Begin 
  n_amount:=:new.amount;
 if n_amount <= 90 then
   :new.amount :=: old.amount;  
   Raise_application_error(-20123,'The amount cannot be lower than 90');

   end if;
End;

update payment
set amount =80
where IDPayment = 1218;

select *
from payment;

--2.create triggers  which show the DOB of oldest student after inserting or deleting or updating on students.
Create or replace trigger tr_student
After insert or update or delete
on student
Declare 
  min_DOB student.DOB%type;
begin
  select min(DOB) into  min_DOB from student;
  dbms_output.put_line( 'Oldest student was born in '|| min_DOB);
 END;
 
 update student
set DOB =  '21-Jan-2002'
where IDstudent=1111;

select *
from student;

--3.Create triggers to create the ID of the new instructor.
create or replace trigger tr_instructor
Before insert
on Instructor
for each row
Begin 
   Select NVL(max(IDinstructor)+1,1) into :new.IDinstructor From instructor;
    dbms_output.put_line('ID of new instructor is '|| :new.IDinstructor);
END;
Insert into Instructor(FName) values ('Jennie');
  select *
  from instructor;
  
--4.create triggers to show the total income by each paymethod in 2020 after updating or deleting or inserting new data on payment.
create or replace trigger Total_income
after insert or update or delete
on payment
declare
  total_income integer;
  by_card integer;
  by_cash integer;
  by_bank  integer;
  by_Blik  integer ;
begin
   Select sum(amount) into total_income from payment where Pdate between '31-Dec-2019' and '1-Jan-2021';
   Select sum(amount) into by_card from payment where Pdate between '31-Dec-2019' and '1-Jan-2021'and Paymentmethod='card';
   Select sum(amount) into by_cash from payment where Pdate between '31-Dec-2019' and '1-Jan-2021'and Paymentmethod='cash';
   Select sum(amount) into by_bank from payment where Pdate between '31-Dec-2019' and  '1-Jan-2021'and Paymentmethod='Bank Transfer';
   Select sum(amount) into by_Blik from payment where Pdate between '31-Dec-2019' and  '1-Jan-2021'and Paymentmethod='BLIK';
   dbms_output.put_line('-----Total income for 2020-----');
   dbms_output.put_line('TOTAL  ---------'|| total_income);
   dbms_output.put_line('card   ---------'|| by_card);
   dbms_output.put_line('cash   ---------'|| by_cash);
   dbms_output.put_line('Bank Transfer---'|| by_bank);
   dbms_output.put_line('Blik    --------'|| by_Blik);
end;


Insert into Payment values(1201, 'card',To_Date('21-OCT-2020','DD-MON-YYYY'),130,105);
update payment set amount=100 where IDpayment=1201;
Delete from payment where IDpayment=1201;
select *
from payment;

--5.created triggers on lvl to prevent deleting or inserting new data if there is already 4 level. 
Create or replace trigger tr_lvl1
before insert  or delete
on lvl
declare
  row_count integer;
Begin
   Select distinct count(IDLevel) into row_count from Lvl;
   while row_count = 4 loop
  raise_application_error (-20102, 'You are not allowed to change or delete the table Lvl');
  end loop;
END;
insert into lvl(IDlevel) values ('6');
Select*
From lvl;

--6.create the trigger to check the updated salary is greater or lower than the old one.
create or replace trigger new_salary
before update
on instructor
for each row
 begin
  if :new.salary <=: old.salary then
  :new.salary:=:old.salary;
   dbms_output.put_line('new salary should be higher than the old one');
   end if;
 end;

update instructor set salary= 2800 where IDInstructor = 2352;

select *
from instructor;

create or replace trigger tr3
before insert
on Instructor
for each row
Begin
  if :new.hiredate > sysdate then
      :new.hiredate := sysdate;
     end if;
End;




















































































