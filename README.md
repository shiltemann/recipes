# Recipes

Just a place for me to keep track of recipes (mostly my family's)

## Adding Recipes

### Via the web

Log in to [GitHub](https://github.com) and go to the [recipes repository](https://github.com/shiltemann/recipes)


**Add recipe**
Go to `recipes` and click on "New File". Make sure the name is in the format `YYYY-MM-DD-dishname.md`. You can copy the file `2222-01-01-example.md` to get started and just change it for your recipe.

**Upload pictures**
Go to `recipes/images` and click "Upload Files". Upload your photo(s) and remember the name you gave it.


### Via computer

Add image and recipe file in the right place (see previous section)

**Preview the website**

Open the terminal and go to location of the recipes repository

```
cd recipes
```

then start preview by:

```
make preview
```

Open your browser and type `localhost:4000/recipes/` in the address bar

If everything looks good, upload your changes as follows (can also just upload via the browser like described in section above)

```
git add images/recipes/<name-of-your-image-file>
git add _posts/<name-of-your-recipe-file>
git commit -m "added recipe for <blabla>"
git push
```

within about 5 minutes orso you should be able to see your changes come online



## Setup

First-time setup:

**Clone the repository**

Open terminal and go to location where you want to clone the recipes (`cd` to change directory, `pwd` to see where you are now, `cd ../` to go up one directory)

Then clone the repository:

```
git clone https://github.com/shiltemann/recipes recipes
cd recipes
```

Install the dependencies

```
make install
```



## Treat

Based on template: https://github.com/CloudCannon/treat-jekyll-template

Food/baking blog template for Jekyll. Browse through a [live demo](https://spring-bat.cloudvent.net/).

![Treat template screenshot](images/_screenshot.png)

Treat was made by [CloudCannon](http://cloudcannon.com/), the Cloud CMS for Jekyll.
Find more templates and themes at [Jekyll Tips](http://jekyll.tips/templates/).

Learn Jekyll with step-by-step tutorials and videos at [Jekyll Tips](http://jekyll.tips/).




## Develop

Install the dependencies with [Bundler](http://bundler.io/):

~~~bash
$ bundle install
~~~

Run `jekyll` commands through Bundler to ensure you're using the right versions:

~~~bash
$ bundle exec jekyll serve
~~~


## Credits

Based on template: https://github.com/CloudCannon/treat-jekyll-template

Food/baking blog template for Jekyll. Browse through a [live demo](https://spring-bat.cloudvent.net/).

![Treat template screenshot](images/_screenshot.png)

Treat was made by [CloudCannon](http://cloudcannon.com/), the Cloud CMS for Jekyll.
Find more templates and themes at [Jekyll Tips](http://jekyll.tips/templates/).

Learn Jekyll with step-by-step tutorials and videos at [Jekyll Tips](http://jekyll.tips/).

