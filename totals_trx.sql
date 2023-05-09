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