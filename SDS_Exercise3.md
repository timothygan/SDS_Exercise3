SDS\_Exercise3
================

# Predictive Model Building

### Problem

For this first question, our goal was to create a model that would be
able to predict the rent of buildings from Exercise 1. From there, we
should be able to take that model, and predict the change in rent if a
building’s green\_rating changed.

### Data and Model

We created 3 linear regression models to test various combinations of
attributes to see if they were good indicators of Rent. The first (V1)
was a combination of attributes related to age and size, the second (V2)
was only concerned with amenities, and the last (V3) looked at
gas/electricity costs and the number of heating/cool days in the region.
All three of these models also used the green\_rating. We decided to
lump LEED and EnergyStar together for simplicity as we did not see too
much difference between the two. The green\_rating attribute indicates
whether or not the building was green certified.

In our fourth linear regression model (V4), we combined all of these
elements and introduced interactions between attributes. We included
interactions between gas/electricity costs and total degree days as the
number of degree days will affect the cost of gas/electricity. We
included an interaction between age and renovation as a building that is
old but renovated will likely be more expensive than a building that is
only old and not renovated. The final interaction we had was between
gas/electricity costs and green\_rating, as a building will be more
energy efficient if it is a ‘green’ building, resulting in lower
gas/electricity costs. Other than those interactions, we also used
stories, size, and cluster\_rent as they were good/significant
predictors.

We tested these models on 100 different test/training splits. For each
split, we created the three linear models on a training set, predicted
Rent on a given test set, and calculated RMSE between the four models’
predictions and actual values for Rent. We selected different
test/training sets for each split.

As for predicting the average change in Rent given a change in
green\_rating, we took the entire dataset, flipped the green\_rating,
and predicted the Rent on the entire set using V4 with all other
attributes held constant. Once we had that value, we took the mean of
the differences between the predicted Rent and actual Rent of every
building. We did this within the test/training splits as well.

### Results

![](SDS_Exercise3_files/figure-gfm/green_buildings-1.png)<!-- -->

    ##        V1        V2        V3        V4 
    ## 14.772572 15.031173 13.731533  9.346892

As seen above, the final model V4 outperforms the other three due to the
use of interactions as well as incorporating elements from the other
three models.

![](SDS_Exercise3_files/figure-gfm/green_buildings_2-1.png)<!-- -->

    ##        V5        V6 
    ##  1.077597 -1.051898

V5 indicates the average change in Rent when a building that was
previously not green becomes green. V6 indicates the average change in
Rent when a building that was previously green becomes not green. As
seen above, if a building changes its green rating, the change in Rent
is approximately 1 dollar according to our model. That is, rent will be
$1.08 more expensive if a building becomes green, and $1.05 less
expensive if a building loses its green status.

### Conclusion

We were able to create a model using linear regression techniques to
predict a building’s rent, where the average RMSE of our model was 9.34.
From that model, we were able to project the change in rent given a
change in a building’s green\_rating while all other factors constant.
It appears if a building’s green\_rating status changes, the change in
rent will be around a dollar, either more expensive if the building was
previously not green or less expensive if the building was previously
green.

## Including Plots

You can also embed plots, for example:

![](SDS_Exercise3_files/figure-gfm/pressure-1.png)<!-- -->

Note that the `echo = FALSE` parameter was added to the code chunk to
prevent printing of the R code that generated the plot.
