#!/bin/bash

echo "🚀 Setting up Simplified Paperless-ngx"
echo "======================================="

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is required. Please install git first."
    exit 1
fi

# Get user's GitHub username
read -p "Enter your GitHub username: " GITHUB_USERNAME

# Clone paperless-ngx
echo "📥 Cloning paperless-ngx..."
git clone https://github.com/paperless-ngx/paperless-ngx.git simple-document-manager
cd simple-document-manager

# Add your fork as origin (user will need to create fork manually)
echo "🔗 Setting up git remotes..."
git remote rename origin upstream
echo "⚠️  Please create a fork of paperless-ngx on GitHub first!"
echo "📝 Then run: git remote add origin https://github.com/$GITHUB_USERNAME/paperless-ngx.git"

# Create initial simplification branch
git checkout -b simplified-version

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Create a fork of paperless-ngx on GitHub"
echo "2. Run: git remote add origin https://github.com/$GITHUB_USERNAME/paperless-ngx.git"
echo "3. Follow the guide in paperless-ngx-simplification-guide.md"
echo "4. Start with setting up the development environment"
echo ""
echo "Development environment setup:"
echo "docker-compose -f docker/compose/docker-compose.dev.yml up -d"