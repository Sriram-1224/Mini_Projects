create database if not exists Digital_Library;
Use Digital_Library;

create table Books(
    BookID int primary key auto_increment,
    BookName varchar(150) not null,
    AuthorName varchar(150),
    Category varchar(50),
    TotalCopies int
);

create table Students(
    StudentID int primary key auto_increment,
    StudentName varchar(100) not null,
    Department varchar(50),
    JoinDate date
);

create table IssuedBooks(
    IssueID int primary key auto_increment,
    StudentID int,
    BookID int,
    IssueDate date,
    ReturnDate date,
    Foreign key (StudentID) references Students(StudentID),
    Foreign key (BookID) references Books(BookID)
);

insert into Books(BookName,AuthorName,Category,TotalCopies) values
('Java','James Gosling','Programming',10),
('Python','Guido Van Rossum','Programming',8),
('World History','Ramesh Kumar','History',7),
('The Alchemist','Paulo Coelho','Fiction',12),
('Data Structures','Mark Allen','Education',6);

insert into Students(StudentName,Department,JoinDate) values
('Rahul','CSIT','2021-06-15'),
('SriRam','CSE','2020-08-10'),
('Poojith','CSE','2019-07-20'),
('Arun','ECE','2018-05-11'),
('Priya','IT','2017-03-25');

insert into IssuedBooks(StudentID,BookID,IssueDate,ReturnDate) values
(1,1,'2026-03-20',NULL),
(2,4,'2026-04-10','2026-04-18'),
(3,2,'2026-03-15',NULL),
(4,3,'2022-01-10','2022-01-20'),
(5,5,'2021-02-15',NULL);


select 
    Students.StudentName,
    Books.BookName,
    IssuedBooks.IssueDate
from 
IssuedBooks join Students
on IssuedBooks.StudentID = Students.StudentID
join Books
on IssuedBooks.BookID = Books.BookID
where 
IssuedBooks.ReturnDate is NULL
and
DATEDIFF(CURDATE(), IssuedBooks.IssueDate) > 14;


select 
    Books.Category,
    count(*) as TotalBorrowed
from 
IssuedBooks join Books
on IssuedBooks.BookID = Books.BookID
group by Books.Category
order by TotalBorrowed desc;

alter table Students
add Status varchar(20) default 'Active';

update Students
set Status = 'Inactive'
where StudentID not in
(
    select StudentID
    from IssuedBooks
    where YEAR(IssueDate) >= YEAR(CURDATE())-3
);

select 
    StudentID,
    StudentName,
    Department,
    Status
from Students;