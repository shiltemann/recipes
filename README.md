# Recipes

Just a place for me to keep track of recipes (mostly my family's)

Sisters, instructions about how to add recipes: [here](INSTRUCTIONS.md)

## Adding Recipes

- Recipe files in `recipes`
- File naming scheme: `YYYY-MM-DD-dishname.md`
- Example recipe in: `recipes/2222-01-01-example.md`
- Images in `recipes/images`

## Setup

First-time setup:

Open terminal and go to location where you want to clone the recipes

Then clone the repository:

```
git clone https://github.com/shiltemann/recipes recipes
cd recipes
```

Make website preview:

```
make preview
```

If that doesn't work, you may have to install the dependencies:

```
make install
```

#### Handy linux commands

```
ls  = list files in current directory
pwd = check which directory we are in (print working directory)
cd  = change directory

git status -> zie welke files veranderd zijn
git diff <filenaam> -> zie precieze veranderingen in de file
git checkout <filenaam> -> gooi alle veranderingen van file weg
```


## Credits

Based on template: https://github.com/CloudCannon/treat-jekyll-template

Food/baking blog template for Jekyll. Browse through a [live demo](https://spring-bat.cloudvent.net/).

![Treat template screenshot](images/_screenshot.png)

Treat was made by [CloudCannon](http://cloudcannon.com/), the Cloud CMS for Jekyll.
Find more templates and themes at [Jekyll Tips](http://jekyll.tips/templates/).

Learn Jekyll with step-by-step tutorials and videos at [Jekyll Tips](http://jekyll.tips/).
