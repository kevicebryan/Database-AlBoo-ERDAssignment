create database StudyNetwork
use StudyNetwork

create table Users(
	UserID  char(5) PRIMARY KEY
	check(UserID like 'US[0-9][0-9][0-9]'),
	UserFirstName varchar(255) NOT NULL,
	UserLastName varchar (255),
	UserSchool varchar (255),
	UserAddress varchar (255),
	UserEmail varchar (255) Not Null
	check (UserEmail like '%@%'),
	UserPhoneNumber varchar(10) Not Null
	check (UserPhoneNumber like '08%'),
	UserLocation varchar(255),
	UserDateofBirth date,
	UserGender varchar(6)
	check( UserGender like 'Male' or UserGender like 'Female')
)


select * from Users

create table Pages(
	PageID char(5) PRIMARY KEY
	check(PageID like 'PA[0-9][0-9][0-9]'),
	PageName varchar(255),
	PageContent varchar(255) Not Null
	check (PageContent like 'https://%')
)

select * from Pages

create table PageLikes(
	UserID char(5),
	PageID char(5),
	PageLikeId char(6)
	check (PageLikeID like 'PaL[0-9][0-9][0-9]') not null primary key,
	Constraint PageLikeFK1 Foreign Key (UserID) References Users (UserID)
	on update cascade on delete set NULL,
	Constraint PageLikeFK2 Foreign Key (PageID) References Pages (PageID)
	on update cascade on delete set NULL
)



create table Friends(
	UserID char(5),
	FriendID char(5)
	check(FriendID like 'FR[0-9][0-9][0-9]') NOT NULL Primary Key,
	Constraint UserFK Foreign Key (UserID) References Users (UserID)
	on update cascade on delete set NULL,
)

create table Posts(
	UserID char(5),
	PostID char(5)
	check(PostID like 'PO[0-9][0-9][0-9]') NOT NULL Primary Key,
	PostDate date Not Null,
	PostContent varchar(255)
	check (PostContent like 'https://%')
	Constraint PostFK Foreign Key (UserID) References Users (UserID)
	on update cascade on delete set NULL,
)

create table PostLikes(
	UserID char(5),
	PostID char(5),
	PostLikeId char(6)
	check (PostLikeID like 'PoL[0-9][0-9][0-9]') not Null primary key,
	Constraint PostLikeFK1 Foreign Key (UserID) References Users(UserID)
	on update cascade on delete set NULL,
	Constraint PostLikeFK2 Foreign Key (PostID) References Posts (PostID)
	on update cascade on delete set NULL
)



create table Photos(
	PostID char(5),
	PhotoID char(5)
	check (PhotoID like 'PH[0-9][0-9][0-9]') NOT NULL Primary Key,
	PhotoContent varchar(255)
	check (PhotoContent like 'https://%'),
	Constraint PhotoLikeFK Foreign Key (PostID) References Posts (PostID)
	on update cascade on delete set NULL
)

create table Shares(
	UserID char(5),
	PostID char(5),
	SharesId char(6)
	check (SharesID like 'SHA[0-9][0-9][0-9]') not null Primary Key,
	Constraint ShareFK1 Foreign Key (UserID) References Users(UserID)
	on update cascade on delete set NULL,
	Constraint ShareFK2 Foreign Key (PostID) References Posts (PostID)
	on update cascade on delete set NULL
)

create table Comments(
	PostID char(5),
	CommentID char(5) Primary Key
	check (CommentID like 'CO[0-9][0-9][0-9]') NOT NULL,
	UserID char(5),
	CommentDate date NOT NULL,
	CommentContent varchar (255)
)



create table CommentLikes(
	CommentID char(5),
	UserID char(5),
	CommentLikeId char(6)
	check (CommentLikeID like 'CoL[0-9][0-9][0-9]') not null Primary Key,
	Constraint CommentLikeFK1 Foreign Key (UserID) References Users(UserID)
	on update cascade on delete set NULL,
	Constraint CommentLikeFK2 Foreign Key (CommentID) References Comments(CommentID)
	on update cascade on delete set NULL
)


