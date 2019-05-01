CREATE USER normal_user;

DROP DATABASE IF EXISTS normal_cars;

CREATE DATABASE normal_cars WITH OWNER normal_users;

CREATE USER normal_user;

create table makes_models as
(select distinct
	dense_rank() over(order by make_code, model_code) as id,
	dense_rank() over(order by make_code, make_title) as make_id,
	dense_rank() over(order by model_code, model_title) as model_id
from car_models);

create table makes as
(select distinct
	dense_rank() over(order by make_code, make_title) as id,
	make_code,
	make_title
from car_models);

create table models as 
(select distinct
	dense_rank() over(order by model_code, model_title) as id,
	model_code,
	model_title
from car_models);

create table years as 
(select distinct 
	dense_rank() over(order by make_code, model_code) as makes_models_id,
	year
from car_models);

select make_title
from makes;

select distinct models.model_title
from models
	inner join makes_models on makes_models.model_id = models.id
	inner join makes on makes.id = makes_models.make_id
where makes.make_code = 'VOLKS';

select distinct makes.make_code, models.model_code, models.model_title, year
from models
	inner join makes_models on makes_models.model_id = models.id
	inner join makes on makes.id = makes_models.make_id
	inner join years on years.makes_models_id = makes_models.id
where makes.make_code = 'LAM';

select *
from models
	inner join makes_models on makes_models.model_id = models.id
	inner join makes on makes.id = makes_models.make_id
	inner join years on years.makes_models_id = makes_models.id
where year between 2010 and 2015;

