import urllib
import pandas as pd
import os

def lambda_handler(event, context):
    print('Processing Started')
    target_bucket_name = os.environ.get('TGT_BUCKET_NAME')
    for rec in event['Records']:
        bucket_name = rec['s3']['bucket']['name']
        object_key = urllib.parse.unquote(rec['s3']['object']['key'])

        df = pd.read_json(
            f's3://{bucket_name}/{object_key}',
            lines=True
        )

        df['year'] = df['date'].apply(lambda dt: str(dt)[:4])
        df['month'] = df['date'].apply(lambda dt: str(dt)[5:7])
        df['dayofmonth'] = df['date'].apply(lambda dt: str(dt)[8:10])
        df_grouped = df.groupby(['year', 'month', 'dayofmonth'])
        orig_file_name = object_key.split('/')[-1].split('.')[0]
        for key in df_grouped.groups.keys():
            df_by_key = df_grouped.get_group(key).drop(labels=['year', 'month', 'dayofmonth'], axis=1)
            year = list(key)[0]
            month = list(key)[1]
            dayofmonth = list(key)[2]
            file_name = f'{orig_file_name}.snappy.parquet'
            df_by_key.to_parquet(f's3://{target_bucket_name}/silver/retail_logs/year={year}/month={month}/dayofmonth={dayofmonth}/{file_name}')
        print(f'{df.shape[0]} records in s3://{target_bucket_name}/{object_key} are converted to Parquet Format')
    print('Processing is successfully done')
    return {
        'statusCode': 200,
        'statusMessage': f'Successfully processed!!!'
    }