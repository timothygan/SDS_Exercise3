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

# What Causes What

### Question 1

The podcast talks about how the data is quite messy because high crime
cities have an incentive to hire a lot of police. This creates a direct
relation between police and crime, and causes the number of police
present depend on the crime and skews how the relation looks the other
way around.

### Question 2

The researchers were able to use Washington D.C.’s terrorism alert
system to create a situation where more police happened to be present
for reasons unrelated to crime. This let them ask on these alert days
what happens to crime when there are more police present on the street
and in various areas. The table shows how on high alert days, crime rate
is decreased by 5%. They were able to verify that the crime rate did not
decrease because people were scared of a terrorist threat by tracking
the number of people who took the metro. The number of people taking
metro barely changed, indicating that the number of people that stayed
inside due to a terrorist threat on these alert days did not change
significantly.

### Question 3

They were trying to see whether or not people were staying inside
because there was a terrorist threat. People staying at home rather than
robbing stores would explain the decrease in crime rather than the extra
number of police. However, they saw that the number of riders in the
metro (essentially the number of possible victims) did not change
significantly between high alert days and normal days. This meant that
the decrease in crime rate in D.C. was most likely caused by the higher
number of police that were present during these high alert days.

### Question 4

The model is estimating the reduction in crime on high alert days in
various districts. It can be seen that the district in D.C. has
significant decrease in crime rate in comparison to other districts that
did not have an increase in police during high alert days. This implies
the number of police present decreases the crime rate.

# Clustering and PCA

## The data

We are given data on the chemical properties of 6500 different bottles
of vinho verde wine from northern Portugal. We are also given the color
of each bottle of wine, and it’s quality as determined by a panel of
wine tasters. The goal is to determine if various methods of
dimensionality reduction are capable of separating the bottles of wine
by color and quality using only their chemical properties

## PCA

The first method we will test is Principle Component Analysis. Here is a
biplot of the first 2 PC’s of a second order PCA of the data:

![](SDS_Exercise3_files/figure-gfm/PCA-1.png)<!-- -->

The first PC axis seems to primarily assign red wines negative values
and white wines positive values. Examining PC1 further, these are the 11
chemical properties sorted from most negatively associated with PC1 to
most positively assoiated:

    ##     volatile.acidity            chlorides            sulphates 
    ##           -0.3934947           -0.3219381           -0.3098422 
    ##        fixed.acidity                   pH              density 
    ##           -0.2666771           -0.2060287           -0.1076854 
    ##          citric.acid       residual.sugar  free.sulfur.dioxide 
    ##            0.1405374            0.3112802            0.4216289 
    ## total.sulfur.dioxide 
    ##            0.4753293

## K-means++

The next method we will test is K-means++ clustering. With k=2 and
nstart=25, we get two clusters, the first consisting of 789 white wines
and 262 red wines, and the second consisting of 4109 white wines and
1337 red wines, indicating that k-means++ is very capable of
distinguishing between red and white wines.

## Quality

We will now determine if k-means++ is also capable of distinguishing the
quality of wine based on it’s chemical properties by using a larger
number of clusters. Running k-means++ on the same data but using k=4
instead we get 4 clusters with a respective average quality of NA, NA,
NA, and NaN respectively. These all are all very close to both each
other and the average quality of the entire data set, indicating that
k-means++ did not significantly separate the wines based on quality in
this case.

## Conclusion

While both methods seem to be able to distinguish wine color, we believe
that k-means++ makes more sense than PCA for this data set because the
size of the data set is much larger than the number of attributes used.
However principal component analysis did reveal some potentially useful
information. Namely that qualities like high volatile acidity and
chloride composition are associated with red wines and qualities like
residual sugar and sulfur dioxide are associated with white wines.
However, k-means++ was not able to distinguish the quality of wines.
More research would be needed to determine if this is a failure of the
choice of technique or if these specific chemical properties are not
indicative of quality.

# Market segmentation

## The data

