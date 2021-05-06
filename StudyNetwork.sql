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
drop table Users

create table Pages(
	PageID char(5) PRIMARY KEY
	check(PageID like 'PA[0-9][0-9][0-9]'),
	PageName varchar(255),
	PageContent varchar(255) Not Null
	check (PageContent like 'https://%')
)

select * from Pages
drop table Pages

create table PageLikes(
	UserID char(5),
	PageID char(5),
	Constraint PageLikeFK1 Foreign Key (UserID) References Users (UserID)
	on update cascade on delete cascade,
	Constraint PageLikeFK2 Foreign Key (PageID) References Pages (PageID)
	on update cascade on delete cascade,
	Constraint PageLikePK Primary Key (UserID, PageID)
)

drop table PageLikes

create table Friends(
	UserID char(5),
	FriendID char(5)
	check(FriendID like 'FR[0-9][0-9][0-9]') NOT NULL,
	Constraint UserFK Foreign Key (UserID) References Users (UserID)
	on update cascade on delete cascade,
	Constraint FriendPK Primary Key (UserID, FriendID)
)

drop table Friends


create table Posts(
    UserID char(5) FOREIGN KEY REFERENCES Users(UserID) ON UPDATE CASCADE ON DELETE cascade,
    PostID char(5) check(PostID like 'PO[0-9][0-9][0-9]'),
    PostDate date Not Null,
    PostContent varchar(255) check (PostContent like 'https://%'),
    CONSTRAINT PostPK PRIMARY KEY (PostID)
)

drop table Posts


create table PostLikes(
    UserID char(5),
    PostID char(5),
	constraint PostLikePK Primary Key (UserID, PostID),
    constraint PostLikeFK1 foreign key (PostID) REFERENCES Posts(PostID) ON UPDATE no action ON DELETE no action,
	constraint PostLikeFK2 foreign key (UserID) REFERENCES Users(UserID) ON UPDATE CASCADE ON DELETE CASCADE
)

drop table PostLikes



create table Photos(
	PostID char(5),
	PhotoID char(5)
	check (PhotoID like 'PH[0-9][0-9][0-9]') NOT NULL Primary Key,
	PhotoContent varchar(255)
	check (PhotoContent like 'https://%'),
	Constraint PhotoLikeFK Foreign Key (PostID) References Posts (PostID)
	on update cascade on delete cascade
)

drop table Photos


create table Shares(
	UserID char(5),
	PostID char(5),
	Constraint ShareFK1 Foreign Key (PostID) References Posts (PostID)
	on update cascade on delete cascade,
	Constraint ShareFK2 Foreign Key (UserID) References Users (UserID)
	on update no action on delete no action,
	Constraint SharesPK Primary Key (PostID, UserID)
)

drop table Shares

create table Comments(
	PostID char(5),
	UserID char(5),
	CommentID char(5),
	CommentDate date NOT NULL,
	CommentContent varchar (255)
	Constraint CommentFK1 Foreign Key (PostID) References Posts (PostID)
	on update cascade on delete cascade,
	Constraint CommentPK Primary Key (PostID, UserID, CommentID)
)

drop table Comments



create table CommentLikes(
	UserLikeID char(5),
	PostID char(5),
	CommentID char(5),
	UserCommenterID char (5),
	Constraint CommentLikeFK1 Foreign Key (PostID, UserCommenterID, CommentID) References Comments(PostID, UserID, CommentID)
	on update cascade on delete cascade,
	Constraint CommentLikeFK2 Foreign Key (UserLikeID) References Users(UserID)
	on update no action on delete no action,
	Constraint CommentLikePK Primary Key (UserLikeID, PostID, CommentID, UserCommenterID)
)

drop table CommentLikes
