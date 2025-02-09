#!/bin/bash
set -e

echo "🔧 Installing dependencies..."
pip install -r src/requirements.txt -t package

echo "📦 Creating Lambda package..."
cd package
zip -r9 ../lambda_package.zip .

cd ..
zip -g lambda_package.zip src/apply_jobs.py src/dynamo_utils.py src/playwright_helpers.py src/config.py

echo "✅ Lambda package built successfully: lambda_package.zip"
