import json
import boto3
import time
from playwright.sync_api import sync_playwright
from dynamo_utils import update_job_status, get_new_jobs

def apply_for_job(page, job_url, candidate, job_id):
    print(f"Applying for {job_url} as {candidate['name']}...")
    page.goto(job_url)
    page.fill('input[name="first_name"]', candidate["name"].split()[0])
    page.fill('input[name="last_name"]', candidate["name"].split()[1])
    page.fill('input[name="email"]', candidate["email"])
    page.fill('input[name="phone"]', candidate["phone"])

    page.click('button[type="submit"]')

    try:
        page.wait_for_selector('.application-submitted', timeout=5000)
        print(f"✅ Successfully applied for {job_url} as {candidate['name']}")
        return True
    except:
        print(f"⚠️ Submission failed for {job_url} as {candidate['name']}")
        return False

def lambda_handler(event, context):
    student_name = event["student_name"]
    candidate = json.load(open("candidate_profiles/sample_candidates.json"))[0]

    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        page = browser.new_page()

        jobs = get_new_jobs(student_name)
        for job in jobs[:10]:
            success = apply_for_job(page, job["job_url"], candidate, job["job_id"])
            update_job_status(job["job_id"], "APPLIED" if success else "FAILED")

        browser.close()

    return {"status": "Completed"}
