drop schema ets_schema;

create schema ets_schema;

use ets_schema;

 

 

 

CREATE TABLE marketData (

    ticker VARCHAR(3) PRIMARY KEY NOT NULL,

    companyName VARCHAR(45),

    quantity INT,

    price DECIMAL

);

 

                                                                                                                       

insert into marketData values("SBI", "SBIN", 15000, 332);

insert into marketData values("SBB", "SBBJ", 25000, 798);

insert into marketData values("BAN", "BANKINDIA", 5000, 34);

insert into marketData values("GLI", "GLITTEKG", 67000, 600);

insert into marketData values("SRI", "SRIVAJRA", 4567, 55);

insert into marketData values("SOL", "SOLIDSTON", 4556, 330);

insert into marketData values("NES", "NESTLEIND", 9809, 500);

insert into marketData values("MOD", "MODAIRY", 1000, 250);

insert into marketData values("MLK", "MLKFOOD", 10000, 100);

insert into marketData values("NCC", "NCCBLUE", 1500, 100);

 

Select * from ets_schema.orderBook where status=1;
 

 



 

CREATE TABLE login (

    loginId INT PRIMARY KEY,

    userName VARCHAR(45),

    password VARCHAR(45),

               role TINYINT(1) NOT NULL

);

 

insert into login values(1, "john", "abc123", 1);

insert into login values(2, "anny", "abc123", 1);

insert into login values(3, "arsh", "abc123", 1);

insert into login values(4, "olivers", "xyz123", 0);

 

CREATE TABLE trader (

    suggestionid INT PRIMARY KEY auto_increment,

    traderId INT,

    blockId INT,

    ticker VARCHAR(3),

    quantity INT,

    price DECIMAL,

    side VARCHAR(15),

    foreign key(traderId) references login(loginId),

    FOREIGN KEY (ticker) REFERENCES marketData (ticker)

);

 

 

 

 

CREATE TABLE orderbook (

    orderID INT PRIMARY KEY auto_increment,

    traderId INT,

    blockId INT,

    timeStamp DATETIME,

    ticker VARCHAR(3),

    quantity INT,

    price DECIMAL,

    side VARCHAR(15),

    status INT,

    processedQ DECIMAL,

    FOREIGN KEY (traderId) REFERENCES login (loginId),

    FOREIGN KEY (ticker) REFERENCES marketData (ticker)

);

 

CREATE TABLE profile (

    profileid INT NOT NULL,

    firstname VARCHAR(45) NULL,

    lastname VARCHAR(45) NULL,

    PRIMARY KEY (profileid),

    FOREIGN KEY (profileid) REFERENCES login (loginId)

);

insert into profile values(1, "John", "Peters");

insert into profile values(2, "Anny", "Sebastian");

insert into profile values(3, "Harsh", "Awasthi");

insert into profile values(4, "Jim", "Olivers");

 Select * from orderbook where status=1;

insert into orderbook (traderId, ticker, quantity, price, side, status) values(1, "sbi", 200, 30, "buy", 1);

insert into orderbook (traderId, ticker, quantity, price, side, status) values(2, "sbi", 100, 40, "sell", 1);

insert into orderbook (traderId, ticker, quantity, price, side, status) values(3, "sbi", 80, 30, "sell", 0);

insert into orderbook (traderId, ticker, quantity, price, side, status) values(1, "nes", 300, 70, "buy", 1);

insert into orderbook (traderId, ticker, quantity, price, side, status) values(3, "nes", 250, 35, "sell", 1);

insert into orderbook (traderId, ticker, quantity, price, side, status) values(3, "nes", 20, 50, "sell", 0);

 
update ets_schema.orderbook set status=0, processedQ=0 ;
 
 Select * from orderbook where status=1;
 select * from ets_schema.orderbook;

select ob.ticker, md.price, sum(ob.quantity)-(select sum(quantity) from orderbook where side = "sell" and status=1 and ticker=ob.ticker) from orderbook  ob 
join marketdata md 
on md.ticker= ob.ticker
where side = "buy" and status = 1 
group by ob.ticker;