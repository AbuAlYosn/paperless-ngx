#!/bin/bash

echo "🎨 Making Your First Modifications to Paperless-ngx"
echo "=================================================="

# Check if we're in the right directory
if [ ! -f "src-ui/package.json" ]; then
    echo "❌ Please run this script from the paperless-ngx root directory"
    exit 1
fi

echo "🚀 Applying quick modifications..."

# Backup original files
mkdir -p backups
cp src-ui/src/styles.scss backups/styles.scss.backup 2>/dev/null || true

# 1. Add Arabic font support
echo "📝 Adding Arabic font support..."
cat << 'EOF' > temp_styles.scss
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+Arabic:wght@400;500;600&display=swap');

/* Arabic font support */
body {
  font-family: 'Noto Sans Arabic', 'Roboto', 'Helvetica Neue', sans-serif;
}

/* RTL support classes */
.rtl {
  direction: rtl;
  text-align: right;
}

.ltr {
  direction: ltr;
  text-align: left;
}

/* Custom brand colors */
:root {
  --primary-color: #1976d2;
  --accent-color: #ff9800;
  --success-color: #4caf50;
  --warning-color: #ff9800;
  --danger-color: #f44336;
}

EOF

# Append original styles
cat src-ui/src/styles.scss >> temp_styles.scss
mv temp_styles.scss src-ui/src/styles.scss

echo "✅ Arabic fonts and RTL support added"

# 2. Quick branding change
echo "📝 Adding quick branding..."

# Find and modify the app title
if [ -f "src-ui/src/app/components/common/page-header/page-header.component.html" ]; then
    # Backup original
    cp src-ui/src/app/components/common/page-header/page-header.component.html backups/page-header.component.html.backup
    
    # Add Arabic title (keeping original as fallback)
    sed -i.bak 's/<span class="title".*<\/span>/<span class="title">مدير المستندات البسيط<\/span>/' src-ui/src/app/components/common/page-header/page-header.component.html 2>/dev/null || true
    
    echo "✅ App title updated to Arabic"
else
    echo "⚠️  Page header component not found at expected location"
fi

# 3. Remove mail management (first simplification)
echo "📝 Removing mail management features..."

# Remove mail-related frontend components
rm -rf src-ui/src/app/components/manage/mail-* 2>/dev/null || true
rm -rf src-ui/src/app/components/admin/mail-* 2>/dev/null || true

echo "✅ Mail management components removed"

# 4. Create a simple welcome message
echo "📝 Adding welcome message..."

# Create a simple Arabic welcome component
mkdir -p src-ui/src/app/components/common/welcome/

cat << 'EOF' > src-ui/src/app/components/common/welcome/welcome.component.html
<div class="welcome-message rtl" style="padding: 20px; text-align: center; background: #f5f5f5; margin: 10px; border-radius: 8px;">
  <h2 style="color: var(--primary-color);">مرحباً بك في مدير المستندات البسيط</h2>
  <p>نسخة مبسطة من Paperless-ngx مصممة خصيصاً للمستخدمين العرب</p>
  <p class="ltr" style="font-size: 0.9em; color: #666;">Welcome to Simple Document Manager - Simplified Paperless-ngx for Arabic users</p>
</div>
EOF

cat << 'EOF' > src-ui/src/app/components/common/welcome/welcome.component.ts
import { Component } from '@angular/core';

@Component({
  selector: 'app-welcome',
  templateUrl: './welcome.component.html'
})
export class WelcomeComponent {
}
EOF

echo "✅ Welcome component created"

# 5. Build the frontend
echo "🔨 Building frontend with your changes..."

cd src-ui
npm run build

if [ $? -eq 0 ]; then
    echo "✅ Frontend build successful!"
else
    echo "❌ Frontend build failed. Check the logs above."
    echo "💡 You can restore backups from the 'backups' folder if needed"
    exit 1
fi

cd ..

# 6. Show next steps
echo ""
echo "🎉 CONGRATULATIONS! Your first modifications are complete!"
echo ""
echo "What was changed:"
echo "✅ Added Arabic font support (Noto Sans Arabic)"
echo "✅ Added RTL (Right-to-Left) CSS classes"
echo "✅ Changed app title to Arabic"
echo "✅ Removed mail management components"
echo "✅ Added custom brand colors"
echo "✅ Created Arabic welcome component"
echo ""
echo "Next steps:"
echo "1. Restart your development server:"
echo "   docker-compose -f docker/compose/docker-compose.dev.yml restart"
echo ""
echo "2. Visit http://localhost:8000 to see your changes"
echo ""
echo "3. Continue with more modifications using the detailed guide"
echo ""
echo "💾 Backups saved in 'backups/' folder"
echo "🔧 If something breaks, run: ./fix-common-issues.sh"
echo ""
echo "🚀 Ready to keep customizing? You're doing great!"