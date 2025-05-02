#!/bin/sh

# Ensure unbuffered output
export PYTHONUNBUFFERED=1
exec > >(tee -a /var/log/entrypoint.log)
exec 2>&1

echo "=== Starting Entrypoint ==="

WATCH_DIR="/app/temp-src/src"	
UPDATE_DIR="/app/vt-app/src"	

sync_files() {
    local delay=1
    
        echo "Syncing files from temp-src to src ..."
        
        rsync -a --delete --exclude=node_modules "$WATCH_DIR"/ "$UPDATE_DIR"/ && return 0

        
        echo "Sync failed, retrying in $delay seconds..."
        sleep $delay

    
    return 1
}

sync_files

# Copy from temp-src to src (excluding node_modules)
#rsync -a --delete --exclude=node_modules /app/temp-src/src/ /app/vt-app/src/

# Install dependencies if package.json changed
if [ -f /app/temp-src/package.json ]; then
	echo "Copying package.json from temp-src to src..."
    if ! cmp -s /app/temp-src/package.json /app/vt-app/package.json; then
        echo "package.json changed, installing dependencies..."
        cp /app/temp-src/package.json /app/vt-app/
        cp /app/temp-src/package-lock.json /app/vt-app/ 2>/dev/null || true
        npm install
    fi
fi


# Start watching for canges in background
if [ "$WATCH_SRC" = "true" ]; then
    echo "Watching for source changes..."
	#working
	while true; do
        inotifywait -r -e modify,create,delete,move --timeout 5 "$WATCH_DIR" || true
		    echo "Calling sync for changes..."
        sync_files
    done &		
	
	#inotifywait -m -r -e modify,create,delete "$WATCH_DIR" | while read path action file; do
	#	echo "Detected $action on $file in $path"
	#	sync_files
	#done &
	
	
	
    #inotifywait -m -e modify,create,delete,move /app/temp-src/src |     while read path action file; do
    #    echo "Detected change in $file - copying to src..."
    #    rsync -a --delete --exclude=node_modules /app/temp-src/src/ /app/vt-app/src/
    #done &	
	
fi

echo "=== ending Entrypoint ==="
# Start the application
exec "$@"