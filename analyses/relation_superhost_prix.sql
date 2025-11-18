-- Question 3 : Étudier la relation entre la qualification super-hôte et le prix

with listings_hosts as (
    select
        l.listing_id,
        l.price,
        h.is_superhost
    from {{ ref('curation_listing') }} l
    left join {{ ref('curation_host') }} h using (host_id)
    where l.price is not null
)

select
    is_superhost,
    avg(price)    as prix_moyen,
    median(price) as prix_median,
    min(price)    as prix_min,
    max(price)    as prix_max,
    count(*)      as nombre_listings
from listings_hosts
group by is_superhost;
