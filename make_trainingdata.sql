-- !preview conn=DBI::dbConnect(RSQLite::SQLite())

CREATE TABLE and_paperid(
id text
);

\copy and_paperid FROM '~/openalex_disam/paperID.csv' HEADER CSV DELIMITER ',';

CREATE INDEX and_paperid_id ON and_paperid (id);
CREATE TABLE and_paper_journal_1 AS SELECT source_id, id FROM and_paperid a JOIN works_locations b ON a.id = b.work_id;
CREATE INDEX and_paper_journal_1_source_id ON and_paper_journal_1 (source_id);
CREATE TABLE and_paper_journal AS SELECT a.source_id,a.id,b.display_name AS journal, b.issn FROM and_paper_journal_1 a JOIN sources b ON a.source_id = b.id;
CREATE TABLE and_paper_title_year AS SELECT a.id, a.title, a.publication_year FROM works a JOIN and_paperid b ON a.id = b.id;
CREATE TABLE and_paper_abstract AS SELECT a.id, a.abstract_inverted_index FROM works a JOIN and_paperid b ON a.id = b.id;
CREATE TABLE and_paper_grants AS SELECT a.* FROM works_grants a INNER JOIN and_paperid b ON a.work_id = b.id;
CREATE TABLE and_paper_keywords AS SELECT a.* FROM works_keywords a INNER JOIN and_paperid b ON a.work_id = b.id;

# \COPY (select json_agg(row_to_json(and_paper_abstract)) from and_paper_abstract) TO '~/openalex_disam/and_paper_abstract.csv';
\copy and_paper_grants TO '~/openalex_disam/and_paper_grants.csv' HEADER CSV DELIMITER ',';
\copy and_paper_keywords TO '~/openalex_disam/and_paper_keywords.csv' HEADER CSV DELIMITER ',';
\copy and_paper_journal TO '~/openalex_disam/and_paper_journal.csv' HEADER CSV DELIMITER ',';
\copy and_paper_title_year TO '~/openalex_disam/and_paper_title_year.csv' HEADER CSV DELIMITER ',';