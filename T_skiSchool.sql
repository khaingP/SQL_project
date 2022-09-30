Drop Table A_Payment;
DRop Table A_membership;
Drop Table A_Lesson;
Drop Table A_GP;
Drop Table A_Instructor;
Drop Table A_Lvl;
Drop Table A_Student;


CREATE TABLE A_Student (
    IDStudent integer   Primary Key,
    FName varchar(50) ,
    Surname varchar(50) ,
    DOB date
) ;
Insert into A_Student Values( 1111, 'Olivia','Miller','10-FEB-2009');
Insert into A_Student Values( 1121, 'Kelly','Lopez','15-FEB-2008');
Insert into A_Student Values( 1113, 'Mary','Jane','30-JAN-2010');
Insert into A_Student Values( 1134, 'Kim','Davis','18-APR-2013');
Insert into A_Student Values( 1112, 'Rosie','Miller','23-MAY-2011');
Insert into A_Student Values( 1117, 'Scott','Wilson','21-MAR-2012');

CREATE TABLE A_Lvl (
    IdLevel integer   Primary Key,
    Lname varchar(50)

) ;
Insert into A_Lvl Values (1,'First Timer');
Insert into A_Lvl Values (2,'Beginner');
Insert into A_Lvl Values (3,'Intermediate');
Insert into A_Lvl Values (4,'Advance');

CREATE TABLE A_Instructor (
    IDInstructor integer   Primary Key,
    FName varchar(50) ,
    Surname varchar(50)  ,
    hiredate date  ,
    salary numeric(7,2)

) ;
Insert into A_Instructor Values ( 2114, 'Jay','SMITH','17-MAR-2012',  3100);
Insert into A_Instructor Values ( 2110, 'Jay','SMITH','17-MAR-2012',  3000);
Insert into A_Instructor Values ( 2112, 'Jhon','SMITH','17-MAR-2012', 3000);
Insert into A_Instructor Values ( 2053, 'Julia','SMITH','19-MAY-2010', 3200);
Insert into A_Instructor Values ( 2314, 'Kelvin','James','10-JAN-2009',  3520);
Insert into A_Instructor Values ( 2352, 'Tom','Cornel','10-JAN-2015',  2900);

CREATE TABLE A_GP (
    GpNumber integer   Primary key,
    Gpname varchar(50) ,
    Gp_IDInstructor integer,
    GP_IDLevel integer,
    FOREIGN Key ( Gp_IDInstructor) References A_Instructor (IDInstructor),
    FOREIGN Key ( Gp_IDLevel) References A_Lvl (IDLevel)
    );

Insert into A_GP values ( 10, 'A',2112,2);
Insert into A_GP values ( 11, 'B',2053,3);
Insert into A_GP values ( 12, 'C',2314,4);
Insert into A_GP values ( 13, 'D', 2352,3);
Insert into A_GP values ( 14, 'E', 2112,1);
Insert into A_GP values ( 15, 'F', 2053,2);
Insert into A_GP values ( 16, 'G', 2053,1);

CREATE TABLE A_Lesson (
    IDLesson integer  PRIMARY KEY,
    LDate date ,
    L_IDGP integer,
    FOREIGN Key ( L_IDGP) References A_GP ( GpNumber)

) ;
insert into A_Lesson Values(123,'05-JAN-2020',10);
insert into A_Lesson Values(124,'06-JAN-2020 ',11);
insert into A_Lesson Values(125,'06-OCT-2020 ',12);
insert into A_Lesson Values(126,'10-DEC-2020 ',13);
insert into A_Lesson Values(127,'10-DEC-2020 ',14);
insert into A_Lesson Values(128,'10-DEC-2020 ',15);


