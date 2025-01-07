# openalex_and
This is a project to validate and improve author-name disambiguation algorithm.

First, constructing training dataset。 Keep scientists with complete publication lists.

| file name      | note                                           |
|-----------------------|-----------------------|
|gt_name.csv | scientists' name of the groundtruch(gt) dataset|
|gt_source.csv| the source the gt dataset|z


- Scientists: ID-Name-altername-startyear-endyear
- 

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

Third, data files