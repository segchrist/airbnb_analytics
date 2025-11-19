# 🏡 Airbnb Analytics — Projet Data (Snowflake + dbt)

## 🎯 Objectif du projet

Ce projet a été réalisé dans le cadre d’un **Bootcamp Data Analytics**.  
Il consiste à analyser l’activité Airbnb à Amsterdam afin de répondre à des questions business clés :

- Quels quartiers sont les plus chers ?
- Où se trouvent les superhôtes ?
- Les superhôtes facturent-ils plus cher ?
- Les touristes utilisent-ils de plus en plus Airbnb au fil du temps ?

Ce travail couvre les compétences **Data Engineering + Data Analytics** sur une stack moderne.

---

## 🧱 Stack Technique

| Technologie     | Rôle                                      |
|----------------|--------------------------------------------|
| **Snowflake**   | Stockage et traitement SQL                 |
| **dbt Cloud**   | Transformation, versioning, tests & documentation |
| **dbt Seeds**   | Ajout d’une source externe (tourisme)     |
| **dbt Snapshots** | Historisation des données (SCD2)         |

---

## 🔍 Données utilisées

- Données Airbnb (`hosts`, `listings`, `reviews`) récupérées sur Snowflake  
- Données externes sur le volume de touristes via seed CSV (`tourists_per_year.csv`)  
- Documentation et tests de qualité définis dans `schema.yml`  
- Historisation de l’évolution des hôtes et des logements via `snapshots`

Le projet s’appuie sur les tables sources `hosts`, `listings`, `reviews` et `tourists_per_year`,
sont transformées via des modèles de curation (nettoyage des colonnes, normalisation des types, calculs agrégés, historisation par snapshots SCD2) 
et contrôlées par des tests dbt (`unique`, `not_null`, `accepted_values`) afin de garantir la qualité des données utilisées dans les analyses.

---

## 📊 Analyses produites

| Analyse                      | Question métier                         | Résultat attendu           |
|-----------------------------|------------------------------------------|----------------------------|
| Prix par quartier           | Où sont les logements les plus chers ?   | Requête SQL                |
| Répartition des superhôtes  | Où se concentre la qualité ?             | Requête SQL                |
| Superhôte ↔ Prix            | Impact sur les tarifs                    | Requête SQL                |
| Airbnb vs tourisme          | Airbnb prend-il des parts ?              | Requête SQL                |

*(Aucune interprétation ou insight n’est fourni dans le cadre de ce projet.)*

---

## 🚀 Exécution dans dbt

```bash
dbt seed        # Charger les données externes
dbt run         # Construire et transformer les données
dbt snapshot    # Historiser les modifications (SCD2)
dbt test        # Vérifier la qualité des données