CREATE TABLE A_membership (
   Idmembership integer PRIMARY KEY ,
   StartDate Date,
   EndDate Date,
   M_IDStudent integer ,
   M_IDGP integer,
   FOREIGN Key ( M_IDStudent) References A_Student ( IDStudent),
   FOREIGN Key ( M_IDGP) References A_GP( GpNumber)

) ;
insert into A_membership values (105,'05-JAN-2020','06-FEB-2020',1111,15);
insert into A_membership values (106,'06-DEC-2020','06-JAN-2020',1121, 13);
insert into A_membership values (107,'05-OCT-2020','06-NOV-2020',1113,14);
insert into A_membership values (108,'05-NOV-2020','06-DEC-2020',1134,11);
insert into A_membership values (109,'05-NOV-2020','06-DEC-2020',1112,12);
insert into A_membership values (110,'05-OCT-2020','06-NOV-2020',1117,10);


CREATE TABLE A_Payment (
    IDPayment integer  Primary KEY,
    PaymentMethod varchar(50) ,
    Pdate date ,
    amount numeric(7,2),
    P_IDmembership integer,
    FOREIGN Key (P_IDmembership ) References A_membership (IDmembership)
) ;
Insert into A_Payment values(1213, 'card','21-DEC-2020',100,105);
Insert into A_Payment values(1210, 'cash','01-NOV-2020',120,106);
Insert into A_Payment values(1215, 'Bank Transfer','25-SEP-2020',90,107);
Insert into A_Payment values(1214, 'card','13-OCT-2020',120,108);
Insert into A_Payment values(1212, 'cash','22-OCT-2020',150,109);
Insert into A_Payment values(1218, 'BLIK','21-SEP-2020',100,110);

--PROCEDURES
--1.Create a procedure which change group levels from giving by the first parameter to job giving by the second parameter.
drop table cGP;
Create table cGp (
    GpNumber integer   Primary key,
    Gpname varchar(50) ,
    Gp_IDInstructor integer,
    GP_IDLevel integer,
    FOREIGN Key ( Gp_IDInstructor) References A_Instructor (IDInstructor),
    FOREIGN Key ( Gp_IDLevel) References A_Lvl (IDLevel)
    );
insert into cGp
Select * from A_Gp;

drop PROCEDURE CHANGE_LVL ;
CREATE  PROCEDURE CHANGE_LVL @level1 integer,@level2 integer
as
Declare GpLevel CURSOR for
select GPNUMBER from cGP where GP_IDLEVEL= @level1;
Begin
    declare @GpNum Int,@countlvl1 int;
    Select @countlvl1=Count(GpNumber) from cGp;
    if  @countlvl1=0
        begin
            print 'there is no group in level '+cast(@level1 as varchar)
        end
    else open GpLevel;
    fetch next from GpLevel into @GpNum;
    while @@fetch_status=0
        Begin
            update cGp
            SET GP_IDLEVEL=@level2
            where GPNUMBER=@GpNum;
            fetch next from GpLevel into @GpNum;
       End ;
    Close GpLevel;
    deallocate GpLevel;
end;
    exec  CHANGE_LVL '2','3';
    SELECT * FROM A_GP;
    SELECT * FROM cGP;

--2.Create a procedure which print the salaray of instructor  for 5% bigger based on the given hire date;
drop table c_instructor;
CREATE TABLE c_Instructor (
 IDInstructor integer   Primary Key,
    FName varchar(50) ,
    Surname varchar(50)  ,
    hiredate date  ,
    salary numeric(7,2)
) ;
insert into c_instructor
Select * from A_Instructor;

drop procedure CHANGE_SAL;
Create procedure CHANGE_SAL @hiredate date,@new_sal money output
as
    Declare inst cursor for
    SELECT salary
    FROM C_Instructor
    WHERE HIREDATE =@hiredate ;
Begin
    Declare @countInst numeric,@idI numeric;
    Select  @countInst= count(IDInstructor)
    from c_Instructor
    WHERE HIREDATE =@hiredate;
    if @countInst=0
     begin
            print 'THERE IS NO ONE WHO STARTED WORKING IN 2012'
     end
    else open inst;
    fetch next from inst  into @idI ;
    while @@fetch_status=0
        Begin
            select @new_sal=@idI+200
            from c_Instructor
            WHERE HIREDATE =@hiredate;
            Update c_Instructor
            set salary=@new_sal
            WHERE HIREDATE= @hiredate;
            fetch next from inst into @idI
       End ;
    Close inst;
    deallocate inst;
