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

| Technologie | Rôle |
|------------|-----|
| **Snowflake** | Stockage et traitement SQL |
| **dbt Cloud** | Transformation, versioning, tests & documentation |
| **dbt Seeds** | Ajout d’une source externe (tourisme) |
| **dbt Snapshots** | Historisation des données (SCD2) |

---


## 🔍 Données utilisées

- Données Airbnb (hosts, listings, reviews) récupérées sur Snowflake  
- Données externes annuelles sur le nombre de touristes via **seed CSV**
- Documentation & Data Quality définies dans `schema.yml`
- Historisation de l’évolution des hôtes et annonces via snapshots

---

## 📊 Analyses produites

| Analyse | Question métier | Résultat |
|--------|----------------|---------|
| Prix par quartier | Où sont les logements les plus chers ? | Comparaison des zones |
| Répartition des superhôtes | Où se concentre la qualité ? | % de superhôtes |
| Superhôte ↔ Prix | Impact sur les tarifs | Écart moyen de prix |
| Airbnb vs tourisme | Airbnb prend-il des parts ? | Tendance d’adoption |

---

## 🚀 Exécution dans dbt

```bash
dbt seed        # Charger les données externes
dbt run         # Construire et transformer les données
dbt snapshot    # Historiser les modifications (SCD2)
dbt test        # Vérifier la qualité des données
