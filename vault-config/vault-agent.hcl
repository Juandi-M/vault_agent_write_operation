# PID file for the Vault Agent process
pid_file = "/tmp/vault-agent.pid"

# Exit container after sink auth.
exit_after_auth = false

# Auto-auth config to automatically authenticate and renew a token
auto_auth {
  # Use the token_file method to read a token from a file. Time to wait between retries if auth fails
  method "token_file" {
    min_backoff = "60s" 
    max_backoff = "120s"
    config {
      token_file_path = "/etc/vault.d/.vault-token"
    }
  }
  # Fallback method: approle
    // method {
    //   type = "approle"
    //   config = {
    //     role_id_file_path   = "/path/to/role-id"
    //     secret_id_file_path = "/path/to/secret-id"
    //     remove_after_reading = {
    //       role_id   = true
    //       secret_id = true
    //     }
    //   }
    // }

  # Write the token to the same file sink
  sink "file" {
    config {
      path = "/etc/vault.d/.vault-token" 
    }
  }
}

# Listener to accept new tokens over TCP
listener "tcp" {
  address = "127.0.0.1:8200"
  tls_disable = true

  # Allow token auth on the /vault/login path
  auth_method "token" {
    path = "/vault/login"
  }
}

template_config {
  // Determines the behavior when template rendering retries fail.
  // If set to true, Vault Agent will exit if it cannot successfully render a template after all retry attempts.
  exit_on_retry_failure = true
  
  // Specifies the frequency at which static secrets (secrets without a lease) are re-rendered in templates.
  // In this case, static secrets are re-rendered every 1 minute.
  static_secret_render_interval = "1m"
}

# Template config to render templates
template {
  source      = "/etc/vault.d/appconfigs.ctmpl" 
  destination = "/home/vault/appconfigs.json"

  # Fail if keys are missing
  error_on_missing_key = true
}