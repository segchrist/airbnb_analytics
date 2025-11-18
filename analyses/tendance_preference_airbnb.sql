-- Question 4 :
-- Comparer l'évolution du tourisme total et de l'utilisation d'Airbnb,
-- en estimant le nombre de séjours Airbnb à partir du nombre de reviews.

-- calculer le nombre total de reviews Airbnb par année
with yearly_reviews as (
    select
        date_trunc('year', review_date) as annee,
        sum(number_review) as total_reviews
    from {{ ref('curation_reviews') }}
    group by 1
),

-- récupérer le nombre total de touristes par année
tourists as (
    select
        date_trunc('year', year) as annee,
        tourists
    from {{ ref('curation_tourist_per_year') }}
)

-- fusionner les deux sources + calculer les indicateurs
select
    t.annee,             
    t.tourists,          
    r.total_reviews,     
    -- Estimation du nombre de séjours Airbnb à partir des reviews
    -- Hypothèse : en moyenne 0,8 review par séjour
    round(r.total_reviews / 0.8) as estimation_nuitees_airbnb,

    -- Part estimée de séjours Airbnb par rapport au volume total de touristes
    round((r.total_reviews / 0.8) * 100.0 / t.tourists, 3)
        as part_airbnb_touristes_pct

from tourists t
left join yearly_reviews r using (annee)
    -- jointure année par année entre touristes et reviews
order by t.annee;
    -- on classe par année pour voir la tendance dans le temps
