#!/bin/bash

echo "🔧 Installing dependencies..."
pip install -r src/requirements.txt -t package/

echo "📦 Creating deployment package..."
cd package || exit 1
zip -r ../lambda_package.zip .
cd ..

zip -g lambda_package.zip src/apply_jobs.py
zip -g lambda_package.zip src/dynamo_utils.py
zip -g lambda_package.zip src/playwright_helpers.py
zip -g lambda_package.zip src/config.py

echo "✅ Lambda package built successfully: lambda_package.zip"
