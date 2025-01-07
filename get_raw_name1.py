import csv
import glob
import gzip
import json
import os

SNAPSHOT_DIR = '/volumes/lacie/metoo/openalex-snapshot-20240417'
CSV_DIR = '/volumes/lacie/metoo/csv-files/author_raw_names1'


if not os.path.exists(CSV_DIR):
    os.mkdir(CSV_DIR)

FILES_PER_ENTITY = int(os.environ.get('OPENALEX_DEMO_FILES_PER_ENTITY', '0'))

csv_files = {
    'works': {
        'authorships': {
            'name': os.path.join(CSV_DIR, 'works_authorships.csv.gz'),
            'columns': [
                'work_id', 'author_position', 'author_id', 'institution_id',
                'raw_author_name','is_corresponding'
            ]
        },
    },
}

def flatten_works():
    file_spec = csv_files['works']

    with gzip.open(file_spec['authorships']['name'], 'wt',
                      encoding='utf-8') as authorships_csv:
        authorships_writer = init_dict_writer(authorships_csv,file_spec['authorships'])

        files_done = 0
        for jsonl_file_name in glob.glob(
                os.path.join(SNAPSHOT_DIR, 'data', 'works', 'works1', '*', '*.gz')):
            print(jsonl_file_name)
            with gzip.open(jsonl_file_name, 'r') as works_jsonl:
                for work_json in works_jsonl:
                    if not work_json.strip():
                        continue

                    work = json.loads(work_json)

                    if not (work_id := work.get('id')):
                        continue
         
                    # authorships
                    if authorships := work.get('authorships'):
                        for authorship in authorships:
                            if author_id := authorship.get('author', {}).get(
                                    'id'):
                                institutions = authorship.get('institutions')
                                institution_ids = [i.get('id') for i in
                                                   institutions]
                                institution_ids = [i for i in institution_ids if
                                                   i]
                                institution_ids = institution_ids or [None]

                                for institution_id in institution_ids:
                                    authorships_writer.writerow({
                                        'work_id': work_id,
                                        'author_position': authorship.get(
                                            'author_position'),
                                        'author_id': author_id,
                                        'institution_id': institution_id,
                                        'raw_author_name': authorship.get(
                                            'raw_author_name'),
                                        'is_corresponding': authorship.get(
                                            'is_corresponding'),
                                    })

            files_done += 1
            if FILES_PER_ENTITY and files_done >= FILES_PER_ENTITY:
                break


def init_dict_writer(csv_file, file_spec, **kwargs):
    writer = csv.DictWriter(
        csv_file, fieldnames=file_spec['columns'], **kwargs
    )
    writer.writeheader()
    return writer


if __name__ == '__main__':
    flatten_works()