end;
Declare @new_sal_out money;
Execute CHANGE_SAL '17-MAR-2012',@new_sal_out output;
print @new_sal_out;
 select * from A_Instructor;
select * from c_Instructor;

--3. Create a procedure which change the date of the lesson in 10-12-2020 to 5-01-2021.
DROP TABLE C_LESSON ;

CREATE TABLE C_Lesson (
    IDLesson integer  PRIMARY KEY,
    LDate date ,
    L_IDGP integer,
    FOREIGN Key ( L_IDGP) References A_GP ( GpNumber)

) ;
insert into C_LESSON
Select * from A_LESSON;

Drop procedure CHANGE_DATE;
Create procedure CHANGE_DATE
 as
declare les cursor for
SELECT IDLESSON FROM C_LESSON WHERE LDATE='2020-12-10';
begin
    declare @countLes NUMeric,@idL numeric;
    select @countLes= count(IDlesson)
    from C_Lesson
    where LDate='2020-12-10';
    if @countLes=0
     begin
            print 'THERE IS NO LESSON AT 10-12-2020'
     end
    else open les;
    fetch next from les  into @idL ;
    while @@fetch_status=0
        Begin
            UPDATE C_LESSON
            SET LDATE= '2021-01-05'
           WHERE LDATE='2020-12-10';
            fetch next from les into @idL
       End ;
    Close les;
    deallocate les;
end;
    EXEC CHANGE_DATE ;
SELECT * FROM A_LESSON;
SELECT * FROM C_LESSON;


--TRIGGERS
--1.created triggers on lessons to show how many GROUPS HAS lessons on 10.12.2020 after insert or update or delete a row.
Drop table c1_lesson;
CREATE TABLE c1_Lesson (
    IDLesson integer  PRIMARY KEY,
    LDate date ,
    L_IDGP integer,
    FOREIGN Key ( L_IDGP) References A_GP ( GpNumber)

) ;
 insert into C1_LESSON
Select * from A_LESSON;

drop trigger tr_lesson;
Create trigger tr_lesson on  C1_LESSON for insert,delete ,update
    as
    begin
        declare c_les cursor for select L_IDGP from C1_Lesson where LDATE='2020-12-10';
        declare @idL varchar(50);
        declare @iDcount int;
        select  @iDcount=  count(L_IDGP) from C1_Lesson where LDATE='2020-12-10';
        if @iDcount=0
            begin
                print ('there is no lesson');
            end
        else open c_les;
        Fetch next from c_les into @idL;
        while @@fetch_status=0
         begin
             print ('Group number ' + @idL + ' has lesson on 2020-12-10');
             Fetch next from c_les into @idL;
         end;
             print ( CAST(@iDcount AS VARCHAR)+' GROUPS HAVE LESSONS ON 2020-12-10 ')
        close c_les;
        deallocate c_les;
    end;
insert into c1_Lesson Values(129,'10-DEC-2020 ',16);
update c1_Lesson set LDate='11-DEC-2020 ' where IDLesson= 127;
delete from c1_Lesson where IDLesson= 129;
select * from A_Lesson;
select * from c1_Lesson;


--2.create triggers which delete the row if the payment amount is lower than 90 after insert or updating.
Drop TABLE C_Payment;
CREATE TABLE C_Payment (
    IDPayment integer  Primary KEY,
    PaymentMethod varchar(50) ,
    Pdate date ,
    amount numeric(7,2),
    P_IDmembership integer,
    FOREIGN Key (P_IDmembership ) References A_membership (IDmembership)
) ;
insert into C_Payment
Select * from A_Payment;

