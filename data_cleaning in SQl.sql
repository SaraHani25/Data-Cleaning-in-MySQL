-- data cleaning 

select *
from layoffs;

create table layoffs_staging 
like layoffs;
select*
from layoffs_staging;
insert layoffs_staging 
select*
from layoffs;

select *,
row_number() over(partition by company,industry,total_laid_off,percentage_laid_off,'date') as row_num
from layoffs_staging;

with dublicate_cte as  (
     select *,
row_number() over(partition by company,location,industry,total_laid_off,
                   percentage_laid_off,'date',country,funds_raised_millions) as row_num
from layoffs_staging
     )
select*
from dublicate_cte 
where row_num >1;
     
 CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
select *
from layoffs_staging2
where  row_num >1;
 
 insert into layoffs_staging2
  select *,
row_number() over(partition by company,location,industry,total_laid_off,
				percentage_laid_off,'date',country,funds_raised_millions) as row_num
from layoffs_staging;

select*
from layoffs_staging2
where  row_num >1;
delete
from layoffs_staging2
where  row_num >1;


-- standardizing data
SET SQL_SAFE_UPDATES = 0;

select company,trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

select* 
from layoffs_staging2
where industry like 'crypto%';
update layoffs_staging2
set industry ='crypto'
where industry like 'crypto%';
select distinct industry
from layoffs_staging2;

select distinct country, trim(trailing '.'  from country ) 
from layoffs_staging2
order by 1;
update layoffs_staging2
set country = trim(trailing '.'  from country )
where country like 'United States%';

select `date`,
str_to_date(`date`,'%m/%d/%Y')
from layoffs_staging2;
update layoffs_staging2
set `date` = str_to_date(`date`,'%m/%d/%Y');

alter table layoffs_staging2
modify column `date` date;

select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select distinct industry
from layoffs_staging2;
select*
from layoffs_staging2
where industry is null
or industry =' ';
select *
from layoffs_staging2
where company = 'Airbnb';

select*
from layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company=t2.company
and t1.location=t2.location
where (t1.industry is null or t1.industry= ' ')
and t2.industry is null;

update layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company=t2.company
set t1.industry=t2.industry
where (t1.industry is null or t1.industry= ' ')
and t2.industry is null;

select* 
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

delete
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;
select* 
from layoffs_staging2;

alter table layoffs_staging2
drop column row_num;