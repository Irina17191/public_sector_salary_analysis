
with base as(
select s0.guid, 
       s0.declaration_year, 
       s0.postcategory, 
       (nullif(regexp_replace(s11.sizeincome, '[^0-9.,]', '', 'g'), '')::numeric / 12) as monthly_income,
       s11.source_edrpou,
       s11.objecttype,
       s11.otherobjecttype,
       dm.edrpou,
       dm.name
from step_0_general s0
left join step_11_revenues s11
  on s0.guid = s11.guid
    and s0.declaration_type = 'Щорічна'
inner join dict_edrpou_covv dm 
  on s11.source_edrpou = dm.edrpou
where declaration_year in ('2022', '2023', '2024')
 and (s11.objecttype = 'Заробітна плата отримана за основним місцем роботи' or s11.objecttype = 'Заробітна плата (грошове забезпечення)')
 and s11.sizeincome is not null
 and s11.recipient = 'декларант'
 and not (s11.objecttype LIKE '%Інше%' and s11.otherobjecttype LIKE '%грошове забезпечення%')
),



-- 1. у кого більше ніж одна основна зп (роблю дублікати зп на основі step_0_general + step_11_revenues)
duplicate_salary_guids as (
  select declaration_year, s0.guid
  from step_0_general s0
  left join step_11_revenues s11
    on s0.guid = s11.guid
      and s0.declaration_type = 'Щорічна'
  where (s11.objecttype = 'Заробітна плата отримана за основним місцем роботи' or s11.objecttype = 'Заробітна плата (грошове забезпечення)')
    and s11.recipient = 'декларант'
    and declaration_year in ('2022', '2023', '2024')
    and s11.sizeincome is not null
    and not (s11.objecttype LIKE '%Інше%' and s11.otherobjecttype LIKE '%грошове забезпечення%')
  group by declaration_year, s0.guid
  having count(*) > 1
),



-- 2. Відкидаю тих, у кого більше ніж одна зп
filtered as (
  select *
  from base
  where (declaration_year, guid) NOT IN (SELECT declaration_year, guid FROM duplicate_salary_guids)
),



-- 3. Додаю розбиття на квартилі
ranked as (
  select *,
         ntile(5) over (partition by edrpou, postcategory, declaration_year order by monthly_income) as income_quartile
  from filtered
  where monthly_income is not null
)



-- 4. Фінальна вібірка, лише квартилі 2, 3 та 3 та групування по міністерству та категорії
select 
       edrpou || ' ' || name as "назва ЦОВВ", 
       declaration_year,
       case when postcategory is null or trim(postcategory) = '' then 'Без категорії' else postcategory end as категорія,
       count(*) as кількість, 
       round(avg(monthly_income), 2) as avg_salary,
       round(percentile_cont(0.5) within group (order by monthly_income)::numeric, 2) as median_salary
from ranked
where income_quartile in (2, 3, 4)
      and edrpou not in ('00033005', '05387386', '37568550', '36591201', '37472277')
group by edrpou, name, declaration_year, категорія 
order by name, declaration_year, категорія;


