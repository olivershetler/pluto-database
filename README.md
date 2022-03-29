# README

This repository contains sql scripts for constructing a spatio-temporal modeling oriented database from real estate data sets provided by the NYC Department of Planning, called PLUTO. If you would like to access pre-made copies of the data sets I used for building spatio-temporal models, you can find them on [my Kaggle page](https://www.kaggle.com/olivershetler/pluto)

The original raw data sets are available at the [PLUTO webpage](https://www1.nyc.gov/site/planning/data-maps/open-data/dwn-pluto-mappluto.page). The scripts are inside the `sql` folder of this repository.

Some of the raw data sets contain non UTF characters, which can cause import errors in Postgres and other database systems. I had to remove these characters using regular-expressions before importing. As far as I can tell, all the problematic characters were non-printing characters from old database export systems, and removing them did not affect the integrity of the data. If you'd like to access these pre-cleaned files, please reach out to me on [LinkedIn](https://www.linkedin.com/in/olivershetler/). They aren't currently hosted anywhere, but I'd be glad to send them to you!

If you'd like to build your own version of this PLUTO database, please read [the article](./guides/article.pdf) and [the script guide](./guides/scripts.md) for details about the data engineering I've done. You can easily re-construct an exact replica of the database by running the scripts in the `sql` folder in the Postgres command line interface. **Note that you will have to use find and replace to modify the path to the data files in the first script.** For basic documentation on table fields and keys, take a look at the guide to the database [tables](./guides/tables.md).

## A Note to Commercial Users

I licensed this database so that it would be amenable to most commercial uses. If you'd like help using this database to add value to your business, please reach out! I love to see when people succeed in their businesses, as all boats rise together.

The easiest way to reach me is to message me on [LinkedIn](https://www.linkedin/in/olivershetler.com).

## A Note to Academic Authors

If you'd like to cite this repository, there is a Zenodo-driven DOI for the database in the sidebar.

If you have any questions, please reach out to me on [LinkedIn](https://www.linkedin/in/olivershetler.com).

## A Note to Any Potential Contributors

If you would like to elaborate on this project for any reason, I would love to hear from you! Please feel free to contact me with questions or to discuss the possibility of adding or branching your work to this repository.

Here are links to a few data-sets that might fruitfully be combined with PLUTO in the future.

### Cooperative/Condominium Comparables
Link: https://www1.nyc.gov/site/finance/taxes/property-cooperative-and-condominium-comparables.page

This data set shows how the market value of co-ops and condos is computed using the income-based valuations of nearby rental buildings. The data set contains the actual reported rental income for some buildings.

### Side-walk Cafes
Sidewalk cafe license data are available at https://data.cityofnewyork.us/Business/Sidewalk-Caf-Licenses-and-Applications/qcdj-rwhu and at

This data set contains a comprehensive list of the locations and licensing dates of sidewalk cafes. The number of sidewalk cafes is considered to be a good indicator of neighborhood gentrification. For this reason, these data will be incorporated into the final data set for modeling.

### Rodent Inspection
The rodent inspection data-set is available at https://data.cityofnewyork.us/Health/Rodent-Inspection/p937-wjvj

This data-set gives rodent infestation data, which may help predict apartment value and quality. Additionally, users might find it useful.

## Acknowledgements

Thanks to Iordan Slavov for supervising an academic project that related to the consruction of this database. Thanks to Ariel Avshalom for teaching me the skills to build this database using Postgresql. Special thanks to my wife, Divya Singh Shetler, for suggesting that the PLUTO data were in need of re-engineering.