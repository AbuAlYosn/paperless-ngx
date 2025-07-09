# Simplifying Paperless-ngx: A Step-by-Step Guide

## Overview
This guide will help you fork paperless-ngx and create a simplified, Arabic-supported version that can be packaged as a desktop application.

## Phase 1: Fork and Setup (Week 1)

### 1. Fork the Repository
```bash
# Fork paperless-ngx on GitHub first, then clone your fork
git clone https://github.com/YOUR-USERNAME/paperless-ngx.git
cd paperless-ngx
git remote add upstream https://github.com/paperless-ngx/paperless-ngx.git
```

### 2. Set Up Development Environment
```bash
# Install Docker and Docker Compose
# Follow the development setup from paperless-ngx docs
docker-compose -f docker/compose/docker-compose.dev.yml up -d
```

## Phase 2: Simplification (Week 2-3)

### 3. Remove Complex Features

#### A. Remove Machine Learning Features
```bash
# Remove ML-related files
rm -rf src/paperless/classification.py
rm -rf src/paperless/matching.py
rm -rf src/paperless_ml/
```

#### B. Simplify Admin Interface
Edit `src/documents/admin.py`:
- Remove complex filters
- Keep only basic document, tag, and correspondent management

#### C. Remove Advanced Consumer Features
Edit `src/paperless_consumer/`:
- Remove email consumption
- Remove advanced OCR options
- Keep only basic file watching

### 4. Simplify Frontend (Angular)

#### A. Remove Complex UI Components
```bash
cd src-ui/src/app/components/
# Remove or simplify:
rm -rf dashboard/statistics-widget/
rm -rf manage/mail-*
rm -rf admin/logs/
```

#### B. Simplify Navigation
Edit `src-ui/src/app/components/common/page-header/page-header.component.html`:
- Remove advanced menus
- Keep: Documents, Tags, Correspondents, Settings

#### C. Basic Document List Only
Edit `src-ui/src/app/components/document-list/`:
- Remove advanced filtering
- Keep basic search and view

## Phase 3: Arabic Translation & RTL Support (Week 3-4)

### 5. Add Arabic Language Support

#### A. Add Arabic Translation Files
```bash
cd src-ui/
# Add Arabic locale
ng add @angular/localize
```

Create `src-ui/src/locale/messages.ar.xlf`:
```xml
<?xml version="1.0" encoding="UTF-8" ?>
<xliff version="1.2" xmlns="urn:oasis:names:tc:xliff:document:1.2">
  <file source-language="en" target-language="ar" datatype="plaintext">
    <body>
      <trans-unit id="documents" datatype="html">
        <source>Documents</source>
        <target>المستندات</target>
      </trans-unit>
      <trans-unit id="search" datatype="html">
        <source>Search</source>
        <target>بحث</target>
      </trans-unit>
      <!-- Add more translations -->
    </body>
  </file>
</xliff>
```

#### B. Configure RTL Support
Edit `src-ui/src/app/app.component.ts`:
```typescript
import { Direction } from '@angular/cdk/bidi';

export class AppComponent {
  direction: Direction = 'rtl'; // For Arabic
  
  constructor() {
    // Set document direction
    document.dir = 'rtl';
  }
}
```

Edit `src-ui/src/styles.scss`:
```scss
// Add RTL support
[dir="rtl"] {
  .container {
    text-align: right;
  }
  
  .sidebar {
    right: 0;
    left: auto;
  }
}

// Arabic font support
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+Arabic:wght@400;500;600&display=swap');

body {
  font-family: 'Noto Sans Arabic', sans-serif;
}
```

### 6. Simplify Backend API

#### A. Remove Complex Endpoints
Edit `src/documents/views.py`:
- Keep only basic CRUD operations
- Remove ML prediction endpoints
- Remove advanced filtering

#### B. Simplify Models
Edit `src/documents/models.py`:
- Remove advanced fields you don't need
- Keep: title, content, tags, correspondent, created, modified

## Phase 4: Rebranding (Week 4)

### 7. Rebrand the Application

#### A. Change App Name
Edit `src-ui/src/app/components/common/page-header/page-header.component.html`:
```html
<h1>مدير المستندات البسيط</h1> <!-- Simple Document Manager -->
```

