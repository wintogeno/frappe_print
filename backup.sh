#!/bin/bash




# Define variables
CONTAINER_NAME="pwd_backend_1"
SITE_NAME="erp.com"  # Replace with your actual site name
BACKUP_DIR="/home/frappe/frappe-bench/sites/$SITE_NAME/private/backups"  # Adjust the path if needed
HOST_BACKUP_DIR="/home/frappe/frappe_docker/"  # Replace with the desired host 

# Run the backup command inside the container
echo "Running backup inside the container $CONTAINER_NAME..."
docker exec "$CONTAINER_NAME" bench --site "$SITE_NAME" backup --with-files

# Check if the backup command was successful
if [ $? -ne 0 ]; then
    echo "Backup failed inside the container."
    exit 1
fi

# Create the host backup directory if it doesn't exist
#mkdir -p "$HOST_BACKUP_DIR"

# Copy the backup files from the container to the host
echo "Copying backup files to host directory $HOST_BACKUP_DIR..."
docker cp "$CONTAINER_NAME:$BACKUP_DIR" "$HOST_BACKUP_DIR"

# Check if the copy command was successful
if [ $? -eq 0 ]; then
    echo "Backup files successfully copied to host."
else
    echo "Failed to copy backup files to host."
    exit 1
fi
