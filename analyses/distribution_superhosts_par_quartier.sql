-- Question 2 : Distribution des super-hôtes Airbnb par quartier

with hosts as (
    select host_id, is_superhost
    from {{ ref('curation_host') }}
),
listings as (
    select
        listing_id,
        host_id,
        neighbourhood_overview as quartier
    from {{ ref('curation_listing') }}
    where neighbourhood_overview is not null
)

select
    l.quartier,
    count(*) as nombre_listings,
    sum(case when h.is_superhost then 1 else 0 end) as nombre_superhosts,
    round(
        sum(case when h.is_superhost then 1 else 0 end) * 100.0 / count(*),
        2
    ) as pourcentage_superhosts
from listings l
left join hosts h using (host_id)
group by 1
order by pourcentage_superhosts desc;
