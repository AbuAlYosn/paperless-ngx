#!/bin/bash

echo "🔧 Paperless-ngx Development Troubleshooter"
echo "==========================================="

# Function to check Docker
check_docker() {
    if ! command -v docker &> /dev/null; then
        echo "❌ Docker not found. Please install Docker Desktop first."
        echo "   Download from: https://www.docker.com/products/docker-desktop/"
        return 1
    fi
    
    if ! docker info &> /dev/null; then
        echo "❌ Docker is not running. Please start Docker Desktop."
        return 1
    fi
    
    echo "✅ Docker is running"
    return 0
}

# Function to reset development environment
reset_environment() {
    echo "🔄 Resetting development environment..."
    
    # Stop all containers
    docker-compose -f docker/compose/docker-compose.dev.yml down -v
    
    # Clean up Docker
    docker system prune -f
    
    # Remove frontend dependencies
    if [ -d "src-ui/node_modules" ]; then
        echo "🧹 Cleaning frontend dependencies..."
        rm -rf src-ui/node_modules
        rm -f src-ui/package-lock.json
    fi
    
    echo "✅ Environment reset complete"
}

# Function to restart everything fresh
fresh_start() {
    echo "🚀 Starting fresh development environment..."
    
    # Install frontend dependencies
    cd src-ui
    npm install
    npm run build
    cd ..
    
    # Start the development environment
    docker-compose -f docker/compose/docker-compose.dev.yml up -d
    
    echo "⏳ Waiting for services to start..."
    sleep 30
    
    echo "🌟 Development environment should be ready!"
    echo "   Visit: http://localhost:8000"
    echo "   Login: admin / admin"
}

# Function to check if services are running
check_services() {
    echo "🔍 Checking service status..."
    
    # Check if containers are running
    if docker-compose -f docker/compose/docker-compose.dev.yml ps | grep -q "Up"; then
        echo "✅ Docker containers are running"
    else
        echo "❌ Docker containers are not running"
        return 1
    fi
    
    # Check if web interface is accessible
    if curl -s http://localhost:8000 > /dev/null; then
        echo "✅ Web interface is accessible"
    else
        echo "❌ Web interface is not accessible"
        echo "   Try waiting a few more minutes or check logs"
    fi
}

# Function to show logs
show_logs() {
    echo "📋 Showing recent logs..."
    docker-compose -f docker/compose/docker-compose.dev.yml logs --tail=50
}

# Main menu
echo ""
echo "What would you like to do?"
echo "1) Check if Docker is working"
echo "2) Reset everything and start fresh"
echo "3) Check service status"
echo "4) Show logs"
echo "5) Quick restart"
echo "6) Exit"

read -p "Choose an option (1-6): " choice

case $choice in
    1)
        check_docker
        ;;
    2)
        if check_docker; then
            reset_environment
            fresh_start
        fi
        ;;
    3)
        check_services
        ;;
    4)
        show_logs
        ;;
    5)
        echo "🔄 Quick restart..."
        docker-compose -f docker/compose/docker-compose.dev.yml restart
        echo "✅ Restarted. Give it a minute to come back up."
        ;;
    6)
        echo "👋 Happy coding!"
        exit 0
        ;;
    *)
        echo "❌ Invalid option"
        ;;
esac