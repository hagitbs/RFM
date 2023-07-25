CREATE OR REPLACE MODEL `devtest.Demo.RFM_Model` -- name of the table where to store the mode.
OPTIONS( 
      model_type='kmeans',  -- model to user
      num_clusters=5, -- number of clusters to create.
      standardize_features = true  -- normalize all the data points. usefull for distance based models such as k-means.
    ) AS

-- excluding user_id as it won't be the part of the model.
-- replace project and dataset with appropriate values
select * except (user_id) from `<projectname>.<dataset>.RFM_Values`