DROP TRIGGER tr_payment;
Create trigger tr_payment on C_Payment for insert,update
    as
    if exists(select 1 from inserted where amount<90)
    begin
        declare pmt cursor for select IDPayment from inserted where amount<90;
        declare @idP int;
        open pmt;
        fetch next from pmt into @idP;
        while @@fetch_status=0
         begin
            delete from C_Payment where IDPayment= @idP;
            fetch next from pmt into @idP;
         end;
        close pmt;
        deallocate pmt;
    end;

Insert into C_Payment values(1220, 'card','22-DEC-2020',80,105);
Update C_Payment set amount=70 where IDPAYMENT= 1218;
Select * from A_Payment;
Select * from C_Payment;

--3.create triggers  which show the the students who was born after 2010  after inserting or updating on students.
DROP TABLE C1_Student ;

CREATE TABLE C1_Student (
    IDStudent integer   Primary Key,
    FName varchar(50) ,
    Surname varchar(50) ,
    DOB date
) ;
 insert into C1_Student
Select * from A_Student;

drop trigger tr_student;
Create trigger tr_student on  C1_Student for insert,delete ,update
    as
    begin
        declare c_st cursor for select IDStudent from C1_Student where  DOB >= '2010-01-01';
        declare @idL varchar(50);
        declare @iDcount int;
        select  @iDcount=  count(IDStudent) from C1_Student where DOB >= '2010-01-01';
        if @iDcount=0
            begin
                print ('there is no student');
            end
        else open c_st;
        Fetch next from c_st into @idL;
        while @@fetch_status=0
         begin
             print ( 'student id '+@idL + 'was born after 2010 ');
             Fetch next from c_st into @idL;
         end;
        close c_st;
        deallocate c_st;
    end;
Insert into c1_Student Values( 1222, 'Olivia','Mill4','10-FEB-2010');
update  c1_Student set dob= '2009-01-01' where idstudent=1134;
delete from c1_Student where idstudent=1222;

--4.create triggers  which show the DOB of oldest student after inserting  on students.
DROP TABLE C_Student ;

CREATE TABLE C_Student (
    IDStudent integer   Primary Key,
    FName varchar(50) ,
    Surname varchar(50) ,
    DOB date
) ;
 insert into C_Student
Select * from A_Student;

DROP TRIGGER oldestStudent;
CREATE TRIGGER oldestStudent
ON C_Student
FOR INSERT
AS
    DECLARE DOB CURSOR FOR
    SELECT IDSTUDENT from C_student;

BEGIN
    DECLARE @SDOB INT,@NUMS NUMERIC,@minDOB DATE;
    OPEN DOB;
    Fetch next from DOB into @SDOB  ;
    while @@fetch_status=0
        Begin
             Fetch next from DOB into @SDOB  ;
        End ;
         SELECT  @NUMS=COUNT(IDSTUDENT) FROM c_student;
           IF   @NUMS>6
               BEGIN
                   SELECT @minDOB =MIN(DOB)FROM c_student;
                    PRINT ('DOB OF OLDEST STUDENT IS '+ CAST(@minDOB AS VARCHAR) );
               end;
            else
                  PRINT ('there is no changes');

    Close DOB;
    deallocate DOB;
end;
Insert into C_Student Values( 2000, 'Olivia','STYLE','10-FEB-2008');


--PROCEDURES
--4.CREATE PROCEDURES WHICH RETRUN THE TOTAL NUMBER OF STUDENT WHO PAID BY card PAYMENT method.
Drop TABLE C1_Payment;
CREATE TABLE C1_Payment (
    IDPayment integer  Primary KEY,
    PaymentMethod varchar(50) ,
    Pdate date ,
    amount numeric(7,2),
    P_IDmembership integer,
    FOREIGN Key (P_IDmembership ) References A_membership (IDmembership)
) ;
insert into C1_Payment
Select * from A_Payment;
drop PROCEDURE RETURN_AMOUNT;
CREATE PROCEDURE RETURN_AMOUNT
    AS
    BEGIN
        DECLARE @total int;
        select @total= COUNT(IDPayment) from C1_Payment where PaymentMethod='card' ;
        return @total;
    end;
 Declare @x int;
 execute @x= RETURN_AMOUNT;
 print @x;










