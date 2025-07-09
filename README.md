# 🚀 Simple Document Manager
### Your Simplified, Arabic-Enabled Paperless-ngx

This guide helps you fork and customize paperless-ngx to create a lightweight, Arabic-supported document management system that can be packaged as a desktop .exe application.

## 🎯 What You'll Get

- ✅ **Simplified UI** - Remove complex features your users don't need
- ✅ **Arabic Support** - Full RTL language support with proper fonts
- ✅ **Desktop App** - Package as standalone .exe for USB distribution
- ✅ **Your Branding** - Custom colors, logos, and styling
- ✅ **Proven Foundation** - Built on battle-tested paperless-ngx

## 🚀 Quick Start (30 minutes)

### 1. Fork & Setup
```bash
# 1. Go to https://github.com/paperless-ngx/paperless-ngx and click "Fork"
# 2. Clone your fork:
git clone https://github.com/YOUR-USERNAME/paperless-ngx.git simple-doc-manager
cd simple-doc-manager
git remote add upstream https://github.com/paperless-ngx/paperless-ngx.git
git checkout -b simplified-version
```

### 2. Get It Running
```bash
# Install Docker Desktop first: https://www.docker.com/products/docker-desktop/
# Then start the development environment:
docker-compose -f docker/compose/docker-compose.dev.yml up -d

# Wait 3-5 minutes, then visit: http://localhost:8000
# Login: admin / admin
```

### 3. Apply Your First Modifications
```bash
# Run the auto-modification script:
./first-modifications.sh

# Restart to see changes:
docker-compose -f docker/compose/docker-compose.dev.yml restart
```

## 🛠️ Helper Scripts

| Script | Purpose |
|--------|---------|
| `./first-modifications.sh` | Apply Arabic fonts, branding, and remove complex features |
| `./fix-common-issues.sh` | Troubleshoot Docker, build, and development issues |
| `./quick-start.sh` | Set up initial fork and git remotes |

## 📁 What Gets Modified

### Simplified Features (Removed)
- ❌ Machine learning and auto-classification
- ❌ Email consumption and rules
- ❌ Advanced admin interfaces
- ❌ Complex filtering and workflows
- ❌ Advanced OCR settings
- ❌ Multi-user management

### Core Features (Kept)
- ✅ Document upload and viewing
- ✅ Basic OCR text recognition
- ✅ Search functionality
- ✅ Tags and organization
- ✅ PDF and image support
- ✅ File watching for auto-import

### New Features (Added)
- 🌟 Arabic language interface
- 🌟 RTL (Right-to-Left) layout support
- 🌟 Your custom branding
- 🌟 Simplified user interface
- 🌟 Desktop packaging capability

## 📚 Project Structure

```
simple-doc-manager/
├── src/                          # Backend (Django/Python)
│   ├── documents/                # Core document management
│   ├── paperless/               # Main settings and config
│   └── paperless_consumer/     # File processing
├── src-ui/                      # Frontend (Angular/TypeScript)
│   ├── src/app/components/      # UI components
│   ├── src/locale/             # Translation files
│   └── src/styles.scss         # Global styling
├── electron/                    # Desktop packaging (you'll create this)
├── backups/                     # Auto-created backups
└── *.sh                        # Helper scripts
```

## 🔧 Daily Development Commands

```bash
# Start development environment
docker-compose -f docker/compose/docker-compose.dev.yml up -d

# Stop everything
docker-compose -f docker/compose/docker-compose.dev.yml down

# Restart after backend changes
docker-compose -f docker/compose/docker-compose.dev.yml restart

# Rebuild frontend after UI changes
cd src-ui && npm run build && cd ..

# View logs
docker-compose -f docker/compose/docker-compose.dev.yml logs -f

# If things break, reset everything:
./fix-common-issues.sh
```

## 🗺️ Development Roadmap

### Week 1: Foundation
- [x] Fork and setup development environment
- [x] Apply first modifications (Arabic fonts, branding)
- [x] Remove mail management features
- [ ] Test and commit changes

### Week 2: Major Simplification
- [ ] Remove ML features from backend
- [ ] Simplify document models
- [ ] Remove advanced filtering UI
- [ ] Simplify dashboard

### Week 3: Arabic Translation
- [ ] Configure Angular i18n
- [ ] Create Arabic translation files
- [ ] Implement full RTL layout
- [ ] Test Arabic interface

### Week 4: Desktop Packaging
- [ ] Set up Electron wrapper
- [ ] Create build scripts
- [ ] Test .exe generation
- [ ] Create USB-portable version

### Week 5: Polish & Deploy
- [ ] Final testing
- [ ] User documentation
- [ ] Distribution packaging
- [ ] Launch! 🚀

## 🎨 Customization Guide

### Change App Colors
Edit `src-ui/src/styles.scss`:
```scss
:root {
  --primary-color: #your-color;
  --accent-color: #your-accent;
}
```

### Update App Name
Edit `src-ui/src/app/components/common/page-header/page-header.component.html`:
```html
<span class="title">Your App Name</span>
```

### Add Your Logo
1. Add logo file to `src-ui/src/assets/`
2. Update references in components

## 🚨 Troubleshooting

**Can't access localhost:8000?**
- Wait 5 minutes after first startup
- Check Docker Desktop is running
- Run: `./fix-common-issues.sh`

**Build errors?**
```bash
# Reset everything:
docker-compose -f docker/compose/docker-compose.dev.yml down -v
docker system prune -f
./fix-common-issues.sh
```

**Frontend issues?**
```bash
cd src-ui
rm -rf node_modules package-lock.json
npm install
npm run build
```

## 📖 Detailed Guides

- `paperless-ngx-simplification-guide.md` - Complete step-by-step customization
- `START-HERE.md` - Immediate action plan for today

## 🤝 Need Help?

1. Check the troubleshooting section above
2. Run `./fix-common-issues.sh`
3. Look at paperless-ngx documentation
4. Ask for help with specific error messages

## 🎉 Success Metrics

By the end of this project, you'll have:
- ✅ A working Arabic document management system
- ✅ Simplified interface for non-technical users  
- ✅ Desktop .exe application
- ✅ USB-portable installation
- ✅ Your own branded product

**Ready to build something amazing? Let's go! 🔥**
