#!/bin/bash
set -e

cd "$(dirname "$0")"

# Create a package directory
rm -rf package
mkdir package

# Install dependencies
pip install -r requirements.txt -t package/

# Copy function code
cp apply_jobs.py package/

# Zip package
cd package
zip -r9 ../lambda_package.zip .
cd ..
echo "Lambda package created: lambda_package.zip"
