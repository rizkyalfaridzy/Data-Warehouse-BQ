# **Data Warehouse - BigQuery**
Build a data warehouse in BigQuery using repeated columns.

## **Problem**
From this public table `data-to-insights.ecommerce.rev_transactions`. Create an efficient query which derives the total transactions per date and country based on the channel grouping!

## **Tech Stack**
BigQuery

## **SET UP**
1. Open google cloud console https://console.cloud.google.com/
2. On your GCP console, go to BigQuery. You can find it on More Products > Analytics > BigQuery, or simply search it at the search bar.
3. On Explorer click 'ADD DATA' > Star a project by name > fill "data-to-insights" > click 'STAR'
4. Expand node data-to-insights > ecommerce > rev_transactions.
   Table rev_transactions consists of 28 features, here is the schema:
   
   . <img width="457" alt="Screenshot 2023-03-12 at 17 34 02" src="https://user-images.githubusercontent.com/113230789/224539189-08065c35-dbbc-42fc-99df-94827fb2e77c.png">
   
   . <img width="457" alt="Screenshot 2023-03-12 at 17 33 48" src="https://user-images.githubusercontent.com/113230789/224539194-18597e90-a7ee-4f82-9862-d26b5431d904.png">


## **QUERY**
``` SQL
WITH tblsource AS (
  SELECT channelGrouping,
          date, 
          geoNetwork_country,
          COUNT(DISTINCT hits_transaction_transactionId) AS totals_trx
  FROM `data-to-insights.ecommerce.rev_transactions`
  WHERE NOT geoNetwork_country = "(not set)"
  GROUP BY 1,2,3
  ORDER BY 1,2,3,4
  )
SELECT channelGrouping AS Channel,
      ARRAY_AGG(STRUCT(date,
                       geoNetwork_country,
                       totals_trx)) AS trx
FROM tblsource
GROUP BY 1
```

## **RESULT**
<img width="1116" alt="Screenshot 2023-03-12 at 22 18 31" src="https://user-images.githubusercontent.com/113230789/224554227-f566057e-5165-419a-be0b-eb2b0baacbd6.png">

Save the results to the bigquery table, now we are done creating the data warehouse in BigQuery!

For more detail, you can see the result here: https://docs.google.com/spreadsheets/d/1WcembUS2hppA34GZ4y4ClXMOgRaugtnMOkuydFO27bE/edit?usp=sharing