We have the twitter data of a sample of Twitter accounts that follow the
NutrientH2O brand account. Namely, the data consists of the frequency of
tweets by each account in various categories as determined by human
annotators through Amazon’s Mechanical Turk servidce. Each of these
categories are listed below:

    ##  [1] "X"                "current_events"   "travel"           "photo_sharing"   
    ##  [5] "tv_film"          "sports_fandom"    "politics"         "food"            
    ##  [9] "family"           "home_and_garden"  "music"            "news"            
    ## [13] "online_gaming"    "shopping"         "health_nutrition" "college_uni"     
    ## [17] "sports_playing"   "cooking"          "eco"              "computers"       
    ## [21] "business"         "outdoors"         "crafts"           "automotive"      
    ## [25] "art"              "religion"         "beauty"           "parenting"       
    ## [29] "dating"           "school"           "personal_fitness" "fashion"         
    ## [33] "small_business"

    ##  [1] "X"                "current_events"   "travel"           "photo_sharing"   
    ##  [5] "tv_film"          "sports_fandom"    "politics"         "food"            
    ##  [9] "family"           "home_and_garden"  "music"            "news"            
    ## [13] "online_gaming"    "shopping"         "health_nutrition" "college_uni"     
    ## [17] "sports_playing"   "cooking"          "eco"              "computers"       
    ## [21] "business"         "outdoors"         "crafts"           "automotive"      
    ## [25] "art"              "religion"         "beauty"           "parenting"       
    ## [29] "dating"           "school"           "personal_fitness" "fashion"         
    ## [33] "small_business"

Of these, we don’t find “uncategorized”, “chatter”, “spam”, and “adult”
to be particularly useful in determining the interests of NutrientH20
fans, so we will remove them. Furthermore, we will remove any account
with a number of spam posts greater than 10 as they are likely to be
bots.

## K-means clustering

We will run k-means clustering on the refined data to see if any
interesting groups appear. First let’s look at k-means centers with k=2:

    ##   current_events   travel photo_sharing  tv_film sports_fandom politics
    ## 1       1.592271 1.537066      3.064669 1.099369      1.542587 1.684543
    ## 2       1.513607 1.594194      2.626247 1.064711      1.603871 1.808588
    ##       food    family home_and_garden     music     news online_gaming shopping
    ## 1 2.201104 0.9731861       0.6285489 0.8059937 1.315457      1.220032 1.504732
    ## 2 1.243423 0.8429090       0.5000000 0.6549743 1.184457      1.206683 1.367251
    ##   health_nutrition college_uni sports_playing  cooking       eco computers
    ## 1       11.2358044    1.406151      0.7421136 4.228707 0.8485804 0.6971609
    ## 2        0.9053523    1.576958      0.6194436 1.570608 0.4478379 0.6398549
    ##    business  outdoors    crafts automotive       art religion    beauty
    ## 1 0.4913249 2.2776025 0.6608833  0.7744479 0.8604101 1.144322 0.8651420
    ## 2 0.4101905 0.4960689 0.4880556  0.8404899 0.6988207 1.086030 0.6744784
    ##   parenting    dating    school personal_fitness   fashion
    ## 1 1.0299685 1.0646688 0.8154574        5.6206625 1.3178233
    ## 2 0.9005141 0.6430299 0.7585425        0.6648019 0.9349864

Here we see two main groups. As expected, we have those with a strong
interest in personal fitness and nutrition, and a second group that
represents pretty much everyone else with no clear dominant interests.

Here we add a 3rd cluster:

    ##   current_events   travel photo_sharing  tv_film sports_fandom politics
    ## 1       1.498687 1.587656      2.372127 1.072882      1.610473 1.844058
    ## 2       1.557545 1.491901      2.630009 1.072464      1.523444 1.574595
    ## 3       1.739060 1.735818      6.029173 1.040519      1.565640 1.648298
    ##       food    family home_and_garden     music     news online_gaming shopping
    ## 1 1.249015 0.8368352       0.4893303 0.6152331 1.208142      1.193368 1.328956
    ## 2 2.216539 0.9369139       0.6274510 0.7450980 1.248934      1.199488 1.427962
    ## 3 1.306321 0.9918963       0.6272285 1.1863857 1.097245      1.379254 1.912480
    ##   health_nutrition college_uni sports_playing    cooking       eco computers
    ## 1        0.8890348    1.561720      0.6002955  0.8378201 0.4415627 0.6296783
    ## 2       11.6078431    1.364876      0.7024723  3.1943734 0.8491049 0.6462063
    ## 3        1.9497569    1.779579      0.9027553 11.1815235 0.5705024 0.8460292
    ##    business  outdoors    crafts automotive       art religion    beauty
    ## 1 0.3987196 0.4863756 0.4780039  0.8376559 0.6866382 1.074524 0.4391005
    ## 2 0.4595055 2.3111679 0.6427962  0.7374254 0.8209719 1.115090 0.5319693
    ## 3 0.5964344 0.8022690 0.6482982  0.9286872 0.9189627 1.264182 3.6612642
    ##   parenting    dating    school personal_fitness   fashion
    ## 1 0.8891989 0.6477347 0.7388378         0.648063 0.5845371
    ## 2 1.0017050 1.0511509 0.7681159         5.779199 0.8201194
    ## 3 1.0858995 0.6871961 1.0518639         1.291734 5.4003241

