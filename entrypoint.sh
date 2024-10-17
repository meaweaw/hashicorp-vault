#!/bin/sh

# Start Vault in server mode
vault server -config=/vault/config/vault-config.hcl &

# Wait for Vault to start
sleep 5

# Unseal Vault using the environment variable
if [ -z "$UNSEAL_KEY" ]; then
    echo "UNSEAL_KEY environment variable is not set."
    exit 1
fi

vault operator unseal "$UNSEAL_KEY"

# Authenticate with Vault using the root token from the environment variable
if [ -z "$ROOT_TOKEN" ]; then
    echo "ROOT_TOKEN environment variable is not set."
    exit 1
fi

vault login "$ROOT_TOKEN"

# Optionally: Create a function to save the current configuration
save_config() {
    # This command will retrieve the current configuration and save it
    vault read -format=json sys/config > /vault/config/current-config.json
    echo "Vault configuration saved."
}

# Call the function to save the configuration
save_config

# Keep the script running to allow Vault to serve requests
wait