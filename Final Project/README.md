## Data-Visualization(Yelp Business Data)##
 Mingyun Guan(mg3419)

##Ideas about the Project##
Initially, I was intend to do some visualization using [steam](http://store.steampowered.com/) data. I spent some time with the data extraction using steam API. but mainly because that I am unfamiliar with python and other tools, I couldn't get the data that I was satisfied with until the deadline was near. So I decided to change the subject
 immediately and keep on going with the steam data during the  summer holiday.

The data that I used is from [Yelp Dataset Challenge](http://www.yelp.com/dataset_challenge/). It contains generous sample of yelp data from the greater Phoenix, AZ metropolitan area including 15,585 businesses. I used the business data they offered to do some visualizations that I thought would be fun.


## Data Munging ##

The original data is a json file and business is the first part of data they offered. The format is showed below. 

    business
    {
    'type': 'business',
    'business_id': (encrypted business id),
    'name': (business name),
    'neighborhoods': [(hood names)],
    'full_address': (localized address),
    'city': (city),
    'state': (state),
    'latitude': latitude,
    'longitude': longitude,
    'stars': (star rating, rounded to half-stars),
    'review_count': review count,
    'categories': [(localized category names)]
    'open': True / False (corresponds to closed, not business hours),
    'hours': {
        (day_of_week): {
            'open': (HH:MM),
            'close': (HH:MM)
        },
        ...
    },
    'attributes': {
        (attribute_name): (attribute_value),
        ...
    },
    }

I extracted the business part from the full dataset and then used RJSONIO package to import the data into R. I used R to do the data cleaning work. Using R to clean json file is quite annoying, because after being imported to R, it is always a list of lists of lists. At last I converted the business data into a data frame that is easy to analyze. I only focused on restaurants this time, so I extract the samples with the word "Restaurants" as one of their category tags.

##Restaurant Categories##
**Analyze the frequency of restaurant categories:** 

 It is interesting to see how many businesses are opened for each category. So we calculate the frequency of each tag in the category and generate a word cloud to have a rough idea about it. We can see that there are more  "Mexican","Sandwiches","Fast Food" and "Sandwiches" restaurants in Phoenix, AZ.

![word cloud](https://github.com/guangoku/Data-Visualization/blob/master/Final%20Project/wordcloud.png?raw=true)

**Analyze the Relationships between categories**
The categories are not only decided by cuisine. There are also tags like "Bars" and  "Nightlife". I think it will be interesting to see which two categories are more likely to occur together in one restaurant. Chord Diagram is a nice choice to present these kind of information.

The shortcut of the chord diagram is showed below. [**The original interactive chord-plot**](http://guangoku.github.io/chord-diagram.html)
![chord-diagram-shortcut](https://github.com/guangoku/Data-Visualization/blob/master/Final%20Project/chord%20diagram.shortcut.PNG?raw=true)
We can see that the top 3 most popular combinations of a restaurant are Mexican&Fast Food, Sandwiches&Pizza and American&Fast Food.

The biggest problem for me here is the calculation of the matrix used by chord diagram. It is simple to calculate a 5*5 matrix, but if I want to compare between more groups, for example, 20 groups, The categories of each sample would contain several words (not just 2). I still didn't figure out what to do in this case. 
##Mapping of Restaurants##

(At this time, I realized that the data set that I used is exactly the same with Jiun. So I decided to make something different with her works.) 
I generated several maps of Phoenix City to see the geographic distribution of the restaurants.First is the overall map. Although I am not familiar with Phoenix, I could know that the center of the city might be the area with more restaurants.
![map1-total](https://github.com/guangoku/Data-Visualization/blob/master/Final%20Project/map1-total.png?raw=true)
Then I divided the samples by different groups to see whether we can find something interesting. The map divided by rating stars of each restaurant.
![map2-stars](https://github.com/guangoku/Data-Visualization/blob/master/Final%20Project/map2-stars.png?raw=true)
Divided by Price Range:
![map3-price-range](https://github.com/guangoku/Data-Visualization/blob/master/Final%20Project/map3-pricerange.png?raw=true)
Divided by Alcohol:
![map4-alcohol](https://github.com/guangoku/Data-Visualization/blob/master/Final%20Project/map4-bar.png?raw=true)

We can see that the city center seems to have more expensive and high-rating restaurants, while the geographic distribution seems to have nothing to do with whether they offer alcohol or not.
##Future Work##
Chord Diagram with any number of groups;  More detailed interactive maps; Analyze the review data.