-- Question 1 : Quelle est la distribution des prix par quartier à Amsterdam ?

with listings as (
    select
        neighbourhood_overview as quartier,
        price
    from {{ ref('curation_listing') }}
    where price is not null
      and neighbourhood_overview is not null
)

select
    quartier,
    avg(price)    as prix_moyen,
    median(price) as prix_median,
    min(price)    as prix_min,
    max(price)    as prix_max,
    count(*)      as nombre_listings
from listings
group by 1
order by prix_moyen desc;