Now a third group emerges. These people are strongly interested in photo
sharing, beauty, cooking, and fashion. They seem to fall in to a common
“influencer” category that are more concerned with the image of health
and nutrition that NutrientH2O provides rather than the nutritional
benefits themselves.

Finally, we add a 4th cluster:

    ##   current_events   travel photo_sharing  tv_film sports_fandom politics
    ## 1       1.759664 1.731092      6.068908 1.042017      1.561345 1.665546
    ## 2       1.497465 1.583668      2.357580 1.050533      1.606400 1.861689
    ## 3       1.571936 1.497336      2.616341 1.048845      1.532860 1.579929
    ## 4       1.468326 1.628959      2.751131 1.418552      1.633484 1.540724
    ##       food    family home_and_garden     music     news online_gaming shopping
    ## 1 1.307563 0.9899160       0.6151261 1.1932773 1.110924     1.0336134 1.929412
    ## 2 1.236055 0.8178003       0.4874978 0.6058752 1.215073     0.5983564 1.332226
    ## 3 2.235346 0.9245115       0.6243339 0.7362345 1.269094     0.9200710 1.420959
    ## 4 1.472851 1.1357466       0.5588235 0.7918552 1.047511    10.0791855 1.321267
    ##   health_nutrition college_uni sports_playing    cooking       eco computers
    ## 1        1.9882353    1.443697      0.8336134 11.2907563 0.5697479 0.8521008
    ## 2        0.9022556    0.963630      0.4775310  0.8307396 0.4409862 0.6277321
    ## 3       11.7238011    1.050622      0.6518650  3.2007105 0.8534636 0.6492007
    ## 4        1.5633484   10.542986      2.4366516  1.5316742 0.4886878 0.6515837
    ##    business  outdoors    crafts automotive       art religion    beauty
    ## 1 0.6000000 0.7983193 0.6537815  0.9310924 0.9092437 1.290756 3.6705882
    ## 2 0.3979717 0.4859241 0.4691380  0.8274174 0.6525616 1.076937 0.4439587
    ## 3 0.4618117 2.3410302 0.6412078  0.7309059 0.7984014 1.106572 0.5328597
    ## 4 0.4140271 0.6312217 0.6153846  0.9773756 1.2239819 1.042986 0.5316742
    ##   parenting    dating    school personal_fitness   fashion
    ## 1 1.0941176 0.6873950 1.0537815        1.2890756 5.4285714
    ## 2 0.8828467 0.6417206 0.7448855        0.6481902 0.5756251
    ## 3 1.0035524 1.0612789 0.7673179        5.8605684 0.8179396
    ## 4 0.9773756 0.7443439 0.6787330        1.0203620 0.9321267

With k=4, a 4th group emerges with common interests in
college/university, online gaming, and tv/film. This shows that
NutrientH2O also appeals to younger people with a more sedentary
lifestyle. Perhaps they simply like it for the taste or the energy it
provides for studying and gaming.

## Conclusion

Three dominant groups of followers of NutrientH2O appear:
nutrition/fitness enthusiasts, social media “influencer” types, and
college gamers. It is thus important to market not only the scientific
nutritional benefits of NutrientH2O, but also the lifestyle image it
provides. For the third group, it might be beneficial to stress the
taste and energy-providing aspects of NutrientH2O