#### B. Update Configuration
Edit `src/paperless/settings.py`:
```python
PAPERLESS_APP_TITLE = "Simple Document Manager"
PAPERLESS_APP_LOGO = "path/to/your/logo.png"
```

#### C. Custom Styling
Edit `src-ui/src/styles.scss`:
```scss
:root {
  --primary-color: #your-brand-color;
  --secondary-color: #your-secondary-color;
}
```

## Phase 5: Desktop Packaging (Week 5)

### 8. Package as Desktop App using Electron

#### A. Install Electron Dependencies
```bash
npm install -g electron electron-builder
```

#### B. Create Electron Wrapper
Create `electron/main.js`:
```javascript
const { app, BrowserWindow } = require('electron');
const path = require('path');
const { spawn } = require('child_process');

let mainWindow;
let backendProcess;

function createWindow() {
  mainWindow = new BrowserWindow({
    width: 1200,
    height: 800,
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true
    },
    icon: path.join(__dirname, 'assets/icon.png')
  });

  // Start Django backend
  backendProcess = spawn('python', ['manage.py', 'runserver', '8000'], {
    cwd: path.join(__dirname, '../')
  });

  // Load the app
  setTimeout(() => {
    mainWindow.loadURL('http://localhost:8000');
  }, 3000);
}

app.whenReady().then(createWindow);

app.on('before-quit', () => {
  if (backendProcess) {
    backendProcess.kill();
  }
});
```

#### C. Package Configuration
Create `electron/package.json`:
```json
{
  "name": "simple-document-manager",
  "version": "1.0.0",
  "main": "main.js",
  "scripts": {
    "start": "electron .",
    "build": "electron-builder",
    "build-win": "electron-builder --win"
  },
  "build": {
    "appId": "com.yourname.simpledocmanager",
    "productName": "Simple Document Manager",
    "directories": {
      "output": "dist"
    },
    "files": [
      "**/*",
      "!node_modules",
      "../src/**/*",
      "../requirements.txt"
    ],
    "win": {
      "target": "nsis",
      "icon": "assets/icon.ico"
    }
  }
}
```

### 9. Create Build Script
Create `build.py`:
```python
#!/usr/bin/env python3
import subprocess
import os
import shutil

def build_app():
    print("Building simplified paperless-ngx...")
    
    # Build frontend
    os.chdir('src-ui')
    subprocess.run(['npm', 'run', 'build'])
    os.chdir('..')
    
    # Collect static files
    subprocess.run(['python', 'manage.py', 'collectstatic', '--noinput'])
    
    # Build Electron app
    os.chdir('electron')
    subprocess.run(['npm', 'run', 'build-win'])
    
    print("Build complete! Check electron/dist/ for your .exe installer")

if __name__ == "__main__":
    build_app()
```

## Phase 6: Final Touches (Week 6)

### 10. Create USB-Ready Package
```bash
# After building, create portable version
mkdir SimpleDocManager_Portable
cp -r electron/dist/win-unpacked/* SimpleDocManager_Portable/
echo "[AutoRun]" > SimpleDocManager_Portable/autorun.inf
echo "open=SimpleDocManager.exe" >> SimpleDocManager_Portable/autorun.inf
```

### 11. Testing & Deployment
- Test on clean Windows machines
- Create user documentation in Arabic
- Package everything for USB distribution

## Key Files to Modify

### High Priority:
1. `src-ui/src/app/` - Frontend simplification
2. `src/documents/models.py` - Data model simplification  
3. `src/paperless/settings.py` - Configuration
4. `src-ui/src/locale/` - Arabic translations

### Medium Priority:
1. `src/documents/views.py` - API simplification
2. `src/paperless_consumer/` - File processing
3. `electron/` - Desktop packaging

## Benefits of This Approach

✅ **Proven Foundation**: Built on battle-tested paperless-ngx
✅ **Feature Rich**: Keep the good stuff, remove complexity
✅ **Professional**: Maintains code quality and architecture
✅ **Updatable**: Can merge important security updates from upstream
✅ **Customizable**: Easy to add your specific requirements

## Next Steps

1. Start with Phase 1 (fork and setup)
2. Run the development environment to understand the codebase
3. Begin systematic simplification
4. Test each phase before moving to the next

This approach gives you a professional document management system tailored to your users' needs while leveraging the solid foundation of paperless-ngx.