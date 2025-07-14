# openalex_and
This is a project to validate and improve author-name disambiguation algorithm.

First, constructing training dataset。 Keep scientists with complete publication lists.

| file name      | note                                           |
|-----------------------|-----------------------|
|gt_name.csv | scientists' name of the groundtruch(gt) dataset|
|gt_source.csv|the source the gt dataset|
|gt_paper.csv|the meta data of the gt papers|


id_panel: ID-Name-altername-startyear-endyear
 

Second, features

| Feature   Groups      | Features                                           |
|-----------------------|---------------------------------------------------|
| Name                  | last name match                                   |
|                       | middle initial match                              |
|                       | First name match                                  |
|                       | Name compatibility                                |
|                       | IDF of author's last name ？                       |
|                       | similarity between author’s middle name           |
|                       | Jaro-Winkler distance used on first author’s name |
|                       | alternate   names                                 |
| Coauthors             | coauthor names                                    |
| Affiliation           | affiliation                                       |
|                       | organisation                                      |
|                       | type and descriptor of the organisation           |
|                       | country                                           |
|                       | city                                              |
|                       | location                                          |
|                       | email                                             |
|                       | type and descriptor of organisation               |
| Article information   | journal name match                                |
|                       | difference in publication years                   |
|                       | grant                                             |
|                       | substance                                         |
|                       | language                                          |
| Technological content | title                                             |
|                       | MeSH terms                                        |
|                       | abstract                                          |
|                       | keyphrases                                        |

Third, data files are in 'openalex_disam'

paperID.csv

au_affs.csv

cddt_paper.csv

and_paper_journal.csv

and_paper_title_year.csv

and_paper_grants.csv

and_paper_keywords.csv




| column    | Note                                        |
|-----------------------|---------------------------------------------------|
|work_id| paperID|
|author_position||
|author_id|author id of openalex|
|raw_author_name|author name|
|is_corresponding||
|affiliation_id||
|raw_affiliation_string||
|institution_ids||
|source_id|id of journals|
|id in "and_paper_journal.csv"|work_id|
|display_name|journal name|
|issn||
|id in 'and_paper_title_year.csv'|work_id|
|title|title of the paper|
|publication_year||

## disam steps

1. construct the relationship between gt and openalex;

- link paperIDs
- limit the journals to ssci/sci journals as our gt data is obtained from web of science journals;
	- using the alex_wos_journal_year.csv file to limit journals;
- limit the publication year to years before 2019;

2. contructs pairs and features

3. train the classification model

4. train the clustering model


