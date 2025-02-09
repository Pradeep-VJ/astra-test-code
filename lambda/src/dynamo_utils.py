import boto3

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table("JobApplications")

def get_new_jobs(student_name):
    response = table.scan(FilterExpression="student = :s AND status = :n",
                          ExpressionAttributeValues={":s": student_name, ":n": "NEW"})
    return response["Items"]

def update_job_status(job_id, status):
    table.update_item(
        Key={"job_id": job_id},
        UpdateExpression="SET status = :s",
        ExpressionAttributeValues={":s": status}
    )
